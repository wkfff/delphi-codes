unit FastMM4;

interface

{-------------------------Public constants-----------------------------}
const
  {The current version of FastMM}
  FastMMVersion = '4.991';
  {The number of small block types}
{$ifdef Align16Bytes}
  NumSmallBlockTypes = 46;
{$else}
  NumSmallBlockTypes = 56;
{$endif}

{----------------------------Public types------------------------------}
type
  PByte = PAnsiChar;
  NativeInt = Integer;
  NativeUInt = Cardinal;
  PNativeUInt = ^Cardinal;
  IntPtr = Integer;
  UIntPtr = Cardinal;

  TSmallBlockTypeState = record
    {The internal size of the block type}
    InternalBlockSize: Cardinal;
    {Useable block size: The number of non-reserved bytes inside the block.}
    UseableBlockSize: Cardinal;
    {The number of allocated blocks}
    AllocatedBlockCount: NativeUInt;
    {The total address space reserved for this block type (both allocated and
     free blocks)}
    ReservedAddressSpace: NativeUInt;
  end;
  TSmallBlockTypeStates = array[0..NumSmallBlockTypes - 1] of TSmallBlockTypeState;

{-------------------------Public procedures----------------------------}
procedure InitializeMemoryManager;
procedure InstallMemoryManager;

{The standard memory manager functions}
function FastGetMem(ASize: {$ifdef XE2AndUp}NativeInt{$else}Integer{$endif}): Pointer;
function FastFreeMem(APointer: Pointer): Integer;
function FastReallocMem(APointer: Pointer; ANewSize: {$ifdef XE2AndUp}NativeInt{$else}Integer{$endif}): Pointer;
function FastAllocMem(ASize: {$ifdef XE2AndUp}NativeInt{$else}Cardinal{$endif}): Pointer;

implementation

uses
  Windows, FastMM4Messages;

{Fixed size move procedures. The 64-bit versions assume 16-byte alignment.}
procedure Move4(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move12(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move20(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move28(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move36(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move44(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move52(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move60(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move68(const ASource; var ADest; ACount: NativeInt); forward;
{$ifdef 64Bit}
{These are not needed and thus unimplemented under 32-bit}
procedure Move8(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move24(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move40(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move56(const ASource; var ADest; ACount: NativeInt); forward;
{$endif}


{-------------------------Private constants----------------------------}
const
  {The size of a medium block pool. This is allocated through VirtualAlloc and
   is used to serve medium blocks. The size must be a multiple of 16 and at
   least 4 bytes less than a multiple of 4K (the page size) to prevent a
   possible read access violation when reading past the end of a memory block
   in the optimized move routine (MoveX16LP). In Full Debug mode we leave a
   trailing 256 bytes to be able to safely do a memory dump.}
  MediumBlockPoolSize = 20 * 64 * 1024{$ifndef FullDebugMode} - 16{$else} - 256{$endif};
  {The granularity of small blocks}
{$ifdef Align16Bytes}
  SmallBlockGranularity = 16;
{$else}
  SmallBlockGranularity = 8;
{$endif}
  {The granularity of medium blocks. Newly allocated medium blocks are
   a multiple of this size plus MediumBlockSizeOffset, to avoid cache line
   conflicts}
  MediumBlockGranularity = 256;
  MediumBlockSizeOffset = 48;
  {The granularity of large blocks}
  LargeBlockGranularity = 65536;
  {The maximum size of a small block. Blocks Larger than this are either
   medium or large blocks.}
  MaximumSmallBlockSize = 2608;
  {The smallest medium block size. (Medium blocks are rounded up to the nearest
   multiple of MediumBlockGranularity plus MediumBlockSizeOffset)}
  MinimumMediumBlockSize = 11 * 256 + MediumBlockSizeOffset;
  {The number of bins reserved for medium blocks}
  MediumBlockBinsPerGroup = 32;
  MediumBlockBinGroupCount = 32;
  MediumBlockBinCount = MediumBlockBinGroupCount * MediumBlockBinsPerGroup;
  {The maximum size allocatable through medium blocks. Blocks larger than this
   fall through to VirtualAlloc ( = large blocks).}
  MaximumMediumBlockSize = MinimumMediumBlockSize + (MediumBlockBinCount - 1) * MediumBlockGranularity;
  {The target number of small blocks per pool. The actual number of blocks per
   pool may be much greater for very small sizes and less for larger sizes. The
   cost of allocating the small block pool is amortized across all the small
   blocks in the pool, however the blocks may not all end up being used so they
   may be lying idle.}
  TargetSmallBlocksPerPool = 48;
  {The minimum number of small blocks per pool. Any available medium block must
   have space for roughly this many small blocks (or more) to be useable as a
   small block pool.}
  MinimumSmallBlocksPerPool = 12;
  {The lower and upper limits for the optimal small block pool size}
  OptimalSmallBlockPoolSizeLowerLimit = 29 * 1024 - MediumBlockGranularity + MediumBlockSizeOffset;
  OptimalSmallBlockPoolSizeUpperLimit = 64 * 1024 - MediumBlockGranularity + MediumBlockSizeOffset;
  {The maximum small block pool size. If a free block is this size or larger
   then it will be split.}
  MaximumSmallBlockPoolSize = OptimalSmallBlockPoolSizeUpperLimit + MinimumMediumBlockSize;
  {-------------Block type flags--------------}
  {The lower 3 bits in the dword header of small blocks (4 bits in medium and
   large blocks) are used as flags to indicate the state of the block}
  {Set if the block is not in use}
  IsFreeBlockFlag = 1;
  {Set if this is a medium block}
  IsMediumBlockFlag = 2;
  {Set if it is a medium block being used as a small block pool. Only valid if
   IsMediumBlockFlag is set.}
  IsSmallBlockPoolInUseFlag = 4;
  {Set if it is a large block. Only valid if IsMediumBlockFlag is not set.}
  IsLargeBlockFlag = 4;
  {Is the medium block preceding this block available? (Only used by medium
   blocks)}
  PreviousMediumBlockIsFreeFlag = 8;
  {Is this large block segmented? I.e. is it actually built up from more than
   one chunk allocated through VirtualAlloc? (Only used by large blocks.)}
  LargeBlockIsSegmented = 8;
  {The flags masks for small blocks}
  DropSmallFlagsMask = -8;
  ExtractSmallFlagsMask = 7;
  {The flags masks for medium and large blocks}
  DropMediumAndLargeFlagsMask = -16;
  ExtractMediumAndLargeFlagsMask = 15;
  {-------------Block resizing constants---------------}
  SmallBlockDownsizeCheckAdder = 64;
  SmallBlockUpsizeAdder = 32;
  {When a medium block is reallocated to a size smaller than this, then it must
   be reallocated to a small block and the data moved. If not, then it is
   shrunk in place down to MinimumMediumBlockSize. Currently the limit is set
   at a quarter of the minimum medium block size.}
  MediumInPlaceDownsizeLimit = MinimumMediumBlockSize div 4;
  {-------------Other constants---------------}
{$ifndef NeverSleepOnThreadContention}
  {Sleep time when a resource (small/medium/large block manager) is in use}
  InitialSleepTime = 0;
  {Used when the resource is still in use after the first sleep}
  AdditionalSleepTime = 1;
{$endif}

{-------------------------Private types----------------------------}
type
  PPointer = ^Pointer;

  {Move procedure type}
  TMoveProc = procedure(const ASource; var ADest; ACount: NativeInt);

  {---------------Small block structures-------------}

  {Pointer to the header of a small block pool}
  PSmallBlockPoolHeader = ^TSmallBlockPoolHeader;

  {Small block type (Size = 32 bytes for 32-bit, 64 bytes for 64-bit).}
  PSmallBlockType = ^TSmallBlockType;
  TSmallBlockType = record
    {True = Block type is locked}
    BlockTypeLocked: Boolean;
    {Bitmap indicating which of the first 8 medium block groups contain blocks
     of a suitable size for a block pool.}
    AllowedGroupsForBlockPoolBitmap: Byte;
    {The block size for this block type}
    BlockSize: Word;
    {The minimum and optimal size of a small block pool for this block type}
    MinimumBlockPoolSize: Word;
    OptimalBlockPoolSize: Word;
    {The first partially free pool for the given small block. This field must
     be at the same offset as TSmallBlockPoolHeader.NextPartiallyFreePool.}
    NextPartiallyFreePool: PSmallBlockPoolHeader;
    {The last partially free pool for the small block type. This field must
     be at the same offset as TSmallBlockPoolHeader.PreviousPartiallyFreePool.}
    PreviousPartiallyFreePool: PSmallBlockPoolHeader;
    {The offset of the last block that was served sequentially. The field must
     be at the same offset as TSmallBlockPoolHeader.FirstFreeBlock.}
    NextSequentialFeedBlockAddress: Pointer;
    {The last block that can be served sequentially.}
    MaxSequentialFeedBlockAddress: Pointer;
    {The pool that is current being used to serve blocks in sequential order}
    CurrentSequentialFeedPool: PSmallBlockPoolHeader;
{$ifdef UseCustomFixedSizeMoveRoutines}
    {The fixed size move procedure used to move data for this block size when
     it is upsized. When a block is downsized (which usually does not occur
     that often) the variable size move routine is used.}
    UpsizeMoveProcedure: TMoveProc;
{$else}
    Reserved1: Pointer;
{$endif}
{$ifdef 64Bit}
    {Pad to 64 bytes for 64-bit}
    Reserved2: Pointer;
{$endif}
  end;

  {Small block pool (Size = 32 bytes for 32-bit, 48 bytes for 64-bit).}
  TSmallBlockPoolHeader = record
    {BlockType}
    BlockType: PSmallBlockType;
{$ifdef 32Bit}
    {Align the next fields to the same fields in TSmallBlockType and pad this
     structure to 32 bytes for 32-bit}
    Reserved1: Cardinal;
{$endif}
    {The next and previous pool that has free blocks of this size. Do not
     change the position of these two fields: They must be at the same offsets
     as the fields in TSmallBlockType of the same name.}
    NextPartiallyFreePool: PSmallBlockPoolHeader;
    PreviousPartiallyFreePool: PSmallBlockPoolHeader;
    {Pointer to the first free block inside this pool. This field must be at
     the same offset as TSmallBlockType.NextSequentialFeedBlockAddress.}
    FirstFreeBlock: Pointer;
    {The number of blocks allocated in this pool.}
    BlocksInUse: Cardinal;
    {Padding}
    Reserved2: Cardinal;
    {The pool pointer and flags of the first block}
    FirstBlockPoolPointerAndFlags: NativeUInt;
  end;

  {Small block layout:
   At offset -SizeOf(Pointer) = Flags + address of the small block pool.
   At offset BlockSize - SizeOf(Pointer) = Flags + address of the small block
   pool for the next small block.
  }

  {------------------------Medium block structures------------------------}

  {The medium block pool from which medium blocks are drawn. Size = 16 bytes
   for 32-bit and 32 bytes for 64-bit.}
  PMediumBlockPoolHeader = ^TMediumBlockPoolHeader;
  TMediumBlockPoolHeader = record
    {Points to the previous and next medium block pools. This circular linked
     list is used to track memory leaks on program shutdown.}
    PreviousMediumBlockPoolHeader: PMediumBlockPoolHeader;
    NextMediumBlockPoolHeader: PMediumBlockPoolHeader;
    {Padding}
    Reserved1: NativeUInt;
    {The block size and flags of the first medium block in the block pool}
    FirstMediumBlockSizeAndFlags: NativeUInt;
  end;

  {Medium block layout:
   Offset: -2 * SizeOf(Pointer) = Previous Block Size (only if the previous block is free)
   Offset: -SizeOf(Pointer) = This block size and flags
   Offset: 0 = User data / Previous Free Block (if this block is free)
   Offset: SizeOf(Pointer) = Next Free Block (if this block is free)
   Offset: BlockSize - 2*SizeOf(Pointer) = Size of this block (if this block is free)
   Offset: BlockSize - SizeOf(Pointer) = Size of the next block and flags

  {A medium block that is unused}
  PMediumFreeBlock = ^TMediumFreeBlock;
  TMediumFreeBlock = record
    PreviousFreeBlock: PMediumFreeBlock;
    NextFreeBlock: PMediumFreeBlock;
  end;

  {-------------------------Large block structures------------------------}

  {Large block header record (Size = 16 for 32-bit, 32 for 64-bit)}
  PLargeBlockHeader = ^TLargeBlockHeader;
  TLargeBlockHeader = record
    {Points to the previous and next large blocks. This circular linked
     list is used to track memory leaks on program shutdown.}
    PreviousLargeBlockHeader: PLargeBlockHeader;
    NextLargeBlockHeader: PLargeBlockHeader;
    {The user allocated size of the Large block}
    UserAllocatedSize: NativeUInt;
    {The size of this block plus the flags}
    BlockSizeAndFlags: NativeUInt;
  end;

{-------------------------Private constants----------------------------}
const
{$ifndef BCB6OrDelphi7AndUp}
  reOutOfMemory = 1;
  reInvalidPtr = 2;
{$endif}
  {The size of the block header in front of small and medium blocks}
  BlockHeaderSize = SizeOf(Pointer);
  {The size of a small block pool header}
  SmallBlockPoolHeaderSize = SizeOf(TSmallBlockPoolHeader);
  {The size of a medium block pool header}
  MediumBlockPoolHeaderSize = SizeOf(TMediumBlockPoolHeader);
  {The size of the header in front of Large blocks}
  LargeBlockHeaderSize = SizeOf(TLargeBlockHeader);

{-------------------------Private variables----------------------------}
var
  {-----------------Small block management------------------}
  {The small block types. Sizes include the leading header. Sizes are
   picked to limit maximum wastage to about 10% or 256 bytes (whichever is
   less) where possible.}
  SmallBlockTypes: array[0..NumSmallBlockTypes - 1] of TSmallBlockType =(
    {8/16 byte jumps}
{$ifndef Align16Bytes}
    (BlockSize: 8 {$ifdef UseCustomFixedSizeMoveRoutines}; UpsizeMoveProcedure: Move4{$endif}),
{$endif}
    (BlockSize: 16 {$ifdef UseCustomFixedSizeMoveRoutines}; UpsizeMoveProcedure: {$ifdef 32Bit}Move12{$else}Move8{$endif}{$endif}),
{$ifndef Align16Bytes}
    (BlockSize: 24 {$ifdef UseCustomFixedSizeMoveRoutines}; UpsizeMoveProcedure: Move20{$endif}),
{$endif}
    (BlockSize: 32 {$ifdef UseCustomFixedSizeMoveRoutines}; UpsizeMoveProcedure: {$ifdef 32Bit}Move28{$else}Move24{$endif}{$endif}),
{$ifndef Align16Bytes}
    (BlockSize: 40 {$ifdef UseCustomFixedSizeMoveRoutines}; UpsizeMoveProcedure: Move36{$endif}),
{$endif}
    (BlockSize: 48 {$ifdef UseCustomFixedSizeMoveRoutines}; UpsizeMoveProcedure: {$ifdef 32Bit}Move44{$else}Move40{$endif}{$endif}),
{$ifndef Align16Bytes}
    (BlockSize: 56 {$ifdef UseCustomFixedSizeMoveRoutines}; UpsizeMoveProcedure: Move52{$endif}),
{$endif}
    (BlockSize: 64 {$ifdef UseCustomFixedSizeMoveRoutines}; UpsizeMoveProcedure: {$ifdef 32Bit}Move60{$else}Move56{$endif}{$endif}),
{$ifndef Align16Bytes}
    (BlockSize: 72 {$ifdef UseCustomFixedSizeMoveRoutines}; UpsizeMoveProcedure: Move68{$endif}),
{$endif}
    (BlockSize: 80),
{$ifndef Align16Bytes}
    (BlockSize: 88),
{$endif}
    (BlockSize: 96),
{$ifndef Align16Bytes}
    (BlockSize: 104),
{$endif}
    (BlockSize: 112),
{$ifndef Align16Bytes}
    (BlockSize: 120),
{$endif}
    (BlockSize: 128),
{$ifndef Align16Bytes}
    (BlockSize: 136),
{$endif}
    (BlockSize: 144),
{$ifndef Align16Bytes}
    (BlockSize: 152),
{$endif}
    (BlockSize: 160),
    {16 byte jumps}
    (BlockSize: 176),
    (BlockSize: 192),
    (BlockSize: 208),
    (BlockSize: 224),
    (BlockSize: 240),
    (BlockSize: 256),
    (BlockSize: 272),
    (BlockSize: 288),
    (BlockSize: 304),
    (BlockSize: 320),
    {32 byte jumps}
    (BlockSize: 352),
    (BlockSize: 384),
    (BlockSize: 416),
    (BlockSize: 448),
    (BlockSize: 480),
    {48 byte jumps}
    (BlockSize: 528),
    (BlockSize: 576),
    (BlockSize: 624),
    (BlockSize: 672),
    {64 byte jumps}
    (BlockSize: 736),
    (BlockSize: 800),
    {80 byte jumps}
    (BlockSize: 880),
    (BlockSize: 960),
    {96 byte jumps}
    (BlockSize: 1056),
    (BlockSize: 1152),
    {112 byte jumps}
    (BlockSize: 1264),
    (BlockSize: 1376),
    {128 byte jumps}
    (BlockSize: 1504),
    {144 byte jumps}
    (BlockSize: 1648),
    {160 byte jumps}
    (BlockSize: 1808),
    {176 byte jumps}
    (BlockSize: 1984),
    {192 byte jumps}
    (BlockSize: 2176),
    {208 byte jumps}
    (BlockSize: 2384),
    {224 byte jumps}
    (BlockSize: MaximumSmallBlockSize),
    {The last block size occurs three times. If, during a GetMem call, the
     requested block size is already locked by another thread then up to two
     larger block sizes may be used instead. Having the last block size occur
     three times avoids the need to have a size overflow check.}
    (BlockSize: MaximumSmallBlockSize),
    (BlockSize: MaximumSmallBlockSize));
  {Size to small block type translation table}
  AllocSize2SmallBlockTypeIndX4: array[0..(MaximumSmallBlockSize - 1) div SmallBlockGranularity] of Byte;
  {-----------------Medium block management------------------}
  {A dummy medium block pool header: Maintains a circular list of all medium
   block pools to enable memory leak detection on program shutdown.}
  MediumBlockPoolsCircularList: TMediumBlockPoolHeader;
  {Are medium blocks locked?}
  MediumBlocksLocked: Boolean;
  {The sequential feed medium block pool.}
  LastSequentiallyFedMediumBlock: Pointer;
  MediumSequentialFeedBytesLeft: Cardinal;
  {The medium block bins are divided into groups of 32 bins. If a bit
   is set in this group bitmap, then at least one bin in the group has free
   blocks.}
  MediumBlockBinGroupBitmap: Cardinal;
  {The medium block bins: total of 32 * 32 = 1024 bins of a certain
   minimum size.}
  MediumBlockBinBitmaps: array[0..MediumBlockBinGroupCount - 1] of Cardinal;
  {The medium block bins. There are 1024 LIFO circular linked lists each
   holding blocks of a specified minimum size. The sizes vary in size from
   MinimumMediumBlockSize to MaximumMediumBlockSize. The bins are treated as
   type TMediumFreeBlock to avoid pointer checks.}
  MediumBlockBins: array[0..MediumBlockBinCount - 1] of TMediumFreeBlock;
  {-----------------Large block management------------------}
  {Are large blocks locked?}
  LargeBlocksLocked: Boolean;
  {A dummy large block header: Maintains a list of all allocated large blocks
   to enable memory leak detection on program shutdown.}
  LargeBlocksCircularList: TLargeBlockHeader;
  {-------------------------Expected Memory Leak Structures--------------------}

  {--------------Other info--------------}
  {The memory manager that was replaced}
  OldMemoryManager: {$ifndef BDS2006AndUp}TMemoryManager{$else}TMemoryManagerEx{$endif};
  {The replacement memory manager}
  NewMemoryManager: {$ifndef BDS2006AndUp}TMemoryManager{$else}TMemoryManagerEx{$endif};

  {Has FastMM been installed?}
  FastMMIsInstalled: Boolean;
  {Is the MM in place a shared memory manager?}
  IsMemoryManagerOwner: Boolean;
  {Must MMX be used for move operations?}
  UseMMX: Boolean;

{----------------Utility Functions------------------}

{Compare [AAddress], CompareVal:
 If Equal: [AAddress] := NewVal and result = CompareVal
 If Unequal: Result := [AAddress]}
function LockCmpxchg(CompareVal, NewVal: Byte; AAddress: PByte): Byte;
asm
{$ifdef 32Bit}
  {On entry:
    al = CompareVal,
    dl = NewVal,
    ecx = AAddress}
  {$ifndef LINUX}
  lock cmpxchg [ecx], dl
  {$else}
  {Workaround for Kylix compiler bug}
  db $F0, $0F, $B0, $11
  {$endif}
{$else}
  {On entry:
    cl = CompareVal
    dl = NewVal
    r8 = AAddress}
  .noframe
  mov rax, rcx
  lock cmpxchg [r8], dl
{$endif}
end;

{$ifndef ASMVersion}
{Gets the first set bit in the 32-bit number, returning the bit index}
function FindFirstSetBit(ACardinal: Cardinal): Cardinal;
asm
{$ifdef 64Bit}
  .noframe
  mov rax, rcx
{$endif}
  bsf eax, eax
end;
{$endif}

{----------------Faster Move Procedures-------------------}

{Fixed size move operations ignore the size parameter. All moves are assumed to
 be non-overlapping.}

procedure Move4(const ASource; var ADest; ACount: NativeInt);
asm
{$ifdef 32Bit}
  mov eax, [eax]
  mov [edx], eax
{$else}
.noframe
  mov eax, [rcx]
  mov [rdx], eax
{$endif}
end;

{$ifdef 64Bit}
procedure Move8(const ASource; var ADest; ACount: NativeInt);
asm
  mov rax, [rcx]
  mov [rdx], rax
end;
{$endif}

procedure Move12(const ASource; var ADest; ACount: NativeInt);
asm
{$ifdef 32Bit}
  mov ecx, [eax]
  mov [edx], ecx
  mov ecx, [eax + 4]
  mov eax, [eax + 8]
  mov [edx + 4], ecx
  mov [edx + 8], eax
{$else}
.noframe
  mov rax, [rcx]
  mov ecx, [rcx + 8]
  mov [rdx], rax
  mov [rdx + 8], ecx
{$endif}
end;

procedure Move20(const ASource; var ADest; ACount: NativeInt);
asm
{$ifdef 32Bit}
  mov ecx, [eax]
  mov [edx], ecx
  mov ecx, [eax + 4]
  mov [edx + 4], ecx
  mov ecx, [eax + 8]
  mov [edx + 8], ecx
  mov ecx, [eax + 12]
  mov eax, [eax + 16]
  mov [edx + 12], ecx
  mov [edx + 16], eax
{$else}
.noframe
  movdqa xmm0, [rcx]
  mov ecx, [rcx + 16]
  movdqa [rdx], xmm0
  mov [rdx + 16], ecx
{$endif}
end;

{$ifdef 64Bit}
procedure Move24(const ASource; var ADest; ACount: NativeInt);
asm
  movdqa xmm0, [rcx]
  mov r8, [rcx + 16]
  movdqa [rdx], xmm0
  mov [rdx + 16], r8
end;
{$endif}

procedure Move28(const ASource; var ADest; ACount: NativeInt);
asm
{$ifdef 32Bit}
  mov ecx, [eax]
  mov [edx], ecx
  mov ecx, [eax + 4]
  mov [edx + 4], ecx
  mov ecx, [eax + 8]
  mov [edx + 8], ecx
  mov ecx, [eax + 12]
  mov [edx + 12], ecx
  mov ecx, [eax + 16]
  mov [edx + 16], ecx
  mov ecx, [eax + 20]
  mov eax, [eax + 24]
  mov [edx + 20], ecx
  mov [edx + 24], eax
{$else}
.noframe
  movdqa xmm0, [rcx]
  mov r8, [rcx + 16]
  mov ecx, [rcx + 24]
  movdqa [rdx], xmm0
  mov [rdx + 16], r8
  mov [rdx + 24], ecx
{$endif}
end;

procedure Move36(const ASource; var ADest; ACount: NativeInt);
asm
{$ifdef 32Bit}
  fild qword ptr [eax]
  fild qword ptr [eax + 8]
  fild qword ptr [eax + 16]
  fild qword ptr [eax + 24]
  mov ecx, [eax + 32]
  mov [edx + 32], ecx
  fistp qword ptr [edx + 24]
  fistp qword ptr [edx + 16]
  fistp qword ptr [edx + 8]
  fistp qword ptr [edx]
{$else}
.noframe
  movdqa xmm0, [rcx]
  movdqa xmm1, [rcx + 16]
  mov ecx, [rcx + 32]
  movdqa [rdx], xmm0
  movdqa [rdx + 16], xmm1
  mov [rdx + 32], ecx
{$endif}
end;

{$ifdef 64Bit}
procedure Move40(const ASource; var ADest; ACount: NativeInt);
asm
  movdqa xmm0, [rcx]
  movdqa xmm1, [rcx + 16]
  mov r8, [rcx + 32]
  movdqa [rdx], xmm0
  movdqa [rdx + 16], xmm1
  mov [rdx + 32], r8
end;
{$endif}

procedure Move44(const ASource; var ADest; ACount: NativeInt);
asm
{$ifdef 32Bit}
  fild qword ptr [eax]
  fild qword ptr [eax + 8]
  fild qword ptr [eax + 16]
  fild qword ptr [eax + 24]
  fild qword ptr [eax + 32]
  mov ecx, [eax + 40]
  mov [edx + 40], ecx
  fistp qword ptr [edx + 32]
  fistp qword ptr [edx + 24]
  fistp qword ptr [edx + 16]
  fistp qword ptr [edx + 8]
  fistp qword ptr [edx]
{$else}
.noframe
  movdqa xmm0, [rcx]
  movdqa xmm1, [rcx + 16]
  mov r8, [rcx + 32]
  mov ecx, [rcx + 40]
  movdqa [rdx], xmm0
  movdqa [rdx + 16], xmm1
  mov [rdx + 32], r8
  mov [rdx + 40], ecx
{$endif}
end;

procedure Move52(const ASource; var ADest; ACount: NativeInt);
asm
{$ifdef 32Bit}
  fild qword ptr [eax]
  fild qword ptr [eax + 8]
  fild qword ptr [eax + 16]
  fild qword ptr [eax + 24]
  fild qword ptr [eax + 32]
  fild qword ptr [eax + 40]
  mov ecx, [eax + 48]
  mov [edx + 48], ecx
  fistp qword ptr [edx + 40]
  fistp qword ptr [edx + 32]
  fistp qword ptr [edx + 24]
  fistp qword ptr [edx + 16]
  fistp qword ptr [edx + 8]
  fistp qword ptr [edx]
{$else}
.noframe
  movdqa xmm0, [rcx]
  movdqa xmm1, [rcx + 16]
  movdqa xmm2, [rcx + 32]
  mov ecx, [rcx + 48]
  movdqa [rdx], xmm0
  movdqa [rdx + 16], xmm1
  movdqa [rdx + 32], xmm2
  mov [rdx + 48], ecx
{$endif}
end;

{$ifdef 64Bit}
procedure Move56(const ASource; var ADest; ACount: NativeInt);
asm
  movdqa xmm0, [rcx]
  movdqa xmm1, [rcx + 16]
  movdqa xmm2, [rcx + 32]
  mov r8, [rcx + 48]
  movdqa [rdx], xmm0
  movdqa [rdx + 16], xmm1
  movdqa [rdx + 32], xmm2
  mov [rdx + 48], r8
end;
{$endif}

procedure Move60(const ASource; var ADest; ACount: NativeInt);
asm
{$ifdef 32Bit}
  fild qword ptr [eax]
  fild qword ptr [eax + 8]
  fild qword ptr [eax + 16]
  fild qword ptr [eax + 24]
  fild qword ptr [eax + 32]
  fild qword ptr [eax + 40]
  fild qword ptr [eax + 48]
  mov ecx, [eax + 56]
  mov [edx + 56], ecx
  fistp qword ptr [edx + 48]
  fistp qword ptr [edx + 40]
  fistp qword ptr [edx + 32]
  fistp qword ptr [edx + 24]
  fistp qword ptr [edx + 16]
  fistp qword ptr [edx + 8]
  fistp qword ptr [edx]
{$else}
.noframe
  movdqa xmm0, [rcx]
  movdqa xmm1, [rcx + 16]
  movdqa xmm2, [rcx + 32]
  mov r8, [rcx + 48]
  mov ecx, [rcx + 56]
  movdqa [rdx], xmm0
  movdqa [rdx + 16], xmm1
  movdqa [rdx + 32], xmm2
  mov [rdx + 48], r8
  mov [rdx + 56], ecx
{$endif}
end;

procedure Move68(const ASource; var ADest; ACount: NativeInt);
asm
{$ifdef 32Bit}
  fild qword ptr [eax]
  fild qword ptr [eax + 8]
  fild qword ptr [eax + 16]
  fild qword ptr [eax + 24]
  fild qword ptr [eax + 32]
  fild qword ptr [eax + 40]
  fild qword ptr [eax + 48]
  fild qword ptr [eax + 56]
  mov ecx, [eax + 64]
  mov [edx + 64], ecx
  fistp qword ptr [edx + 56]
  fistp qword ptr [edx + 48]
  fistp qword ptr [edx + 40]
  fistp qword ptr [edx + 32]
  fistp qword ptr [edx + 24]
  fistp qword ptr [edx + 16]
  fistp qword ptr [edx + 8]
  fistp qword ptr [edx]
{$else}
.noframe
  movdqa xmm0, [rcx]
  movdqa xmm1, [rcx + 16]
  movdqa xmm2, [rcx + 32]
  movdqa xmm3, [rcx + 48]
  mov ecx, [rcx + 64]
  movdqa [rdx], xmm0
  movdqa [rdx + 16], xmm1
  movdqa [rdx + 32], xmm2
  movdqa [rdx + 48], xmm3
  mov [rdx + 64], ecx
{$endif}
end;

{Variable size move procedure: Rounds ACount up to the next multiple of 16 less
 SizeOf(Pointer). Important note: Always moves at least 16 - SizeOf(Pointer)
 bytes (the minimum small block size with 16 byte alignment), irrespective of
 ACount.}
procedure MoveX16LP(const ASource; var ADest; ACount: NativeInt);
asm
{$ifdef 32Bit}
  {Make the counter negative based: The last 12 bytes are moved separately}
  sub ecx, 12
  add eax, ecx
  add edx, ecx
{$ifdef EnableMMX}
  {$ifndef ForceMMX}
  cmp UseMMX, True
  jne @FPUMove
  {$endif}
  {Make the counter negative based: The last 12 bytes are moved separately}
  neg ecx
  jns @MMXMoveLast12
@MMXMoveLoop:
  {Move a 16 byte block}
  {$ifdef Delphi4or5}
  {Delphi 5 compatibility}
  db $0f, $6f, $04, $01
  db $0f, $6f, $4c, $01, $08
  db $0f, $7f, $04, $11
  db $0f, $7f, $4c, $11, $08
  {$else}
  movq mm0, [eax + ecx]
  movq mm1, [eax + ecx + 8]
  movq [edx + ecx], mm0
  movq [edx + ecx + 8], mm1
  {$endif}
  {Are there another 16 bytes to move?}
  add ecx, 16
  js @MMXMoveLoop
@MMXMoveLast12:
  {Do the last 12 bytes}
  {$ifdef Delphi4or5}
  {Delphi 5 compatibility}
  db $0f, $6f, $04, $01
  {$else}
  movq mm0, [eax + ecx]
  {$endif}
  mov eax, [eax + ecx + 8]
  {$ifdef Delphi4or5}
  {Delphi 5 compatibility}
  db $0f, $7f, $04, $11
  {$else}
  movq [edx + ecx], mm0
  {$endif}
  mov [edx + ecx + 8], eax
  {Exit MMX state}
  {$ifdef Delphi4or5}
  {Delphi 5 compatibility}
  db $0f, $77
  {$else}
  emms
  {$endif}
  {$ifndef ForceMMX}
  ret
  {$endif}
{$endif}
{FPU code is only used if MMX is not forced}
{$ifndef ForceMMX}
@FPUMove:
  neg ecx
  jns @FPUMoveLast12
@FPUMoveLoop:
  {Move a 16 byte block}
  fild qword ptr [eax + ecx]
  fild qword ptr [eax + ecx + 8]
  fistp qword ptr [edx + ecx + 8]
  fistp qword ptr [edx + ecx]
  {Are there another 16 bytes to move?}
  add ecx, 16
  js @FPUMoveLoop
@FPUMoveLast12:
  {Do the last 12 bytes}
  fild qword ptr [eax + ecx]
  fistp qword ptr [edx + ecx]
  mov eax, [eax + ecx + 8]
  mov [edx + ecx + 8], eax
{$endif}
{$else}
.noframe
  {Make the counter negative based: The last 8 bytes are moved separately}
  sub r8, 8
  add rcx, r8
  add rdx, r8
  neg r8
  jns @MoveLast12
@MoveLoop:
  {Move a 16 byte block}
  movdqa xmm0, [rcx + r8]
  movdqa [rdx + r8], xmm0
  {Are there another 16 bytes to move?}
  add r8, 16
  js @MoveLoop
@MoveLast12:
  {Do the last 8 bytes}
  mov r9, [rcx + r8]
  mov [rdx + r8], r9
{$endif}
end;

{Variable size move procedure: Rounds ACount up to the next multiple of 8 less
 SizeOf(Pointer). Important note: Always moves at least 8 - SizeOf(Pointer)
 bytes (the minimum small block size with 8 byte alignment), irrespective of
 ACount.}
procedure MoveX8LP(const ASource; var ADest; ACount: NativeInt);
asm
{$ifdef 32Bit}
  {Make the counter negative based: The last 4 bytes are moved separately}
  sub ecx, 4
  {4 bytes or less? -> Use the Move4 routine.}
  jle @FourBytesOrLess
  add eax, ecx
  add edx, ecx
  neg ecx
{$ifdef EnableMMX}
  {$ifndef ForceMMX}
  cmp UseMMX, True
  jne @FPUMoveLoop
  {$endif}
@MMXMoveLoop:
  {Move an 8 byte block}
{$ifdef Delphi4or5}
  {Delphi 5 compatibility}
  db $0f, $6f, $04, $01
  db $0f, $7f, $04, $11
{$else}
  movq mm0, [eax + ecx]
  movq [edx + ecx], mm0
{$endif}
  {Are there another 8 bytes to move?}
  add ecx, 8
  js @MMXMoveLoop
  {Exit MMX state}
{$ifdef Delphi4or5}
  {Delphi 5 compatibility}
  db $0f, $77
{$else}
  emms
{$endif}
  {Do the last 4 bytes}
  mov eax, [eax + ecx]
  mov [edx + ecx], eax
  ret
{$endif}
{FPU code is only used if MMX is not forced}
{$ifndef ForceMMX}
@FPUMoveLoop:
  {Move an 8 byte block}
  fild qword ptr [eax + ecx]
  fistp qword ptr [edx + ecx]
  {Are there another 8 bytes to move?}
  add ecx, 8
  js @FPUMoveLoop
  {Do the last 4 bytes}
  mov eax, [eax + ecx]
  mov [edx + ecx], eax
  ret
{$endif}
@FourBytesOrLess:
  {Four or less bytes to move}
  mov eax, [eax]
  mov [edx], eax
{$else}
.noframe
  {Make the counter negative based}
  add rcx, r8
  add rdx, r8
  neg r8
@MoveLoop:
  {Move an 8 byte block}
  mov r9, [rcx + r8]
  mov [rdx + r8], r9
  {Are there another 8 bytes to move?}
  add r8, 8
  js @MoveLoop
{$endif}
end;

{Locks the medium blocks. Note that the 32-bit asm version is assumed to
 preserve all registers except eax.}
procedure LockMediumBlocks;
begin
  {Lock the medium blocks}
{$ifndef AssumeMultiThreaded}
  if IsMultiThread then
{$endif}
  begin
    while LockCmpxchg(0, 1, @MediumBlocksLocked) <> 0 do
    begin
{$ifdef NeverSleepOnThreadContention}
  {$ifdef UseSwitchToThread}
      SwitchToThread;
  {$endif}
{$else}
      Sleep(InitialSleepTime);
      if LockCmpxchg(0, 1, @MediumBlocksLocked) = 0 then
        Break;
      Sleep(AdditionalSleepTime);
{$endif}
    end;
  end;
end;

{Removes a medium block from the circular linked list of free blocks.
 Does not change any header flags. Medium blocks should be locked
 before calling this procedure.}
procedure RemoveMediumFreeBlock(APMediumFreeBlock: PMediumFreeBlock);
var
  LPreviousFreeBlock, LNextFreeBlock: PMediumFreeBlock;
  LBinNumber, LBinGroupNumber: Cardinal;
begin
  {Get the current previous and next blocks}
  LNextFreeBlock := APMediumFreeBlock.NextFreeBlock;
  LPreviousFreeBlock := APMediumFreeBlock.PreviousFreeBlock;
  {Remove this block from the linked list}
  LPreviousFreeBlock.NextFreeBlock := LNextFreeBlock;
  LNextFreeBlock.PreviousFreeBlock := LPreviousFreeBlock;
  {Is this bin now empty? If the previous and next free block pointers are
   equal, they must point to the bin.}
  if LPreviousFreeBlock = LNextFreeBlock then
  begin
    {Get the bin number for this block size}
    LBinNumber := (UIntPtr(LNextFreeBlock) - UIntPtr(@MediumBlockBins)) div SizeOf(TMediumFreeBlock);
    LBinGroupNumber := LBinNumber div 32;
    {Flag this bin as empty}
    MediumBlockBinBitmaps[LBinGroupNumber] := MediumBlockBinBitmaps[LBinGroupNumber]
      and (not (1 shl (LBinNumber and 31)));
    {Is the group now entirely empty?}
    if MediumBlockBinBitmaps[LBinGroupNumber] = 0 then
    begin
      {Flag this group as empty}
      MediumBlockBinGroupBitmap := MediumBlockBinGroupBitmap
        and (not (1 shl LBinGroupNumber));
    end;
  end;
end;


{Inserts a medium block into the appropriate medium block bin.}
procedure InsertMediumBlockIntoBin(APMediumFreeBlock: PMediumFreeBlock; AMediumBlockSize: Cardinal);
var
  LBinNumber, LBinGroupNumber: Cardinal;
  LPBin, LPFirstFreeBlock: PMediumFreeBlock;
begin
  {Get the bin number for this block size. Get the bin that holds blocks of at
   least this size.}
  LBinNumber := (AMediumBlockSize - MinimumMediumBlockSize) div MediumBlockGranularity;
  if LBinNumber >= MediumBlockBinCount then
    LBinNumber := MediumBlockBinCount - 1;
  {Get the bin}
  LPBin := @MediumBlockBins[LBinNumber];
  {Bins are LIFO, se we insert this block as the first free block in the bin}
  LPFirstFreeBlock := LPBin.NextFreeBlock;
  APMediumFreeBlock.PreviousFreeBlock := LPBin;
  APMediumFreeBlock.NextFreeBlock := LPFirstFreeBlock;
  LPFirstFreeBlock.PreviousFreeBlock := APMediumFreeBlock;
  LPBin.NextFreeBlock := APMediumFreeBlock;
  {Was this bin empty?}
  if LPFirstFreeBlock = LPBin then
  begin
    {Get the group number}
    LBinGroupNumber := LBinNumber div 32;
    {Flag this bin as used}
    MediumBlockBinBitmaps[LBinGroupNumber] := MediumBlockBinBitmaps[LBinGroupNumber]
      or (1 shl (LBinNumber and 31));
    {Flag the group as used}
    MediumBlockBinGroupBitmap := MediumBlockBinGroupBitmap
      or (1 shl LBinGroupNumber);
  end;
end;

{Bins what remains in the current sequential feed medium block pool. Medium
 blocks must be locked.}
procedure BinMediumSequentialFeedRemainder;
{$ifndef ASMVersion}
var
  LSequentialFeedFreeSize, LNextBlockSizeAndFlags: NativeUInt;
  LPRemainderBlock, LNextMediumBlock: Pointer;
begin
  LSequentialFeedFreeSize := MediumSequentialFeedBytesLeft;
  if LSequentialFeedFreeSize > 0 then
  begin
    {Get the block after the open space}
    LNextMediumBlock := LastSequentiallyFedMediumBlock;
    LNextBlockSizeAndFlags := PNativeUInt(PByte(LNextMediumBlock) - BlockHeaderSize)^;
    {Point to the remainder}
    LPRemainderBlock := Pointer(PByte(LNextMediumBlock) - LSequentialFeedFreeSize);
{$ifndef FullDebugMode}
    {Can the next block be combined with the remainder?}
    if (LNextBlockSizeAndFlags and IsFreeBlockFlag) <> 0 then
    begin
      {Increase the size of this block}
      Inc(LSequentialFeedFreeSize, LNextBlockSizeAndFlags and DropMediumAndLargeFlagsMask);
      {Remove the next block as well}
      if (LNextBlockSizeAndFlags and DropMediumAndLargeFlagsMask) >= MinimumMediumBlockSize then
        RemoveMediumFreeBlock(LNextMediumBlock);
    end
    else
    begin
{$endif}
      {Set the "previous block is free" flag of the next block}
      PNativeUInt(PByte(LNextMediumBlock) - BlockHeaderSize)^ := LNextBlockSizeAndFlags or PreviousMediumBlockIsFreeFlag;
{$ifndef FullDebugMode}
    end;
{$endif}
    {Store the size of the block as well as the flags}
    PNativeUInt(PByte(LPRemainderBlock) - BlockHeaderSize)^ := LSequentialFeedFreeSize or IsMediumBlockFlag or IsFreeBlockFlag;
    {Store the trailing size marker}
    PNativeUInt(PByte(LPRemainderBlock) + LSequentialFeedFreeSize - BlockHeaderSize * 2)^ := LSequentialFeedFreeSize;
    {Bin this medium block}
    if LSequentialFeedFreeSize >= MinimumMediumBlockSize then
      InsertMediumBlockIntoBin(LPRemainderBlock, LSequentialFeedFreeSize);
  end;
end;

{Allocates a new sequential feed medium block pool and immediately splits off a
 block of the requested size. The block size must be a multiple of 16 and
 medium blocks must be locked.}
function AllocNewSequentialFeedMediumPool(AFirstBlockSize: Cardinal): Pointer;
var
  LOldFirstMediumBlockPool: PMediumBlockPoolHeader;
  LNewPool: Pointer;
begin
  {Bin the current sequential feed remainder}
  BinMediumSequentialFeedRemainder;
  {Allocate a new sequential feed block pool}
  LNewPool := VirtualAlloc(nil, MediumBlockPoolSize,
    MEM_COMMIT{$ifdef AlwaysAllocateTopDown} or MEM_TOP_DOWN{$endif}, PAGE_READWRITE);
  if LNewPool <> nil then
  begin
    {Insert this block pool into the list of block pools}
    LOldFirstMediumBlockPool := MediumBlockPoolsCircularList.NextMediumBlockPoolHeader;
    PMediumBlockPoolHeader(LNewPool).PreviousMediumBlockPoolHeader := @MediumBlockPoolsCircularList;
    MediumBlockPoolsCircularList.NextMediumBlockPoolHeader := LNewPool;
    PMediumBlockPoolHeader(LNewPool).NextMediumBlockPoolHeader := LOldFirstMediumBlockPool;
    LOldFirstMediumBlockPool.PreviousMediumBlockPoolHeader := LNewPool;
    {Store the sequential feed pool trailer}
    PNativeUInt(PByte(LNewPool) + MediumBlockPoolSize - BlockHeaderSize)^ := IsMediumBlockFlag;
    {Get the number of bytes still available}
    MediumSequentialFeedBytesLeft := (MediumBlockPoolSize - MediumBlockPoolHeaderSize) - AFirstBlockSize;
    {Get the result}
    Result := Pointer(PByte(LNewPool) + MediumBlockPoolSize - AFirstBlockSize);
    LastSequentiallyFedMediumBlock := Result;
    {Store the block header}
    PNativeUInt(PByte(Result) - BlockHeaderSize)^ := AFirstBlockSize or IsMediumBlockFlag;
  end
  else
  begin
    {Out of memory}
    MediumSequentialFeedBytesLeft := 0;
    Result := nil;
  end;
end;

{-----------------Large Block Management------------------}

{Locks the large blocks}
procedure LockLargeBlocks;
begin
  {Lock the large blocks}
{$ifndef AssumeMultiThreaded}
  if IsMultiThread then
{$endif}
  begin
    while LockCmpxchg(0, 1, @LargeBlocksLocked) <> 0 do
    begin
{$ifdef NeverSleepOnThreadContention}
  {$ifdef UseSwitchToThread}
      SwitchToThread;
  {$endif}
{$else}
      Sleep(InitialSleepTime);
      if LockCmpxchg(0, 1, @LargeBlocksLocked) = 0 then
        Break;
      Sleep(AdditionalSleepTime);
{$endif}
    end;
  end;
end;

{Allocates a Large block of at least ASize (actual size may be larger to
 allow for alignment etc.). ASize must be the actual user requested size. This
 procedure will pad it to the appropriate page boundary and also add the space
 required by the header.}
function AllocateLargeBlock(ASize: NativeUInt): Pointer;
var
  LLargeUsedBlockSize: NativeUInt;
  LOldFirstLargeBlock: PLargeBlockHeader;
begin
  {Pad the block size to include the header and granularity. We also add a
   SizeOf(Pointer) overhead so a huge block size is a multiple of 16 bytes less
   SizeOf(Pointer) (so we can use a single move function for reallocating all
   block types)}
  LLargeUsedBlockSize := (ASize + LargeBlockHeaderSize + LargeBlockGranularity - 1 + BlockHeaderSize)
    and -LargeBlockGranularity;
  {Get the Large block}
  Result := VirtualAlloc(nil, LLargeUsedBlockSize, MEM_COMMIT or MEM_TOP_DOWN,
    PAGE_READWRITE);
  {Set the Large block fields}
  if Result <> nil then
  begin
    {Set the large block size and flags}
    PLargeBlockHeader(Result).UserAllocatedSize := ASize;
    PLargeBlockHeader(Result).BlockSizeAndFlags := LLargeUsedBlockSize or IsLargeBlockFlag;
    {Insert the large block into the linked list of large blocks}
    LockLargeBlocks;
    LOldFirstLargeBlock := LargeBlocksCircularList.NextLargeBlockHeader;
    PLargeBlockHeader(Result).PreviousLargeBlockHeader := @LargeBlocksCircularList;
    LargeBlocksCircularList.NextLargeBlockHeader := Result;
    PLargeBlockHeader(Result).NextLargeBlockHeader := LOldFirstLargeBlock;
    LOldFirstLargeBlock.PreviousLargeBlockHeader := Result;
    LargeBlocksLocked := False;
    {Add the size of the header}
    Inc(PByte(Result), LargeBlockHeaderSize);
  end;
end;

{Frees a large block, returning 0 on success, -1 otherwise}
function FreeLargeBlock(APointer: Pointer): Integer;
var
  LPreviousLargeBlockHeader, LNextLargeBlockHeader: PLargeBlockHeader;
{$ifndef POSIX}
  LRemainingSize: NativeUInt;
  LCurrentSegment: Pointer;
  LMemInfo: TMemoryBasicInformation;
{$endif}
begin
{$ifdef ClearLargeBlocksBeforeReturningToOS}
  FillChar(APointer^,
    (PLargeBlockHeader(PByte(APointer) - LargeBlockHeaderSize).BlockSizeAndFlags
      and DropMediumAndLargeFlagsMask) - LargeBlockHeaderSize, 0);
{$endif}
  {Point to the start of the large block}
  APointer := Pointer(PByte(APointer) - LargeBlockHeaderSize);
  {Get the previous and next large blocks}
  LockLargeBlocks;
  LPreviousLargeBlockHeader := PLargeBlockHeader(APointer).PreviousLargeBlockHeader;
  LNextLargeBlockHeader := PLargeBlockHeader(APointer).NextLargeBlockHeader;
{$ifndef POSIX}
  {Is the large block segmented?}
  if PLargeBlockHeader(APointer).BlockSizeAndFlags and LargeBlockIsSegmented = 0 then
  begin
{$endif}
    {Single segment large block: Try to free it}
    if VirtualFree(APointer, 0, MEM_RELEASE) then
      Result := 0
    else
      Result := -1;
{$ifndef POSIX}
  end
  else
  begin
    {The large block is segmented - free all segments}
    LCurrentSegment := APointer;
    LRemainingSize := PLargeBlockHeader(APointer).BlockSizeAndFlags and DropMediumAndLargeFlagsMask;
    Result := 0;
    while True do
    begin
      {Get the size of the current segment}
      VirtualQuery(LCurrentSegment, LMemInfo, SizeOf(LMemInfo));
      {Free the segment}
      if not VirtualFree(LCurrentSegment, 0, MEM_RELEASE) then
      begin
        Result := -1;
        Break;
      end;
      {Done?}
      if NativeUInt(LMemInfo.RegionSize) >= LRemainingSize then
        Break;
      {Decrement the remaining size}
      Dec(LRemainingSize, NativeUInt(LMemInfo.RegionSize));
      Inc(PByte(LCurrentSegment), NativeUInt(LMemInfo.RegionSize));
    end;
  end;
{$endif}
  {Success?}
  if Result = 0 then
  begin
    {Remove the large block from the linked list}
    LNextLargeBlockHeader.PreviousLargeBlockHeader := LPreviousLargeBlockHeader;
    LPreviousLargeBlockHeader.NextLargeBlockHeader := LNextLargeBlockHeader;
  end;
  {Unlock the large blocks}
  LargeBlocksLocked := False;
end;

{$ifndef FullDebugMode}
{Reallocates a large block to at least the requested size. Returns the new
 pointer, or nil on error}
function ReallocateLargeBlock(APointer: Pointer; ANewSize: NativeUInt): Pointer;
var
  LOldAvailableSize, LBlockHeader, LOldUserSize, LMinimumUpsize,
    LNewAllocSize: NativeUInt;
{$ifndef POSIX}
  LNewSegmentSize: NativeUInt;
  LNextSegmentPointer: Pointer;
  LMemInfo: TMemoryBasicInformation;
{$endif}
begin
  {Get the block header}
  LBlockHeader := PNativeUInt(PByte(APointer) - BlockHeaderSize)^;
  {Large block - size is (16 + 4) less than the allocated size}
  LOldAvailableSize := (LBlockHeader and DropMediumAndLargeFlagsMask) - (LargeBlockHeaderSize + BlockHeaderSize);
  {Is it an upsize or a downsize?}
  if ANewSize > LOldAvailableSize then
  begin
    {This pointer is being reallocated to a larger block and therefore it is
     logical to assume that it may be enlarged again. Since reallocations are
     expensive, there is a minimum upsize percentage to avoid unnecessary
     future move operations.}
    {Add 25% for large block upsizes}
    LMinimumUpsize := LOldAvailableSize + (LOldAvailableSize shr 2);
    if ANewSize < LMinimumUpsize then
      LNewAllocSize := LMinimumUpsize
    else
      LNewAllocSize := ANewSize;
{$ifndef POSIX}
    {Can another large block segment be allocated directly after this segment,
     thus negating the need to move the data?}
    LNextSegmentPointer := Pointer(PByte(APointer) - LargeBlockHeaderSize + (LBlockHeader and DropMediumAndLargeFlagsMask));
    VirtualQuery(LNextSegmentPointer, LMemInfo, SizeOf(LMemInfo));
    if LMemInfo.State = MEM_FREE then
    begin
      {Round the region size to the previous 64K}
      LMemInfo.RegionSize := LMemInfo.RegionSize and -LargeBlockGranularity;
      {Enough space to grow in place?}
      if NativeUInt(LMemInfo.RegionSize) > (ANewSize - LOldAvailableSize) then
      begin
        {There is enough space after the block to extend it - determine by how
         much}
        LNewSegmentSize := (LNewAllocSize - LOldAvailableSize + LargeBlockGranularity - 1) and -LargeBlockGranularity;
        if LNewSegmentSize > LMemInfo.RegionSize then
          LNewSegmentSize := LMemInfo.RegionSize;
        {Attempy to reserve the address range (which will fail if another
         thread has just reserved it) and commit it immediately afterwards.}
        if (VirtualAlloc(LNextSegmentPointer, LNewSegmentSize, MEM_RESERVE, PAGE_READWRITE) <> nil)
          and (VirtualAlloc(LNextSegmentPointer, LNewSegmentSize, MEM_COMMIT, PAGE_READWRITE) <> nil) then
        begin
          {Update the requested size}
          PLargeBlockHeader(PByte(APointer) - LargeBlockHeaderSize).UserAllocatedSize := ANewSize;
          PLargeBlockHeader(PByte(APointer) - LargeBlockHeaderSize).BlockSizeAndFlags :=
            (PLargeBlockHeader(PByte(APointer) - LargeBlockHeaderSize).BlockSizeAndFlags + LNewSegmentSize)
            or LargeBlockIsSegmented;
          {Success}
          Result := APointer;
          Exit;
        end;
      end;
    end;
{$endif}
    {Could not resize in place: Allocate the new block}
    Result := FastGetMem(LNewAllocSize);
    if Result <> nil then
    begin
      {If it's a large block - store the actual user requested size (it may
       not be if the block that is being reallocated from was previously
       downsized)}
      if LNewAllocSize > (MaximumMediumBlockSize - BlockHeaderSize) then
        PLargeBlockHeader(PByte(Result) - LargeBlockHeaderSize).UserAllocatedSize := ANewSize;
      {The user allocated size is stored for large blocks}
      LOldUserSize := PLargeBlockHeader(PByte(APointer) - LargeBlockHeaderSize).UserAllocatedSize;
      {The number of bytes to move is the old user size.}
{$ifdef UseCustomVariableSizeMoveRoutines}
      MoveX16LP(APointer^, Result^, LOldUserSize);
{$else}
      System.Move(APointer^, Result^, LOldUserSize);
{$endif}
      {Free the old block}
      FastFreeMem(APointer);
    end;
  end
  else
  begin
    {It's a downsize: do we need to reallocate? Only if the new size is less
     than half the old size}
    if ANewSize >= (LOldAvailableSize shr 1) then
    begin
      {No need to reallocate}
      Result := APointer;
      {Update the requested size}
      PLargeBlockHeader(PByte(APointer) - LargeBlockHeaderSize).UserAllocatedSize := ANewSize;
    end
    else
    begin
      {The block is less than half the old size, and the current size is
       greater than the minimum block size allowing a downsize: reallocate}
      Result := FastGetMem(ANewSize);
      if Result <> nil then
      begin
        {Still a large block? -> Set the user size}
        if ANewSize > (MaximumMediumBlockSize - BlockHeaderSize) then
          PLargeBlockHeader(PByte(APointer) - LargeBlockHeaderSize).UserAllocatedSize := ANewSize;
        {Move the data across}
{$ifdef UseCustomVariableSizeMoveRoutines}
{$ifdef Align16Bytes}
        MoveX16LP(APointer^, Result^, ANewSize);
{$else}
        MoveX8LP(APointer^, Result^, ANewSize);
{$endif}
{$else}
        System.Move(APointer^, Result^, ANewSize);
{$endif}
        {Free the old block}
        FastFreeMem(APointer);
      end;
    end;
  end;
end;
{$endif}

{---------------------Replacement Memory Manager Interface---------------------}

{Replacement for SysGetMem}

function FastGetMem(ASize: {$ifdef XE2AndUp}NativeInt{$else}Integer{$endif}): Pointer;
{$ifndef ASMVersion}
var
  LMediumBlock{$ifndef FullDebugMode}, LNextFreeBlock, LSecondSplit{$endif}: PMediumFreeBlock;
  LNextMediumBlockHeader: PNativeUInt;
  LBlockSize, LAvailableBlockSize{$ifndef FullDebugMode}, LSecondSplitSize{$endif},
    LSequentialFeedFreeSize: NativeUInt;
  LPSmallBlockType: PSmallBlockType;
  LPSmallBlockPool, LPNewFirstPool: PSmallBlockPoolHeader;
  LNewFirstFreeBlock: Pointer;
  LPMediumBin: PMediumFreeBlock;
  LBinNumber, {$ifndef FullDebugMode}LBinGroupsMasked, {$endif}LBinGroupMasked,
    LBinGroupNumber: Cardinal;
begin
  {Is it a small block? -> Take the header size into account when
   determining the required block size}
  if NativeUInt(ASize) <= (MaximumSmallBlockSize - BlockHeaderSize) then
  begin
    {-------------------------Allocate a small block---------------------------}
    {Get the block type from the size}
    LPSmallBlockType := PSmallBlockType(AllocSize2SmallBlockTypeIndX4[
      (NativeUInt(ASize) + (BlockHeaderSize - 1)) div SmallBlockGranularity]
      * (SizeOf(TSmallBlockType) div 4)
      + UIntPtr(@SmallBlockTypes));
    {Lock the block type}
{$ifndef AssumeMultiThreaded}
    if IsMultiThread then
{$endif}
    begin
      while True do
      begin
        {Try to lock the small block type}
        if LockCmpxchg(0, 1, @LPSmallBlockType.BlockTypeLocked) = 0 then
          Break;
        {Try the next block type}
        Inc(PByte(LPSmallBlockType), SizeOf(TSmallBlockType));
        if LockCmpxchg(0, 1, @LPSmallBlockType.BlockTypeLocked) = 0 then
          Break;
        {Try up to two sizes past the requested size}
        Inc(PByte(LPSmallBlockType), SizeOf(TSmallBlockType));
        if LockCmpxchg(0, 1, @LPSmallBlockType.BlockTypeLocked) = 0 then
          Break;
        {All three sizes locked - given up and sleep}
        Dec(PByte(LPSmallBlockType), 2 * SizeOf(TSmallBlockType));
{$ifdef NeverSleepOnThreadContention}
  {$ifdef UseSwitchToThread}
        SwitchToThread;
  {$endif}
{$else}
        {Both this block type and the next is in use: sleep}
        Sleep(InitialSleepTime);
        {Try the lock again}
        if LockCmpxchg(0, 1, @LPSmallBlockType.BlockTypeLocked) = 0 then
          Break;
        {Sleep longer}
        Sleep(AdditionalSleepTime);
{$endif}
      end;
    end;
    {Get the first pool with free blocks}
    LPSmallBlockPool := LPSmallBlockType.NextPartiallyFreePool;
    {Is the pool valid?}
    if UIntPtr(LPSmallBlockPool) <> UIntPtr(LPSmallBlockType) then
    begin
      {Get the first free offset}
      Result := LPSmallBlockPool.FirstFreeBlock;
      {Get the new first free block}
      LNewFirstFreeBlock := PPointer(PByte(Result) - BlockHeaderSize)^;
{$ifdef CheckHeapForCorruption}
      {The block should be free}
      if (NativeUInt(LNewFirstFreeBlock) and ExtractSmallFlagsMask) <> IsFreeBlockFlag then
  {$ifdef BCB6OrDelphi7AndUp}
        System.Error(reInvalidPtr);
  {$else}
        System.RunError(reInvalidPtr);
  {$endif}
{$endif}
      LNewFirstFreeBlock := Pointer(UIntPtr(LNewFirstFreeBlock) and DropSmallFlagsMask);
      {Increment the number of used blocks}
      Inc(LPSmallBlockPool.BlocksInUse);
      {Set the new first free block}
      LPSmallBlockPool.FirstFreeBlock := LNewFirstFreeBlock;
      {Is the pool now full?}
      if LNewFirstFreeBlock = nil then
      begin
        {Pool is full - remove it from the partially free list}
        LPNewFirstPool := LPSmallBlockPool.NextPartiallyFreePool;
        LPSmallBlockType.NextPartiallyFreePool := LPNewFirstPool;
        LPNewFirstPool.PreviousPartiallyFreePool := PSmallBlockPoolHeader(LPSmallBlockType);
      end;
    end
    else
    begin
      {Try to feed a small block sequentially}
      Result := LPSmallBlockType.NextSequentialFeedBlockAddress;
      {Can another block fit?}
      if UIntPtr(Result) <= UIntPtr(LPSmallBlockType.MaxSequentialFeedBlockAddress) then
      begin
        {Get the sequential feed block pool}
        LPSmallBlockPool := LPSmallBlockType.CurrentSequentialFeedPool;
        {Increment the number of used blocks in the sequential feed pool}
        Inc(LPSmallBlockPool.BlocksInUse);
        {Store the next sequential feed block address}
        LPSmallBlockType.NextSequentialFeedBlockAddress := Pointer(PByte(Result) + LPSmallBlockType.BlockSize);
      end
      else
      begin
        {Need to allocate a pool: Lock the medium blocks}
        LockMediumBlocks;
{$ifndef FullDebugMode}
        {Are there any available blocks of a suitable size?}
        LBinGroupsMasked := MediumBlockBinGroupBitmap and ($ffffff00 or LPSmallBlockType.AllowedGroupsForBlockPoolBitmap);
        if LBinGroupsMasked <> 0 then
        begin
          {Get the bin group with free blocks}
          LBinGroupNumber := FindFirstSetBit(LBinGroupsMasked);
          {Get the bin in the group with free blocks}
          LBinNumber := FindFirstSetBit(MediumBlockBinBitmaps[LBinGroupNumber])
            + LBinGroupNumber * 32;
          LPMediumBin := @MediumBlockBins[LBinNumber];
          {Get the first block in the bin}
          LMediumBlock := LPMediumBin.NextFreeBlock;
          {Remove the first block from the linked list (LIFO)}
          LNextFreeBlock := LMediumBlock.NextFreeBlock;
          LPMediumBin.NextFreeBlock := LNextFreeBlock;
          LNextFreeBlock.PreviousFreeBlock := LPMediumBin;
          {Is this bin now empty?}
          if LNextFreeBlock = LPMediumBin then
          begin
            {Flag this bin as empty}
            MediumBlockBinBitmaps[LBinGroupNumber] := MediumBlockBinBitmaps[LBinGroupNumber]
              and (not (1 shl (LBinNumber and 31)));
            {Is the group now entirely empty?}
            if MediumBlockBinBitmaps[LBinGroupNumber] = 0 then
            begin
              {Flag this group as empty}
              MediumBlockBinGroupBitmap := MediumBlockBinGroupBitmap
                and (not (1 shl LBinGroupNumber));
            end;
          end;
          {Get the size of the available medium block}
          LBlockSize := PNativeUInt(PByte(LMediumBlock) - BlockHeaderSize)^ and DropMediumAndLargeFlagsMask;
  {$ifdef CheckHeapForCorruption}
          {Check that this block is actually free and the next and previous blocks
           are both in use.}
          if ((PNativeUInt(PByte(LMediumBlock) - BlockHeaderSize)^ and ExtractMediumAndLargeFlagsMask) <> (IsMediumBlockFlag or IsFreeBlockFlag))
            or ((PNativeUInt(PByte(LMediumBlock) + (PNativeUInt(PByte(LMediumBlock) - BlockHeaderSize)^ and DropMediumAndLargeFlagsMask) - BlockHeaderSize)^ and IsFreeBlockFlag) <> 0)
          then
          begin
    {$ifdef BCB6OrDelphi7AndUp}
            System.Error(reInvalidPtr);
    {$else}
            System.RunError(reInvalidPtr);
    {$endif}
          end;
  {$endif}
          {Should the block be split?}
          if LBlockSize >= MaximumSmallBlockPoolSize then
          begin
            {Get the size of the second split}
            LSecondSplitSize := LBlockSize - LPSmallBlockType.OptimalBlockPoolSize;
            {Adjust the block size}
            LBlockSize := LPSmallBlockType.OptimalBlockPoolSize;
            {Split the block in two}
            LSecondSplit := PMediumFreeBlock(PByte(LMediumBlock) + LBlockSize);
            PNativeUInt(PByte(LSecondSplit) - BlockHeaderSize)^ := LSecondSplitSize or (IsMediumBlockFlag or IsFreeBlockFlag);
            {Store the size of the second split as the second last dword/qword}
            PNativeUInt(PByte(LSecondSplit) + LSecondSplitSize - 2 * BlockHeaderSize)^ := LSecondSplitSize;
            {Put the remainder in a bin (it will be big enough)}
            InsertMediumBlockIntoBin(LSecondSplit, LSecondSplitSize);
          end
          else
          begin
            {Mark this block as used in the block following it}
            LNextMediumBlockHeader := PNativeUInt(PByte(LMediumBlock) + LBlockSize - BlockHeaderSize);
            LNextMediumBlockHeader^ := LNextMediumBlockHeader^ and (not PreviousMediumBlockIsFreeFlag);
          end;
        end
        else
        begin
{$endif}
          {Check the sequential feed medium block pool for space}
          LSequentialFeedFreeSize := MediumSequentialFeedBytesLeft;
          if LSequentialFeedFreeSize >= LPSmallBlockType.MinimumBlockPoolSize then
          begin
            {Enough sequential feed space: Will the remainder be usable?}
            if LSequentialFeedFreeSize >= (LPSmallBlockType.OptimalBlockPoolSize + MinimumMediumBlockSize) then
            begin
              LBlockSize := LPSmallBlockType.OptimalBlockPoolSize;
            end
            else
              LBlockSize := LSequentialFeedFreeSize;
            {Get the block}
            LMediumBlock := Pointer(PByte(LastSequentiallyFedMediumBlock) - LBlockSize);
            {Update the sequential feed parameters}
            LastSequentiallyFedMediumBlock := LMediumBlock;
            MediumSequentialFeedBytesLeft := LSequentialFeedFreeSize - LBlockSize;
          end
          else
          begin
            {Need to allocate a new sequential feed medium block pool: use the
             optimal size for this small block pool}
            LBlockSize := LPSmallBlockType.OptimalBlockPoolSize;
            {Allocate the medium block pool}
            LMediumBlock := AllocNewSequentialFeedMediumPool(LBlockSize);
            if LMediumBlock = nil then
            begin
              {Out of memory}
              {Unlock the medium blocks}
              MediumBlocksLocked := False;
              {Unlock the block type}
              LPSmallBlockType.BlockTypeLocked := False;
              {Failed}
              Result := nil;
              {done}
              Exit;
            end;
          end;
{$ifndef FullDebugMode}
        end;
{$endif}
        {Mark this block as in use}
        {Set the size and flags for this block}
        PNativeUInt(PByte(LMediumBlock) - BlockHeaderSize)^ := LBlockSize or IsMediumBlockFlag or IsSmallBlockPoolInUseFlag;
        {Unlock medium blocks}
        MediumBlocksLocked := False;
        {Set up the block pool}
        LPSmallBlockPool := PSmallBlockPoolHeader(LMediumBlock);
        LPSmallBlockPool.BlockType := LPSmallBlockType;
        LPSmallBlockPool.FirstFreeBlock := nil;
        LPSmallBlockPool.BlocksInUse := 1;
        {Set it up for sequential block serving}
        LPSmallBlockType.CurrentSequentialFeedPool := LPSmallBlockPool;
        Result := Pointer(PByte(LPSmallBlockPool) + SmallBlockPoolHeaderSize);
        LPSmallBlockType.NextSequentialFeedBlockAddress := Pointer(PByte(Result) + LPSmallBlockType.BlockSize);
        LPSmallBlockType.MaxSequentialFeedBlockAddress := Pointer(PByte(LPSmallBlockPool) + LBlockSize - LPSmallBlockType.BlockSize);
      end;
    end;
    {Unlock the block type}
    LPSmallBlockType.BlockTypeLocked := False;
    {Set the block header}
    PNativeUInt(PByte(Result) - BlockHeaderSize)^ := UIntPtr(LPSmallBlockPool);
  end
  else
  begin
    {Medium block or Large block?}
    if NativeUInt(ASize) <= (MaximumMediumBlockSize - BlockHeaderSize) then
    begin
      {------------------------Allocate a medium block--------------------------}
      {Get the block size and bin number for this block size. Block sizes are
       rounded up to the next bin size.}
      LBlockSize := ((NativeUInt(ASize) + (MediumBlockGranularity - 1 + BlockHeaderSize - MediumBlockSizeOffset))
        and -MediumBlockGranularity) + MediumBlockSizeOffset;
      {Get the bin number}
      LBinNumber := (LBlockSize - MinimumMediumBlockSize) div MediumBlockGranularity;
      {Lock the medium blocks}
      LockMediumBlocks;
      {Calculate the bin group}
      LBinGroupNumber := LBinNumber div 32;
      {Is there a suitable block inside this group?}
      LBinGroupMasked := MediumBlockBinBitmaps[LBinGroupNumber] and -(1 shl (LBinNumber and 31));
      if LBinGroupMasked <> 0 then
      begin
        {Get the actual bin number}
        LBinNumber := FindFirstSetBit(LBinGroupMasked) + LBinGroupNumber * 32;
      end
      else
      begin
{$ifndef FullDebugMode}
        {Try all groups greater than this group}
        LBinGroupsMasked := MediumBlockBinGroupBitmap and -(2 shl LBinGroupNumber);
        if LBinGroupsMasked <> 0 then
        begin
          {There is a suitable group with space: get the bin number}
          LBinGroupNumber := FindFirstSetBit(LBinGroupsMasked);
          {Get the bin in the group with free blocks}
          LBinNumber := FindFirstSetBit(MediumBlockBinBitmaps[LBinGroupNumber])
            + LBinGroupNumber * 32;
        end
        else
        begin
{$endif}
          {There are no bins with a suitable block: Sequentially feed the required block}
          LSequentialFeedFreeSize := MediumSequentialFeedBytesLeft;
          if LSequentialFeedFreeSize >= LBlockSize then
          begin
            {Block can be fed sequentially}
            Result := Pointer(PByte(LastSequentiallyFedMediumBlock) - LBlockSize);
            {Store the last sequentially fed block}
            LastSequentiallyFedMediumBlock := Result;
            {Store the remaining bytes}
            MediumSequentialFeedBytesLeft := LSequentialFeedFreeSize - LBlockSize;
            {Set the flags for the block}
            PNativeUInt(PByte(Result) - BlockHeaderSize)^ := LBlockSize or IsMediumBlockFlag;
          end
          else
          begin
            {Need to allocate a new sequential feed block}
            Result := AllocNewSequentialFeedMediumPool(LBlockSize);
          end;
          {Done}
          MediumBlocksLocked := False;
          Exit;
{$ifndef FullDebugMode}
        end;
{$endif}
      end;
      {If we get here we have a valid LBinGroupNumber and LBinNumber:
       Use the first block in the bin, splitting it if necessary}
      {Get a pointer to the bin}
      LPMediumBin := @MediumBlockBins[LBinNumber];
      {Get the result}
      Result := LPMediumBin.NextFreeBlock;
{$ifdef CheckHeapForCorruption}
      {Check that this block is actually free and the next and previous blocks
       are both in use (except in full debug mode).}
      if ((PNativeUInt(PByte(Result) - BlockHeaderSize)^ and {$ifndef FullDebugMode}ExtractMediumAndLargeFlagsMask{$else}(IsMediumBlockFlag or IsFreeBlockFlag){$endif}) <> (IsFreeBlockFlag or IsMediumBlockFlag))
  {$ifndef FullDebugMode}
        or ((PNativeUInt(PByte(Result) + (PNativeUInt(PByte(Result) - BlockHeaderSize)^ and DropMediumAndLargeFlagsMask) - BlockHeaderSize)^ and (ExtractMediumAndLargeFlagsMask - IsSmallBlockPoolInUseFlag)) <> (IsMediumBlockFlag or PreviousMediumBlockIsFreeFlag))
  {$endif}
      then
      begin
  {$ifdef BCB6OrDelphi7AndUp}
        System.Error(reInvalidPtr);
  {$else}
        System.RunError(reInvalidPtr);
  {$endif}
      end;
{$endif}
      {Remove the block from the bin containing it}
      RemoveMediumFreeBlock(Result);
      {Get the block size}
      LAvailableBlockSize := PNativeUInt(PByte(Result) - BlockHeaderSize)^ and DropMediumAndLargeFlagsMask;
{$ifndef FullDebugMode}
      {Is it an exact fit or not?}
      LSecondSplitSize := LAvailableBlockSize - LBlockSize;
      if LSecondSplitSize <> 0 then
      begin
        {Split the block in two}
        LSecondSplit := PMediumFreeBlock(PByte(Result) + LBlockSize);
        {Set the size of the second split}
        PNativeUInt(PByte(LSecondSplit) - BlockHeaderSize)^ := LSecondSplitSize or (IsMediumBlockFlag or IsFreeBlockFlag);
        {Store the size of the second split}
        PNativeUInt(PByte(LSecondSplit) + LSecondSplitSize - 2 * BlockHeaderSize)^ := LSecondSplitSize;
        {Put the remainder in a bin if it is big enough}
        if LSecondSplitSize >= MinimumMediumBlockSize then
          InsertMediumBlockIntoBin(LSecondSplit, LSecondSplitSize);
      end
      else
      begin
{$else}
        {In full debug mode blocks are never split or coalesced}
        LBlockSize := LAvailableBlockSize;
{$endif}
        {Mark this block as used in the block following it}
        LNextMediumBlockHeader := Pointer(PByte(Result) + LBlockSize - BlockHeaderSize);
{$ifndef FullDebugMode}
  {$ifdef CheckHeapForCorruption}
        {The next block must be in use}
        if (LNextMediumBlockHeader^ and (ExtractMediumAndLargeFlagsMask - IsSmallBlockPoolInUseFlag)) <> (IsMediumBlockFlag or PreviousMediumBlockIsFreeFlag) then
    {$ifdef BCB6OrDelphi7AndUp}
        System.Error(reInvalidPtr);
    {$else}
        System.RunError(reInvalidPtr);
    {$endif}
  {$endif}
{$endif}
        LNextMediumBlockHeader^ :=
          LNextMediumBlockHeader^ and (not PreviousMediumBlockIsFreeFlag);
{$ifndef FullDebugMode}
      end;
      {Set the size and flags for this block}
      PNativeUInt(PByte(Result) - BlockHeaderSize)^ := LBlockSize or IsMediumBlockFlag;
{$else}
      {In full debug mode blocks are never split or coalesced}
      Dec(PNativeUInt(PByte(Result) - BlockHeaderSize)^, IsFreeBlockFlag);
{$endif}
      {Unlock the medium blocks}
      MediumBlocksLocked := False;
    end
    else
    begin
      {Allocate a Large block}
      if ASize > 0 then
        Result := AllocateLargeBlock(ASize)
      else
        Result := nil;
    end;
  end;
end;
{$else}
{$ifdef 32Bit}
asm
  {On entry:
    eax = ASize}
  {Since most allocations are for small blocks, determine the small block type
   index so long}
  lea edx, [eax + BlockHeaderSize - 1]
{$ifdef Align16Bytes}
  shr edx, 4
{$else}
  shr edx, 3
{$endif}
  {Is it a small block?}
  cmp eax, (MaximumSmallBlockSize - BlockHeaderSize)
  {Save ebx}
  push ebx
  {Get the IsMultiThread variable so long}
{$ifndef AssumeMultiThreaded}
  mov cl, IsMultiThread
{$endif}
  {Is it a small block?}
  ja @NotASmallBlock
  {Do we need to lock the block type?}
{$ifndef AssumeMultiThreaded}
  test cl, cl
{$endif}
  {Get the small block type in ebx}
  movzx eax, byte ptr [AllocSize2SmallBlockTypeIndX4 + edx]
  lea ebx, [SmallBlockTypes + eax * 8]
  {Do we need to lock the block type?}
{$ifndef AssumeMultiThreaded}
  jnz @LockBlockTypeLoop
{$else}
  jmp @LockBlockTypeLoop
  {Align branch target}
  nop
  nop
{$endif}
@GotLockOnSmallBlockType:
  {Find the next free block: Get the first pool with free blocks in edx}
  mov edx, TSmallBlockType[ebx].NextPartiallyFreePool
  {Get the first free block (or the next sequential feed address if edx = ebx)}
  mov eax, TSmallBlockPoolHeader[edx].FirstFreeBlock
  {Get the drop flags mask in ecx so long}
  mov ecx, DropSmallFlagsMask
  {Is there a pool with free blocks?}
  cmp edx, ebx
  je @TrySmallSequentialFeed
  {Increment the number of used blocks}
  add TSmallBlockPoolHeader[edx].BlocksInUse, 1
  {Get the new first free block}
  and ecx, [eax - 4]
  {Set the new first free block}
  mov TSmallBlockPoolHeader[edx].FirstFreeBlock, ecx
  {Set the block header}
  mov [eax - 4], edx
  {Is the chunk now full?}
  jz @RemoveSmallPool
  {Unlock the block type}
  mov TSmallBlockType[ebx].BlockTypeLocked, False
  {Restore ebx}
  pop ebx
  {All done}
  ret
  {Align branch target}
{$ifndef AssumeMultiThreaded}
  nop
  nop
{$endif}
  nop
@TrySmallSequentialFeed:
  {Try to feed a small block sequentially: Get the sequential feed block pool}
  mov edx, TSmallBlockType[ebx].CurrentSequentialFeedPool
  {Get the next sequential feed address so long}
  movzx ecx, TSmallBlockType[ebx].BlockSize
  add ecx, eax
  {Can another block fit?}
  cmp eax, TSmallBlockType[ebx].MaxSequentialFeedBlockAddress
  ja @AllocateSmallBlockPool
  {Increment the number of used blocks in the sequential feed pool}
  add TSmallBlockPoolHeader[edx].BlocksInUse, 1
  {Store the next sequential feed block address}
  mov TSmallBlockType[ebx].NextSequentialFeedBlockAddress, ecx
  {Unlock the block type}
  mov TSmallBlockType[ebx].BlockTypeLocked, False
  {Set the block header}
  mov [eax - 4], edx
  {Restore ebx}
  pop ebx
  {All done}
  ret
  {Align branch target}
  nop
  nop
  nop
@RemoveSmallPool:
  {Pool is full - remove it from the partially free list}
  mov ecx, TSmallBlockPoolHeader[edx].NextPartiallyFreePool
  mov TSmallBlockPoolHeader[ecx].PreviousPartiallyFreePool, ebx
  mov TSmallBlockType[ebx].NextPartiallyFreePool, ecx
  {Unlock the block type}
  mov TSmallBlockType[ebx].BlockTypeLocked, False
  {Restore ebx}
  pop ebx
  {All done}
  ret
  {Align branch target}
  nop
  nop
@LockBlockTypeLoop:
  mov eax, $100
  {Attempt to grab the block type}
  lock cmpxchg TSmallBlockType([ebx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {Try the next size}
  add ebx, Type(TSmallBlockType)
  mov eax, $100
  lock cmpxchg TSmallBlockType([ebx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {Try the next size (up to two sizes larger)}
  add ebx, Type(TSmallBlockType)
  mov eax, $100
  lock cmpxchg TSmallBlockType([ebx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {Block type and two sizes larger are all locked - give up and sleep}
  sub ebx, 2 * Type(TSmallBlockType)
{$ifdef NeverSleepOnThreadContention}
  {Pause instruction (improves performance on P4)}
  rep nop
  {$ifdef UseSwitchToThread}
  call SwitchToThread
  {$endif}
  {Try again}
  jmp @LockBlockTypeLoop
  {Align branch target}
  nop
  {$ifndef UseSwitchToThread}
  nop
  {$endif}
{$else}
  {Couldn't grab the block type - sleep and try again}
  push InitialSleepTime
  call Sleep
  {Try again}
  mov eax, $100
  {Attempt to grab the block type}
  lock cmpxchg TSmallBlockType([ebx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {Couldn't grab the block type - sleep and try again}
  push AdditionalSleepTime
  call Sleep
  {Try again}
  jmp @LockBlockTypeLoop
  {Align branch target}
  nop
  nop
  nop
{$endif}
@AllocateSmallBlockPool:
  {save additional registers}
  push esi
  push edi
  {Do we need to lock the medium blocks?}
{$ifndef AssumeMultiThreaded}
  cmp IsMultiThread, False
  je @MediumBlocksLockedForPool
{$endif}
  call LockMediumBlocks
@MediumBlocksLockedForPool:
  {Are there any available blocks of a suitable size?}
  movsx esi, TSmallBlockType[ebx].AllowedGroupsForBlockPoolBitmap
  and esi, MediumBlockBinGroupBitmap
  jz @NoSuitableMediumBlocks
  {Get the bin group number with free blocks in eax}
  bsf eax, esi
  {Get the bin number in ecx}
  lea esi, [eax * 8]
  mov ecx, dword ptr [MediumBlockBinBitmaps + eax * 4]
  bsf ecx, ecx
  lea ecx, [ecx + esi * 4]
  {Get a pointer to the bin in edi}
  lea edi, [MediumBlockBins + ecx * 8]
  {Get the free block in esi}
  mov esi, TMediumFreeBlock[edi].NextFreeBlock
  {Remove the first block from the linked list (LIFO)}
  mov edx, TMediumFreeBlock[esi].NextFreeBlock
  mov TMediumFreeBlock[edi].NextFreeBlock, edx
  mov TMediumFreeBlock[edx].PreviousFreeBlock, edi
  {Is this bin now empty?}
  cmp edi, edx
  jne @MediumBinNotEmpty
  {eax = bin group number, ecx = bin number, edi = @bin, esi = free block, ebx = block type}
  {Flag this bin as empty}
  mov edx, -2
  rol edx, cl
  and dword ptr [MediumBlockBinBitmaps + eax * 4], edx
  jnz @MediumBinNotEmpty
  {Flag the group as empty}
  btr MediumBlockBinGroupBitmap, eax
@MediumBinNotEmpty:
  {esi = free block, ebx = block type}
  {Get the size of the available medium block in edi}
  mov edi, DropMediumAndLargeFlagsMask
  and edi, [esi - 4]
  cmp edi, MaximumSmallBlockPoolSize
  jb @UseWholeBlock
  {Split the block: get the size of the second part, new block size is the
   optimal size}
  mov edx, edi
  movzx edi, TSmallBlockType[ebx].OptimalBlockPoolSize
  sub edx, edi
  {Split the block in two}
  lea eax, [esi + edi]
  lea ecx, [edx + IsMediumBlockFlag + IsFreeBlockFlag]
  mov [eax - 4], ecx
  {Store the size of the second split as the second last dword}
  mov [eax + edx - 8], edx
  {Put the remainder in a bin (it will be big enough)}
  call InsertMediumBlockIntoBin
  jmp @GotMediumBlock
  {Align branch target}
{$ifdef AssumeMultiThreaded}
  nop
{$endif}
@NoSuitableMediumBlocks:
  {Check the sequential feed medium block pool for space}
  movzx ecx, TSmallBlockType[ebx].MinimumBlockPoolSize
  mov edi, MediumSequentialFeedBytesLeft
  cmp edi, ecx
  jb @AllocateNewSequentialFeed
  {Get the address of the last block that was fed}
  mov esi, LastSequentiallyFedMediumBlock
  {Enough sequential feed space: Will the remainder be usable?}
  movzx ecx, TSmallBlockType[ebx].OptimalBlockPoolSize
  lea edx, [ecx + MinimumMediumBlockSize]
  cmp edi, edx
  jb @NotMuchSpace
  mov edi, ecx
@NotMuchSpace:
  sub esi, edi
  {Update the sequential feed parameters}
  sub MediumSequentialFeedBytesLeft, edi
  mov LastSequentiallyFedMediumBlock, esi
  {Get the block pointer}
  jmp @GotMediumBlock
  {Align branch target}
@AllocateNewSequentialFeed:
  {Need to allocate a new sequential feed medium block pool: use the
   optimal size for this small block pool}
  movzx eax, TSmallBlockType[ebx].OptimalBlockPoolSize
  mov edi, eax
  {Allocate the medium block pool}
  call AllocNewSequentialFeedMediumPool
  mov esi, eax
  test eax, eax
  jnz @GotMediumBlock
  mov MediumBlocksLocked, al
  mov TSmallBlockType[ebx].BlockTypeLocked, al
  pop edi
  pop esi
  pop ebx
  ret
  {Align branch target}
@UseWholeBlock:
  {esi = free block, ebx = block type, edi = block size}
  {Mark this block as used in the block following it}
  and byte ptr [esi + edi - 4], not PreviousMediumBlockIsFreeFlag
@GotMediumBlock:
  {esi = free block, ebx = block type, edi = block size}
  {Set the size and flags for this block}
  lea ecx, [edi + IsMediumBlockFlag + IsSmallBlockPoolInUseFlag]
  mov [esi - 4], ecx
  {Unlock medium blocks}
  xor eax, eax
  mov MediumBlocksLocked, al
  {Set up the block pool}
  mov TSmallBlockPoolHeader[esi].BlockType, ebx
  mov TSmallBlockPoolHeader[esi].FirstFreeBlock, eax
  mov TSmallBlockPoolHeader[esi].BlocksInUse, 1
  {Set it up for sequential block serving}
  mov TSmallBlockType[ebx].CurrentSequentialFeedPool, esi
  {Return the pointer to the first block}
  lea eax, [esi + SmallBlockPoolHeaderSize]
  movzx ecx, TSmallBlockType[ebx].BlockSize
  lea edx, [eax + ecx]
  mov TSmallBlockType[ebx].NextSequentialFeedBlockAddress, edx
  add edi, esi
  sub edi, ecx
  mov TSmallBlockType[ebx].MaxSequentialFeedBlockAddress, edi
  {Unlock the small block type}
  mov TSmallBlockType[ebx].BlockTypeLocked, False
  {Set the small block header}
  mov [eax - 4], esi
  {Restore registers}
  pop edi
  pop esi
  pop ebx
  {Done}
  ret
{-------------------Medium block allocation-------------------}
  {Align branch target}
  nop
@NotASmallBlock:
  cmp eax, (MaximumMediumBlockSize - BlockHeaderSize)
  ja @IsALargeBlockRequest
  {Get the bin size for this block size. Block sizes are
   rounded up to the next bin size.}
  lea ebx, [eax + MediumBlockGranularity - 1 + BlockHeaderSize - MediumBlockSizeOffset]
  and ebx, -MediumBlockGranularity
  add ebx, MediumBlockSizeOffset
  {Do we need to lock the medium blocks?}
{$ifndef AssumeMultiThreaded}
  test cl, cl
  jz @MediumBlocksLocked
{$endif}
  call LockMediumBlocks
@MediumBlocksLocked:
  {Get the bin number in ecx and the group number in edx}
  lea edx, [ebx - MinimumMediumBlockSize]
  mov ecx, edx
  shr edx, 8 + 5
  shr ecx, 8
  {Is there a suitable block inside this group?}
  mov eax, -1
  shl eax, cl
  and eax, dword ptr [MediumBlockBinBitmaps + edx * 4]
  jz @GroupIsEmpty
  {Get the actual bin number}
  and ecx, -32
  bsf eax, eax
  or ecx, eax
  jmp @GotBinAndGroup
  {Align branch target}
  nop
@GroupIsEmpty:
  {Try all groups greater than this group}
  mov eax, -2
  mov ecx, edx
  shl eax, cl
  and eax, MediumBlockBinGroupBitmap
  jz @TrySequentialFeedMedium
  {There is a suitable group with space: get the bin number}
  bsf edx, eax
  {Get the bin in the group with free blocks}
  mov eax, dword ptr [MediumBlockBinBitmaps + edx * 4]
  bsf ecx, eax
  mov eax, edx
  shl eax, 5
  or ecx, eax
  jmp @GotBinAndGroup
  {Align branch target}
  nop
@TrySequentialFeedMedium:
  mov ecx, MediumSequentialFeedBytesLeft
  {Block can be fed sequentially?}
  sub ecx, ebx
  jc @AllocateNewSequentialFeedForMedium
  {Get the block address}
  mov eax, LastSequentiallyFedMediumBlock
  sub eax, ebx
  mov LastSequentiallyFedMediumBlock, eax
  {Store the remaining bytes}
  mov MediumSequentialFeedBytesLeft, ecx
  {Set the flags for the block}
  or ebx, IsMediumBlockFlag
  mov [eax - 4], ebx
  jmp @MediumBlockGetDone
  {Align branch target}
@AllocateNewSequentialFeedForMedium:
  mov eax, ebx
  call AllocNewSequentialFeedMediumPool
@MediumBlockGetDone:
  mov MediumBlocksLocked, False
  pop ebx
  ret
  {Align branch target}
@GotBinAndGroup:
  {ebx = block size, ecx = bin number, edx = group number}
  push esi
  push edi
  {Get a pointer to the bin in edi}
  lea edi, [MediumBlockBins + ecx * 8]
  {Get the free block in esi}
  mov esi, TMediumFreeBlock[edi].NextFreeBlock
  {Remove the first block from the linked list (LIFO)}
  mov eax, TMediumFreeBlock[esi].NextFreeBlock
  mov TMediumFreeBlock[edi].NextFreeBlock, eax
  mov TMediumFreeBlock[eax].PreviousFreeBlock, edi
  {Is this bin now empty?}
  cmp edi, eax
  jne @MediumBinNotEmptyForMedium
  {eax = bin group number, ecx = bin number, edi = @bin, esi = free block, ebx = block size}
  {Flag this bin as empty}
  mov eax, -2
  rol eax, cl
  and dword ptr [MediumBlockBinBitmaps + edx * 4], eax
  jnz @MediumBinNotEmptyForMedium
  {Flag the group as empty}
  btr MediumBlockBinGroupBitmap, edx
@MediumBinNotEmptyForMedium:
  {esi = free block, ebx = block size}
  {Get the size of the available medium block in edi}
  mov edi, DropMediumAndLargeFlagsMask
  and edi, [esi - 4]
  {Get the size of the second split in edx}
  mov edx, edi
  sub edx, ebx
  jz @UseWholeBlockForMedium
  {Split the block in two}
  lea eax, [esi + ebx]
  lea ecx, [edx + IsMediumBlockFlag + IsFreeBlockFlag]
  mov [eax - 4], ecx
  {Store the size of the second split as the second last dword}
  mov [eax + edx - 8], edx
  {Put the remainder in a bin}
  cmp edx, MinimumMediumBlockSize
  jb @GotMediumBlockForMedium
  call InsertMediumBlockIntoBin
  jmp @GotMediumBlockForMedium
  {Align branch target}
  nop
  nop
  nop
@UseWholeBlockForMedium:
  {Mark this block as used in the block following it}
  and byte ptr [esi + edi - 4], not PreviousMediumBlockIsFreeFlag
@GotMediumBlockForMedium:
  {Set the size and flags for this block}
  lea ecx, [ebx + IsMediumBlockFlag]
  mov [esi - 4], ecx
  {Unlock medium blocks}
  mov MediumBlocksLocked, False
  mov eax, esi
  pop edi
  pop esi
  pop ebx
  ret
{-------------------Large block allocation-------------------}
  {Align branch target}
@IsALargeBlockRequest:
  pop ebx
  test eax, eax
  jns AllocateLargeBlock
  xor eax, eax
end;
{$endif}
{$endif}

{Frees a medium block, returning 0 on success, -1 otherwise}
function FreeMediumBlock(APointer: Pointer): Integer;
var
  LNextMediumBlock{$ifndef FullDebugMode}, LPreviousMediumBlock{$endif}: PMediumFreeBlock;
  LNextMediumBlockSizeAndFlags: NativeUInt;
  LBlockSize{$ifndef FullDebugMode}, LPreviousMediumBlockSize{$endif}: Cardinal;
{$ifndef FullDebugMode}
  LPPreviousMediumBlockPoolHeader, LPNextMediumBlockPoolHeader: PMediumBlockPoolHeader;
{$endif}
  LBlockHeader: NativeUInt;
begin
  {Get the block header}
  LBlockHeader := PNativeUInt(PByte(APointer) - BlockHeaderSize)^;
  {Get the medium block size}
  LBlockSize := LBlockHeader and DropMediumAndLargeFlagsMask;
  {Lock the medium blocks}
  LockMediumBlocks;
  {Can we combine this block with the next free block?}
  LNextMediumBlock := PMediumFreeBlock(PByte(APointer) + LBlockSize);
  LNextMediumBlockSizeAndFlags := PNativeUInt(PByte(LNextMediumBlock) - BlockHeaderSize)^;
{$ifndef FullDebugMode}
{$ifdef CheckHeapForCorruption}
  {Check that this block was flagged as in use in the next block}
  if (LNextMediumBlockSizeAndFlags and PreviousMediumBlockIsFreeFlag) <> 0 then
{$ifdef BCB6OrDelphi7AndUp}
    System.Error(reInvalidPtr);
{$else}
    System.RunError(reInvalidPtr);
{$endif}
{$endif}
  if (LNextMediumBlockSizeAndFlags and IsFreeBlockFlag) <> 0 then
  begin
    {Increase the size of this block}
    Inc(LBlockSize, LNextMediumBlockSizeAndFlags and DropMediumAndLargeFlagsMask);
    {Remove the next block as well}
    if LNextMediumBlockSizeAndFlags >= MinimumMediumBlockSize then
      RemoveMediumFreeBlock(LNextMediumBlock);
  end
  else
  begin
{$endif}
    {Reset the "previous in use" flag of the next block}
    PNativeUInt(PByte(LNextMediumBlock) - BlockHeaderSize)^ := LNextMediumBlockSizeAndFlags or PreviousMediumBlockIsFreeFlag;
{$ifndef FullDebugMode}
  end;
  {Can we combine this block with the previous free block? We need to
   re-read the flags since it could have changed before we could lock the
   medium blocks.}
  if (PNativeUInt(PByte(APointer) - BlockHeaderSize)^ and PreviousMediumBlockIsFreeFlag) <> 0 then
  begin
    {Get the size of the free block just before this one}
    LPreviousMediumBlockSize := PNativeUInt(PByte(APointer) - 2 * BlockHeaderSize)^;
    {Get the start of the previous block}
    LPreviousMediumBlock := PMediumFreeBlock(PByte(APointer) - LPreviousMediumBlockSize);
{$ifdef CheckHeapForCorruption}
    {Check that the previous block is actually free}
    if (PNativeUInt(PByte(LPreviousMediumBlock) - BlockHeaderSize)^ and ExtractMediumAndLargeFlagsMask) <> (IsMediumBlockFlag or IsFreeBlockFlag) then
{$ifdef BCB6OrDelphi7AndUp}
    System.Error(reInvalidPtr);
{$else}
    System.RunError(reInvalidPtr);
{$endif}
{$endif}
    {Set the new block size}
    Inc(LBlockSize, LPreviousMediumBlockSize);
    {This is the new current block}
    APointer := LPreviousMediumBlock;
    {Remove the previous block from the linked list}
    if LPreviousMediumBlockSize >= MinimumMediumBlockSize then
      RemoveMediumFreeBlock(LPreviousMediumBlock);
  end;
{$ifdef CheckHeapForCorruption}
  {Check that the previous block is currently flagged as in use}
  if (PNativeUInt(PByte(APointer) - BlockHeaderSize)^ and PreviousMediumBlockIsFreeFlag) <> 0 then
{$ifdef BCB6OrDelphi7AndUp}
    System.Error(reInvalidPtr);
{$else}
    System.RunError(reInvalidPtr);
{$endif}
{$endif}
  {Is the entire medium block pool free, and there are other free blocks
   that can fit the largest possible medium block? -> free it. (Except in
   full debug mode where medium pools are never freed.)}
  if (LBlockSize <> (MediumBlockPoolSize - MediumBlockPoolHeaderSize)) then
  begin
    {Store the size of the block as well as the flags}
    PNativeUInt(PByte(APointer) - BlockHeaderSize)^ := LBlockSize or (IsMediumBlockFlag or IsFreeBlockFlag);
{$else}
    {Mark the block as free}
    Inc(PNativeUInt(PByte(APointer) - BlockHeaderSize)^, IsFreeBlockFlag);
{$endif}
    {Store the trailing size marker}
    PNativeUInt(PByte(APointer) + LBlockSize - 2 * BlockHeaderSize)^ := LBlockSize;
    {Insert this block back into the bins: Size check not required here,
     since medium blocks that are in use are not allowed to be
     shrunk smaller than MinimumMediumBlockSize}
    InsertMediumBlockIntoBin(APointer, LBlockSize);
{$ifndef FullDebugMode}
{$ifdef CheckHeapForCorruption}
    {Check that this block is actually free and the next and previous blocks are both in use.}
    if ((PNativeUInt(PByte(APointer) - BlockHeaderSize)^ and ExtractMediumAndLargeFlagsMask) <> (IsMediumBlockFlag or IsFreeBlockFlag))
      or ((PNativeUInt(PByte(APointer) + (PNativeUInt(PByte(APointer) - BlockHeaderSize)^ and DropMediumAndLargeFlagsMask) - BlockHeaderSize)^ and IsFreeBlockFlag) <> 0) then
    begin
{$ifdef BCB6OrDelphi7AndUp}
    System.Error(reInvalidPtr);
{$else}
    System.RunError(reInvalidPtr);
{$endif}
    end;
{$endif}
{$endif}
    {Unlock medium blocks}
    MediumBlocksLocked := False;
    {All OK}
    Result := 0;
{$ifndef FullDebugMode}
  end
  else
  begin
    {Should this become the new sequential feed?}
    if MediumSequentialFeedBytesLeft <> MediumBlockPoolSize - MediumBlockPoolHeaderSize then
    begin
      {Bin the current sequential feed}
      BinMediumSequentialFeedRemainder;
      {Set this medium pool up as the new sequential feed pool:
       Store the sequential feed pool trailer}
      PNativeUInt(PByte(APointer) + LBlockSize - BlockHeaderSize)^ := IsMediumBlockFlag;
      {Store the number of bytes available in the sequential feed chunk}
      MediumSequentialFeedBytesLeft := MediumBlockPoolSize - MediumBlockPoolHeaderSize;
      {Set the last sequentially fed block}
      LastSequentiallyFedMediumBlock := Pointer(PByte(APointer) + LBlockSize);
      {Unlock medium blocks}
      MediumBlocksLocked := False;
      {Success}
      Result := 0;
    end
    else
    begin
      {Remove this medium block pool from the linked list}
      Dec(PByte(APointer), MediumBlockPoolHeaderSize);
      LPPreviousMediumBlockPoolHeader := PMediumBlockPoolHeader(APointer).PreviousMediumBlockPoolHeader;
      LPNextMediumBlockPoolHeader := PMediumBlockPoolHeader(APointer).NextMediumBlockPoolHeader;
      LPPreviousMediumBlockPoolHeader.NextMediumBlockPoolHeader := LPNextMediumBlockPoolHeader;
      LPNextMediumBlockPoolHeader.PreviousMediumBlockPoolHeader := LPPreviousMediumBlockPoolHeader;
      {Unlock medium blocks}
      MediumBlocksLocked := False;
{$ifdef ClearMediumBlockPoolsBeforeReturningToOS}
      FillChar(APointer^, MediumBlockPoolSize, 0);
{$endif}
      {Free the medium block pool}
      if VirtualFree(APointer, 0, MEM_RELEASE) then
        Result := 0
      else
        Result := -1;
    end;
  end;
{$endif}
end;

{Replacement for SysFreeMem}
function FastFreeMem(APointer: Pointer): Integer;
var
  LPSmallBlockPool{$ifndef FullDebugMode}, LPPreviousPool, LPNextPool{$endif},
    LPOldFirstPool: PSmallBlockPoolHeader;
  LPSmallBlockType: PSmallBlockType;
  LOldFirstFreeBlock: Pointer;
  LBlockHeader: NativeUInt;
begin
  {Get the small block header: Is it actually a small block?}
  LBlockHeader := PNativeUInt(PByte(APointer) - BlockHeaderSize)^;
  {Is it a small block that is in use?}
  if LBlockHeader and (IsFreeBlockFlag or IsMediumBlockFlag or IsLargeBlockFlag) = 0 then
  begin
    {Get a pointer to the block pool}
    LPSmallBlockPool := PSmallBlockPoolHeader(LBlockHeader);
    {Get the block type}
    LPSmallBlockType := LPSmallBlockPool.BlockType;
{$ifdef ClearSmallAndMediumBlocksInFreeMem}
    FillChar(APointer^, LPSmallBlockType.BlockSize - BlockHeaderSize, 0);
{$endif}
    {Lock the block type}
{$ifndef AssumeMultiThreaded}
    if IsMultiThread then
{$endif}
    begin
      while (LockCmpxchg(0, 1, @LPSmallBlockType.BlockTypeLocked) <> 0) do
      begin
{$ifdef NeverSleepOnThreadContention}
  {$ifdef UseSwitchToThread}
        SwitchToThread;
  {$endif}
{$else}
        Sleep(InitialSleepTime);
        if LockCmpxchg(0, 1, @LPSmallBlockType.BlockTypeLocked) = 0 then
          Break;
        Sleep(AdditionalSleepTime);
{$endif}
      end;
    end;
    {Get the old first free block}
    LOldFirstFreeBlock := LPSmallBlockPool.FirstFreeBlock;
    {Was the pool manager previously full?}
    if LOldFirstFreeBlock = nil then
    begin
      {Insert this as the first partially free pool for the block size}
      LPOldFirstPool := LPSmallBlockType.NextPartiallyFreePool;
      LPSmallBlockPool.NextPartiallyFreePool := LPOldFirstPool;
      LPOldFirstPool.PreviousPartiallyFreePool := LPSmallBlockPool;
      LPSmallBlockPool.PreviousPartiallyFreePool := PSmallBlockPoolHeader(LPSmallBlockType);
      LPSmallBlockType.NextPartiallyFreePool := LPSmallBlockPool;
    end;
    {Store the old first free block}
    PNativeUInt(PByte(APointer) - BlockHeaderSize)^ := UIntPtr(LOldFirstFreeBlock) or IsFreeBlockFlag;
    {Store this as the new first free block}
    LPSmallBlockPool.FirstFreeBlock := APointer;
    {Decrement the number of allocated blocks}
    Dec(LPSmallBlockPool.BlocksInUse);
    {Small block pools are never freed in full debug mode. This increases the
     likehood of success in catching objects still being used after being
     destroyed.}
{$ifndef FullDebugMode}
    {Is the entire pool now free? -> Free it.}
    if LPSmallBlockPool.BlocksInUse = 0 then
    begin
      {Get the previous and next chunk managers}
      LPPreviousPool := LPSmallBlockPool.PreviousPartiallyFreePool;
      LPNextPool := LPSmallBlockPool.NextPartiallyFreePool;
      {Remove this manager}
      LPPreviousPool.NextPartiallyFreePool := LPNextPool;
      LPNextPool.PreviousPartiallyFreePool := LPPreviousPool;
      {Is this the sequential feed pool? If so, stop sequential feeding}
      if (LPSmallBlockType.CurrentSequentialFeedPool = LPSmallBlockPool) then
        LPSmallBlockType.MaxSequentialFeedBlockAddress := nil;
      {Unlock this block type}
      LPSmallBlockType.BlockTypeLocked := False;
      {Free the block pool}
      FreeMediumBlock(LPSmallBlockPool);
    end
    else
    begin
{$endif}
      {Unlock this block type}
      LPSmallBlockType.BlockTypeLocked := False;
{$ifndef FullDebugMode}
    end;
{$endif}
    {No error}
    Result := 0;
  end
  else
  begin
    {Is this a medium block or a large block?}
    if LBlockHeader and (IsFreeBlockFlag or IsLargeBlockFlag) = 0 then
    begin
{$ifdef ClearSmallAndMediumBlocksInFreeMem}
      {Get the block header, extract the block size and clear the block it.}
      LBlockHeader := PNativeUInt(PByte(APointer) - BlockHeaderSize)^;
      FillChar(APointer^,
        (LBlockHeader and DropMediumAndLargeFlagsMask) - BlockHeaderSize, 0);
{$endif}
      Result := FreeMediumBlock(APointer);
    end
    else
    begin
      {Validate: Is this actually a Large block, or is it an attempt to free an
       already freed small block?}
      if LBlockHeader and (IsFreeBlockFlag or IsMediumBlockFlag) = 0 then
        Result := FreeLargeBlock(APointer)
      else
        Result := -1;
    end;
  end;
end;

{$ifndef FullDebugMode}
{Replacement for SysReallocMem}
function FastReallocMem(APointer: Pointer; ANewSize: {$ifdef XE2AndUp}NativeInt{$else}Integer{$endif}): Pointer;
var
  LBlockHeader, LNextBlockSizeAndFlags, LNewAllocSize, LBlockFlags,
    LOldAvailableSize, LNextBlockSize, LNewAvailableSize, LMinimumUpsize,
    LSecondSplitSize, LNewBlockSize: NativeUInt;
  LPSmallBlockType: PSmallBlockType;
  LPNextBlock, LPNextBlockHeader: Pointer;

  {Upsizes a large block in-place. The following variables are assumed correct:
    LBlockFlags, LOldAvailableSize, LPNextBlock, LNextBlockSizeAndFlags,
    LNextBlockSize, LNewAvailableSize. Medium blocks must be locked on entry if
    required.}
  procedure MediumBlockInPlaceUpsize;
  begin
    {Remove the next block}
    if LNextBlockSizeAndFlags >= MinimumMediumBlockSize then
      RemoveMediumFreeBlock(LPNextBlock);
    {Add 25% for medium block in-place upsizes}
    LMinimumUpsize := LOldAvailableSize + (LOldAvailableSize shr 2);
    if NativeUInt(ANewSize) < LMinimumUpsize then
      LNewAllocSize := LMinimumUpsize
    else
      LNewAllocSize := NativeUInt(ANewSize);
    {Round up to the nearest block size granularity}
    LNewBlockSize := ((LNewAllocSize + (BlockHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset))
      and -MediumBlockGranularity) + MediumBlockSizeOffset;
    {Calculate the size of the second split}
    LSecondSplitSize := LNewAvailableSize + BlockHeaderSize - LNewBlockSize;
    {Does it fit?}
    if NativeInt(LSecondSplitSize) <= 0 then
    begin
      {The block size is the full available size plus header}
      LNewBlockSize := LNewAvailableSize + BlockHeaderSize;
      {Grab the whole block: Mark it as used in the block following it}
      LPNextBlockHeader := Pointer(PByte(APointer) + LNewAvailableSize);
      PNativeUInt(LPNextBlockHeader)^ :=
        PNativeUInt(LPNextBlockHeader)^ and (not PreviousMediumBlockIsFreeFlag);
    end
    else
    begin
      {Split the block in two}
      LPNextBlock := PMediumFreeBlock(PByte(APointer) + LNewBlockSize);
      {Set the size of the second split}
      PNativeUInt(PByte(LPNextBlock) - BlockHeaderSize)^ := LSecondSplitSize or (IsMediumBlockFlag or IsFreeBlockFlag);
      {Store the size of the second split before the header of the next block}
      PNativeUInt(PByte(LPNextBlock) + LSecondSplitSize - 2 * BlockHeaderSize)^ := LSecondSplitSize;
      {Put the remainder in a bin if it is big enough}
      if LSecondSplitSize >= MinimumMediumBlockSize then
        InsertMediumBlockIntoBin(LPNextBlock, LSecondSplitSize);
    end;
    {Set the size and flags for this block}
    PNativeUInt(PByte(APointer) - BlockHeaderSize)^ := LNewBlockSize or LBlockFlags;
  end;

  {In-place downsize of a medium block. On entry Size must be less than half of
   LOldAvailableSize.}
  procedure MediumBlockInPlaceDownsize;
  begin
    {Round up to the next medium block size}
    LNewBlockSize := ((ANewSize + (BlockHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset))
      and -MediumBlockGranularity) + MediumBlockSizeOffset;
    {Get the size of the second split}
    LSecondSplitSize := (LOldAvailableSize + BlockHeaderSize) - LNewBlockSize;
    {Lock the medium blocks}
    LockMediumBlocks;
    {Set the new size}
    PNativeUInt(PByte(APointer) - BlockHeaderSize)^ :=
      (PNativeUInt(PByte(APointer) - BlockHeaderSize)^ and ExtractMediumAndLargeFlagsMask)
      or LNewBlockSize;
    {Is the next block in use?}
    LPNextBlock := PNativeUInt(PByte(APointer) + LOldAvailableSize + BlockHeaderSize);
    LNextBlockSizeAndFlags := PNativeUInt(PByte(LPNextBlock) - BlockHeaderSize)^;
    if LNextBlockSizeAndFlags and IsFreeBlockFlag = 0 then
    begin
      {The next block is in use: flag its previous block as free}
      PNativeUInt(PByte(LPNextBlock) - BlockHeaderSize)^ :=
        LNextBlockSizeAndFlags or PreviousMediumBlockIsFreeFlag;
    end
    else
    begin
      {The next block is free: combine it}
      LNextBlockSizeAndFlags := LNextBlockSizeAndFlags and DropMediumAndLargeFlagsMask;
      Inc(LSecondSplitSize, LNextBlockSizeAndFlags);
      if LNextBlockSizeAndFlags >= MinimumMediumBlockSize then
        RemoveMediumFreeBlock(LPNextBlock);
    end;
    {Set the split}
    LPNextBlock := PNativeUInt(PByte(APointer) + LNewBlockSize);
    {Store the free part's header}
    PNativeUInt(PByte(LPNextBlock) - BlockHeaderSize)^ := LSecondSplitSize or (IsMediumBlockFlag or IsFreeBlockFlag);
    {Store the trailing size field}
    PNativeUInt(PByte(LPNextBlock) + LSecondSplitSize - 2 * BlockHeaderSize)^ := LSecondSplitSize;
    {Bin this free block}
    if LSecondSplitSize >= MinimumMediumBlockSize then
      InsertMediumBlockIntoBin(LPNextBlock, LSecondSplitSize);
    {Unlock the medium blocks}
    MediumBlocksLocked := False;
  end;

begin
  {Get the block header: Is it actually a small block?}
  LBlockHeader := PNativeUInt(PByte(APointer) - BlockHeaderSize)^;
  {Is it a small block that is in use?}
  if LBlockHeader and (IsFreeBlockFlag or IsMediumBlockFlag or IsLargeBlockFlag) = 0 then
  begin
    {-----------------------------------Small block-------------------------------------}
    {The block header is a pointer to the block pool: Get the block type}
    LPSmallBlockType := PSmallBlockPoolHeader(LBlockHeader).BlockType;
    {Get the available size inside blocks of this type.}
    LOldAvailableSize := LPSmallBlockType.BlockSize - BlockHeaderSize;
    {Is it an upsize or a downsize?}
    if LOldAvailableSize >= NativeUInt(ANewSize) then
    begin
      {It's a downsize. Do we need to allocate a smaller block? Only if the new
       block size is less than a quarter of the available size less
       SmallBlockDownsizeCheckAdder bytes}
      if (NativeUInt(ANewSize) * 4 + SmallBlockDownsizeCheckAdder) >= LOldAvailableSize then
      begin
        {In-place downsize - return the pointer}
        Result := APointer;
        Exit;
      end
      else
      begin
        {Allocate a smaller block}
        Result := FastGetMem(ANewSize);
        {Allocated OK?}
        if Result <> nil then
        begin
          {Move the data across}
{$ifdef UseCustomVariableSizeMoveRoutines}
  {$ifdef Align16Bytes}
          MoveX16LP(APointer^, Result^, ANewSize);
  {$else}
          MoveX8LP(APointer^, Result^, ANewSize);
  {$endif}
{$else}
          System.Move(APointer^, Result^, ANewSize);
{$endif}
          {Free the old pointer}
          FastFreeMem(APointer);
        end;
      end;
    end
    else
    begin
      {This pointer is being reallocated to a larger block and therefore it is
       logical to assume that it may be enlarged again. Since reallocations are
       expensive, there is a minimum upsize percentage to avoid unnecessary
       future move operations.}
      {Must grow with at least 100% + x bytes}
      LNewAllocSize := LOldAvailableSize * 2 + SmallBlockUpsizeAdder;
      {Still not large enough?}
      if LNewAllocSize < NativeUInt(ANewSize) then
        LNewAllocSize := NativeUInt(ANewSize);
      {Allocate the new block}
      Result := FastGetMem(LNewAllocSize);
      {Allocated OK?}
      if Result <> nil then
      begin
        {Do we need to store the requested size? Only large blocks store the
         requested size.}
        if LNewAllocSize > (MaximumMediumBlockSize - BlockHeaderSize) then
          PLargeBlockHeader(PByte(Result) - LargeBlockHeaderSize).UserAllocatedSize := ANewSize;
        {Move the data across}
{$ifdef UseCustomFixedSizeMoveRoutines}
        LPSmallBlockType.UpsizeMoveProcedure(APointer^, Result^, LOldAvailableSize);
{$else}
        System.Move(APointer^, Result^, LOldAvailableSize);
{$endif}
        {Free the old pointer}
        FastFreeMem(APointer);
      end;
    end;
  end
  else
  begin
    {Is this a medium block or a large block?}
    if LBlockHeader and (IsFreeBlockFlag or IsLargeBlockFlag) = 0 then
    begin
      {-------------------------------Medium block--------------------------------------}
      {What is the available size in the block being reallocated?}
      LOldAvailableSize := (LBlockHeader and DropMediumAndLargeFlagsMask);
      {Get a pointer to the next block}
      LPNextBlock := PNativeUInt(PByte(APointer) + LOldAvailableSize);
      {Subtract the block header size from the old available size}
      Dec(LOldAvailableSize, BlockHeaderSize);
      {Is it an upsize or a downsize?}
      if NativeUInt(ANewSize) > LOldAvailableSize then
      begin
        {Can we do an in-place upsize?}
        LNextBlockSizeAndFlags := PNativeUInt(PByte(LPNextBlock) - BlockHeaderSize)^;
        {Is the next block free?}
        if LNextBlockSizeAndFlags and IsFreeBlockFlag <> 0 then
        begin
          LNextBlockSize := LNextBlockSizeAndFlags and DropMediumAndLargeFlagsMask;
          {The available size including the next block}
          LNewAvailableSize := LOldAvailableSize + LNextBlockSize;
          {Can the block fit?}
          if NativeUInt(ANewSize) <= LNewAvailableSize then
          begin
            {The next block is free and there is enough space to grow this
             block in place.}
{$ifndef AssumeMultiThreaded}
            if IsMultiThread then
            begin
{$endif}
              {Multi-threaded application - lock medium blocks and re-read the
               information on the blocks.}
              LockMediumBlocks;
              {Re-read the info for this block}
              LBlockFlags := PNativeUInt(PByte(APointer) - BlockHeaderSize)^ and ExtractMediumAndLargeFlagsMask;
              {Re-read the info for the next block}
              LNextBlockSizeAndFlags := PNativeUInt(PByte(LPNextBlock) - BlockHeaderSize)^;
              {Recalculate the next block size}
              LNextBlockSize := LNextBlockSizeAndFlags and DropMediumAndLargeFlagsMask;
              {The available size including the next block}
              LNewAvailableSize := LOldAvailableSize + LNextBlockSize;
              {Is the next block still free and the size still sufficient?}
              if (LNextBlockSizeAndFlags and IsFreeBlockFlag <> 0)
                and (NativeUInt(ANewSize) <= LNewAvailableSize) then
              begin
                {Upsize the block in-place}
                MediumBlockInPlaceUpsize;
                {Unlock the medium blocks}
                MediumBlocksLocked := False;
                {Return the result}
                Result := APointer;
                {Done}
                Exit;
              end;
              {Couldn't use the block: Unlock the medium blocks}
              MediumBlocksLocked := False;
{$ifndef AssumeMultiThreaded}
            end
            else
            begin
              {Extract the block flags}
              LBlockFlags := ExtractMediumAndLargeFlagsMask and LBlockHeader;
              {Upsize the block in-place}
              MediumBlockInPlaceUpsize;
              {Return the result}
              Result := APointer;
              {Done}
              Exit;
            end;
{$endif}
          end;
        end;
        {Couldn't upsize in place. Grab a new block and move the data across:
         If we have to reallocate and move medium blocks, we grow by at
         least 25%}
        LMinimumUpsize := LOldAvailableSize + (LOldAvailableSize shr 2);
        if NativeUInt(ANewSize) < LMinimumUpsize then
          LNewAllocSize := LMinimumUpsize
        else
          LNewAllocSize := NativeUInt(ANewSize);
        {Allocate the new block}
        Result := FastGetMem(LNewAllocSize);
        if Result <> nil then
        begin
          {If it's a large block - store the actual user requested size}
          if LNewAllocSize > (MaximumMediumBlockSize - BlockHeaderSize) then
            PLargeBlockHeader(PByte(Result) - LargeBlockHeaderSize).UserAllocatedSize := ANewSize;
          {Move the data across}
{$ifdef UseCustomVariableSizeMoveRoutines}
          MoveX16LP(APointer^, Result^, LOldAvailableSize);
{$else}
          System.Move(APointer^, Result^, LOldAvailableSize);
{$endif}
          {Free the old block}
          FastFreeMem(APointer);
        end;
      end
      else
      begin
        {Must be less than half the current size or we don't bother resizing.}
        if NativeUInt(ANewSize * 2) >= LOldAvailableSize then
        begin
          Result := APointer;
        end
        else
        begin
          {In-place downsize? Balance the cost of moving the data vs. the cost
           of fragmenting the memory pool. Medium blocks in use may never be
           smaller than MinimumMediumBlockSize.}
          if NativeUInt(ANewSize) >= (MinimumMediumBlockSize - BlockHeaderSize) then
          begin
            MediumBlockInPlaceDownsize;
            Result := APointer;
          end
          else
          begin
            {The requested size is less than the minimum medium block size. If
             the requested size is less than the threshold value (currently a
             quarter of the minimum medium block size), move the data to a small
             block, otherwise shrink the medium block to the minimum allowable
             medium block size.}
            if NativeUInt(ANewSize) >= MediumInPlaceDownsizeLimit then
            begin
              {The request is for a size smaller than the minimum medium block
               size, but not small enough to justify moving data: Reduce the
               block size to the minimum medium block size}
              ANewSize := MinimumMediumBlockSize - BlockHeaderSize;
              {Is it already at the minimum medium block size?}
              if LOldAvailableSize > NativeUInt(ANewSize) then
                MediumBlockInPlaceDownsize;
              Result := APointer;
            end
            else
            begin
              {Allocate the new block}
              Result := FastGetMem(ANewSize);
              if Result <> nil then
              begin
                {Move the data across}
{$ifdef UseCustomVariableSizeMoveRoutines}
  {$ifdef Align16Bytes}
                MoveX16LP(APointer^, Result^, ANewSize);
  {$else}
                MoveX8LP(APointer^, Result^, ANewSize);
  {$endif}
{$else}
                System.Move(APointer^, Result^, ANewSize);
{$endif}
                {Free the old block}
                FastFreeMem(APointer);
              end;
            end;
          end;
        end;
      end;
    end
    else
    begin
      {Is this a valid large block?}
      if LBlockHeader and (IsFreeBlockFlag or IsMediumBlockFlag) = 0 then
      begin
        {-----------------------Large block------------------------------}
        Result := ReallocateLargeBlock(APointer, ANewSize);
      end
      else
      begin
        {-----------------------Invalid block------------------------------}
        {Bad pointer: probably an attempt to reallocate a free memory block.}
        Result := nil;
      end;
    end;
  end;
end;

{Allocates a block and fills it with zeroes}
function FastAllocMem(ASize: {$ifdef XE2AndUp}NativeInt{$else}Cardinal{$endif}): Pointer;
begin
  Result := FastGetMem(ASize);
  {Large blocks are already zero filled}
  if (Result <> nil) and (ASize <= (MaximumMediumBlockSize - BlockHeaderSize)) then
    FillChar(Result^, ASize, 0);
end;

{----------------------------Memory Manager Setup-----------------------------}

{Initializes the lookup tables for the memory manager}
procedure InitializeMemoryManager;
const
  {The size of the Inc(VMTIndex) code in TFreedObject.GetVirtualMethodIndex}
  VMTIndexIncCodeSize = 6;
var
  LInd, LSizeInd, LMinimumPoolSize, LOptimalPoolSize, LGroupNumber,
    LBlocksPerPool, LPreviousBlockSize: Cardinal;
  LPMediumFreeBlock: PMediumFreeBlock;
begin
  {Initialize the memory manager}
  {-------------Set up the small block types-------------}
  LPreviousBlockSize := 0;
  for LInd := 0 to High(SmallBlockTypes) do
  begin
    {Set the move procedure}
{$ifdef UseCustomFixedSizeMoveRoutines}
    {The upsize move procedure may move chunks in 16 bytes even with 8-byte
    alignment, since the new size will always be at least 8 bytes bigger than
    the old size.}
    if not Assigned(SmallBlockTypes[LInd].UpsizeMoveProcedure) then
  {$ifdef UseCustomVariableSizeMoveRoutines}
      SmallBlockTypes[LInd].UpsizeMoveProcedure := MoveX16LP;
  {$else}
      SmallBlockTypes[LInd].UpsizeMoveProcedure := @System.Move;
  {$endif}
{$endif}
    {Set the first "available pool" to the block type itself, so that the
     allocation routines know that there are currently no pools with free
     blocks of this size.}
    SmallBlockTypes[LInd].PreviousPartiallyFreePool := @SmallBlockTypes[LInd];
    SmallBlockTypes[LInd].NextPartiallyFreePool := @SmallBlockTypes[LInd];
    {Set the block size to block type index translation table}
    for LSizeInd := (LPreviousBlockSize div SmallBlockGranularity) to ((SmallBlockTypes[LInd].BlockSize - 1) div SmallBlockGranularity) do
      AllocSize2SmallBlockTypeIndX4[LSizeInd] := LInd * 4;
    {Cannot sequential feed yet: Ensure that the next address is greater than
     the maximum address}
    SmallBlockTypes[LInd].MaxSequentialFeedBlockAddress := Pointer(0);
    SmallBlockTypes[LInd].NextSequentialFeedBlockAddress := Pointer(1);
    {Get the mask to use for finding a medium block suitable for a block pool}
    LMinimumPoolSize :=
      ((SmallBlockTypes[LInd].BlockSize * MinimumSmallBlocksPerPool
        + SmallBlockPoolHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset)
      and -MediumBlockGranularity) + MediumBlockSizeOffset;
    if LMinimumPoolSize < MinimumMediumBlockSize then
      LMinimumPoolSize := MinimumMediumBlockSize;
    {Get the closest group number for the minimum pool size}
    LGroupNumber := (LMinimumPoolSize - MinimumMediumBlockSize + MediumBlockBinsPerGroup * MediumBlockGranularity div 2)
      div (MediumBlockBinsPerGroup * MediumBlockGranularity);
    {Too large?}
    if LGroupNumber > 7 then
      LGroupNumber := 7;
    {Set the bitmap}
    SmallBlockTypes[LInd].AllowedGroupsForBlockPoolBitmap := Byte(-(1 shl LGroupNumber));
    {Set the minimum pool size}
    SmallBlockTypes[LInd].MinimumBlockPoolSize := MinimumMediumBlockSize + LGroupNumber * (MediumBlockBinsPerGroup * MediumBlockGranularity);
    {Get the optimal block pool size}
    LOptimalPoolSize := ((SmallBlockTypes[LInd].BlockSize * TargetSmallBlocksPerPool
        + SmallBlockPoolHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset)
      and -MediumBlockGranularity) + MediumBlockSizeOffset;
    {Limit the optimal pool size to within range}
    if LOptimalPoolSize < OptimalSmallBlockPoolSizeLowerLimit then
      LOptimalPoolSize := OptimalSmallBlockPoolSizeLowerLimit;
    if LOptimalPoolSize > OptimalSmallBlockPoolSizeUpperLimit then
      LOptimalPoolSize := OptimalSmallBlockPoolSizeUpperLimit;
    {How many blocks will fit in the adjusted optimal size?}
    LBlocksPerPool := (LOptimalPoolSize - SmallBlockPoolHeaderSize) div SmallBlockTypes[LInd].BlockSize;
    {Recalculate the optimal pool size to minimize wastage due to a partial
     last block.}
    SmallBlockTypes[LInd].OptimalBlockPoolSize :=
      ((LBlocksPerPool * SmallBlockTypes[LInd].BlockSize + SmallBlockPoolHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset) and -MediumBlockGranularity) + MediumBlockSizeOffset;

    {Set the previous small block size}
    LPreviousBlockSize := SmallBlockTypes[LInd].BlockSize;
  end;
  {-------------------Set up the medium blocks-------------------}

  {There are currently no medium block pools}
  MediumBlockPoolsCircularList.PreviousMediumBlockPoolHeader := @MediumBlockPoolsCircularList;
  MediumBlockPoolsCircularList.NextMediumBlockPoolHeader := @MediumBlockPoolsCircularList;
  {All medium bins are empty}
  for LInd := 0 to High(MediumBlockBins) do
  begin
    LPMediumFreeBlock := @MediumBlockBins[LInd];
    LPMediumFreeBlock.PreviousFreeBlock := LPMediumFreeBlock;
    LPMediumFreeBlock.NextFreeBlock := LPMediumFreeBlock;
  end;
  {------------------Set up the large blocks---------------------}
  LargeBlocksCircularList.PreviousLargeBlockHeader := @LargeBlocksCircularList;
  LargeBlocksCircularList.NextLargeBlockHeader := @LargeBlocksCircularList;
end;

{Installs the memory manager (InitializeMemoryManager should be called first)}
procedure InstallMemoryManager;
begin
  if not FastMMIsInstalled then
  begin
      NewMemoryManager.GetMem := FastGetMem;
      NewMemoryManager.FreeMem := FastFreeMem;
      NewMemoryManager.ReallocMem := FastReallocMem;

      {Owns the memory manager}
      IsMemoryManagerOwner := True;
    FastMMIsInstalled := True;
  end;
end;

initialization
  RunInitializationCode;

finalization
{$ifndef PatchBCBTerminate}
  FinalizeMemoryManager;
{$endif}

end.