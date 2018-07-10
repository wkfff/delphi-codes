unit getoptlib;
(*
   GNU getopt (from GNU textutils 1.12) ported to turbo pascal by H唊on L泇dal
   May 1996. Email:halovda@krs.hia.no, snailmail:Kile, 4653 H慻eland, Norway.
   [char-set for reading my name and address correct: ibm codepage 865]

   Copyright (C) 1987, 88, 89, 90, 91, 92, 93, 94, 95
   	Free Software Foundation, Inc.
   Copyright (C) 1996
        H唊on L泇dal

   This unit is covered by the GNU LIBRARY GENERAL PUBLIC LICENSE,
   which means that you may freely link this code into you programs,
   read the file COPYING.LIB for details.


   After being annoyed by having to "reinvent the wheel" each time
   I was writing a program that used commandline options, I finally decided
   to port getopt.

   The pascal code is kept as close to the original c as possible.
   All string handling is however changed into pascal strings.
   (There are a few (insignificant) things that could be changed,
   like 'optind' being initialized to 1 twice, but I haven't done it in
   order to be consistent with the original c code)

   There is some room for improvements, like not using an fixed size array for
   the arguments, but instead dynamicly allocating only the space needed.
   Expanding wildcards would also be a nice feature. But I don't plan to
   implement that or to do any further development. As long as the function
   processes the arguments, it serves my needs.


MANUAL (sort of)

DESCRIPTION

   For those that aren't familiar with getopt, here is a short explanation:
   Using getopt makes your program accept commandline options i several
   different ways. The following examples are all equal:
       program -a -b -c --longoption value nonoption
       program -abc --longoption=value nonoption
       program nonoption -c --longoption value -ba

   The programming interface is as follows:
   Call getopt repeatedly until it returns EOF_getopt. Each time it returns
   one option. Getopt is called with a string describing the valid options.
   A character followed by a ':' requires an argument (returned in the
   variable optarg).
   Example: "getopt( argc, argvptr^, 'f:vh')" will have 3 options
      '-f' (e.g. file) that requires an argument,
      '-v' (e.g. verbose) and
      '-h' (e.g. help).

   If getopt encounters an unknown option it returns '?', and in case of
   a missing argument it returns ':'.

BUGS

   The unit does not handle more than maxargs (64) arguments.

   The memory allocated for argv is never released.

*)




(*
   NOTE: getopt is now part of the C library, so if you don't know what
   "Keep this file name-space clean" means, talk to roland@gnu.ai.mit.edu
   before changing it!

   Copyright (C) 1987, 88, 89, 90, 91, 92, 93, 94, 95
   	Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
   Free Software Foundation; either version 2, or (at your option) any
   later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.  *)



(* This version of `getopt' appears to the caller like standard Unix `getopt'
   but it behaves differently for the user, since it allows the user
   to intersperse the options with the other arguments.

   As `getopt' works, it permutes the elements of ARGV so that,
   when it is done, all the options precede everything else.  Thus
   all application programs are extended to handle flexible argument order.

   Setting the environment variable POSIXLY_CORRECT disables permutation.
   Then the behavior is completely standard.

   GNU application programs can use a third alternative mode in which
   they can distinguish the relative order of options and other arguments.  *)




interface


(**************************************************************************)

const
  maxargs = 64;

type
  argvarray = array [0..maxargs] of string;

var
  argvptr : ^argvarray;
  argc    : integer;

const
   EOF_getopt = -1;



(* For communication from `getopt' to the caller.
   When `getopt' finds an option that takes an argument,
   the argument value is returned here.
   Also, when `ordering' is RETURN_IN_ORDER,
   each non-option ARGV-element is returned here.  *)

var

(* Callers store false here to inhibit the error message `getopt' prints
   for unrecognized options.  *)

   //duanyb: 默认不打印错误信息
   opterr : boolean = False;


(* Describe the long-named options requested by the application.
   The LONG_OPTIONS argument to getopt_long or getopt_long_only is a array
   of option records terminated by an element containing a name which is
   a empty string.

   The field `has_arg' is:
   no_argument		if the option does not take an argument,
   required_argument	if the option requires an argument,
   optional_argument 	if the option takes an optional argument.

   If the field `flag' is not NIL, it points to a variable that is set
   to the value given in the field `val' when the option is found, but
   left unchanged if the option is not found.

   To have a long-named option do something other than set an `int' to
   a compiled-in constant, such as set a value from `optarg', set the
   option's `flag' field to nil and its `val' field to a nonzero
   value (the equivalent single-letter option character, if there is
   one).  For long options that have a nil `flag' field, `getopt'
   returns the contents of the `val' field.  *)


//changed to var by uri fridman to compile under delphi/kylix
var
   optarg : string = '';
(* Index in ARGV of the next element to be scanned.
   This is used for communication to and from the caller
   and for communication between successive calls to `getopt'.

   On entry to `getopt', zero means this is the first call; initialize.

   When `getopt' returns EOF_getopt, this is the index of the first of the
   non-option elements that the caller should itself scan.

   Otherwise, `optind' communicates from one call to the next
   how much of ARGV has been scanned so far.  *)

(* XXX 1003.2 says this must be 1 before any call.  *)

   optind : integer = 0;

(* Set to an option character which was unrecognized.  *)
   optopt : char = '?';

type
   has_arg_type = ( no_argument, required_argument, optional_argument );

   option = record
     name    : string;
     has_arg : has_arg_type;
     flag    : ^integer;
     val     : integer;
   end;



function getopt(      argc : integer;
                  var argv : array of string;
                 optstring : string ) : integer;

function getopt_long(      argc : integer;
                       var argv : array of string;
                        options : string;
		   long_options : array of option;
                  var opt_index : integer ) : integer;

function getopt_long_only(      argc : integer;
                            var argv : array of string;
                             options : string;
                        long_options : array of option;
                       var opt_index : integer ) : integer;


(**************************************************************************)

implementation

uses SysUtils;       //changed from "dos" to SysUtils to compile under delphi
                     //by uri fridman  


const
  dummy_option : option = ( name:''; has_arg:no_argument; flag:nil; val:0 );



var
  i : integer;          (* only used in the begin-end section of this unit *)

  dummy_null   : integer = 0; //changed from const to var, by uri fridman


(* The remaining unprocessed part of the current option-element
   in which the last option character we returned was found.
   This allows us to pick up the scan where we left off.

   If this is a null string, it means resume the scan
   by advancing to the next ARGV-element.  *)

(** Was originally a pointer to the first character in the remaining
    unprocessed part of the argument (both used as a pointer and as a string).
    Now that it is used only as a string, 'remaining_arg' would have been
    a more descriptive name.  **)

var
   nextchar : string;





(* Describe how to deal with options that follow non-option ARGV-elements.

   If the caller did not specify anything,
   the default is REQUIRE_ORDER if the environment variable
   POSIXLY_CORRECT is defined, PERMUTE otherwise.

   REQUIRE_ORDER means don't recognize them as options;
   stop option processing when the first non-option is seen.
   This is what Unix does.
   This mode of operation is selected by either setting the environment
   variable POSIXLY_CORRECT, or using `+' as the first character
   of the list of option characters.

   PERMUTE is the default.  We permute the contents of ARGV as we scan,
   so that eventually all the non-options are at the end.  This allows options
   to be given in any order, even with programs that were not written to
   expect this.

   RETURN_IN_ORDER is an option available to programs that were written
   to expect options and other ARGV-elements in any order and that care about
   the ordering of the two.  We describe each non-option ARGV-element
   as if it were the argument of an option with character code 1.
   Using `-' as the first character of the list of option characters
   selects this mode of operation.

   The special argument `--' forces an end of option-scanning regardless
   of the value of `ordering'.  In the case of RETURN_IN_ORDER, only
   `--' can cause `getopt' to return EOF_getopt with `optind' != ARGC.  *)

type
  ordering_type = ( REQUIRE_ORDER, PERMUTE, RETURN_IN_ORDER );

var
  ordering : ordering_type;


(* Set to true if the environment variable POSIXLY_CORRECT exist.  *)
  posixly_correct : boolean;



(* Handle permutation of arguments.  *)

(* Describe the part of ARGV that contains non-options that have
   been skipped.  `first_nonopt' is the index in ARGV of the first of them;
   `last_nonopt' is the index after the last of them.  *)

   first_nonopt : integer;
   last_nonopt  : integer;



(* Exchange two adjacent subsequences of ARGV.
   One subsequence is elements [first_nonopt,last_nonopt)
   which contains all the non-options that have been skipped so far.
   The other is elements [last_nonopt,optind), which contains all
   the options processed since those non-options were skipped.

   `first_nonopt' and `last_nonopt' are relocated so that they describe
   the new indices of the non-options in ARGV after they are moved.  *)

procedure exchange( var argv : array of string );
var
  bottom, middle, top : integer;
  tem      : string;
  i, len   : integer;
begin
  bottom := first_nonopt;
  middle := last_nonopt;
  top    := optind;

  (* Exchange the shorter segment with the far end of the longer segment.
     That puts the shorter segment into the right place.
     It leaves the longer segment in the right place overall,
     but it consists of two parts that need to be swapped next.  *)

  while ( (top > middle) and (middle > bottom) ) do
    begin
      if ( (top - middle) > (middle - bottom) ) then
        begin
	  (* Bottom segment is the short one.  *)
	  len := middle - bottom;

	  (* Swap it with the top part of the top segment.  *)
	  for i:=0 to len-1 do
            begin
	      tem := argv[bottom + i];
	      argv[bottom + i] := argv[top - (middle - bottom) + i];
	      argv[top - (middle - bottom) + i] := tem;
            end; (* for *)
	  (* Exclude the moved bottom segment from further swapping.  *)
	  top := top - len;
        end
      else
        begin
	  (* Top segment is the short one.  *)
	  len := top - middle;

	  (* Swap it with the bottom part of the bottom segment.  *)
	  for i:=0 to len-1 do
	    begin
	      tem := argv[bottom + i];
	      argv[bottom + i] := argv[middle + i];
	      argv[middle + i] := tem;
	    end; (* for *)
	  (* Exclude the moved top segment from further swapping.  *)
	  bottom := bottom + len;
        end; (* else *)

    end; (* while *)

  (* Update records for the slots the non-options now occupy.  *)

  first_nonopt := first_nonopt + (optind - last_nonopt);
  last_nonopt  := optind;

end; (* procedure exchange *)









(* Initialize the internal data when the first call is made.  *)

function _getopt_initialize( optstring : string ) : string;
begin
  (* Start processing options with ARGV-element 1 (since ARGV-element 0
     is the program name); the sequence of previously skipped
     non-option ARGV-elements is empty.  *)

  first_nonopt := 1;
  last_nonopt  := 1;
  optind       := 1;
  nextchar     := '';

  //changed from getenv to GetEnvironmentVariablem by uri fridman
  posixly_correct := GetEnvironmentVariable('POSIXLY_CORRECT') <> '';

  (* Determine how to handle the ordering of options and nonoptions.  *)

  if (optstring[1] = '-') then //changed optstring[0] to optstring[1] by uri fridman
    begin
      ordering := RETURN_IN_ORDER;
    end
  else if (optstring[1] = '+') then //changed optstring[0] to optstring[1] by uri fridman
    begin
      ordering := REQUIRE_ORDER;
      delete(optstring, 1, 1);
    end
  else if posixly_correct then
    ordering := REQUIRE_ORDER
  else
    ordering := PERMUTE;

  _getopt_initialize := optstring;

end; (* function _getopt_initialize *)






(* Scan elements of ARGV (whose length is ARGC) for option characters
   given in OPTSTRING.

   If an element of ARGV starts with '-', and is not exactly "-" or "--",
   then it is an option element.  The characters of this element
   (aside from the initial '-') are option characters.  If `getopt'
   is called repeatedly, it returns successively each of the option characters
   from each of the option elements.

   If `getopt' finds another option character, it returns that character,
   updating `optind' and `nextchar' so that the next call to `getopt' can
   resume the scan with the following option character or ARGV-element.

   If there are no more option characters, `getopt' returns `EOF_getopt'.
   Then `optind' is the index in ARGV of the first ARGV-element
   that is not an option.  (The ARGV-elements have been permuted
   so that those that are not options now come last.)

   OPTSTRING is a string containing the legitimate option characters.
   If an option character is seen that is not listed in OPTSTRING,
   return '?' after printing an error message.  If you set `opterr' to
   false, the error message is suppressed but we still return '?'.

   If a char in OPTSTRING is followed by a colon, that means it wants an arg,
   so the following text in the same ARGV-element, or the text of the following
   ARGV-element, is returned in `optarg'.  Two colons mean an option that
   wants an optional arg; if there is text in the current ARGV-element,
   it is returned in `optarg', otherwise `optarg' is set to the empty string ''.

   If OPTSTRING starts with `-' or `+', it requests different methods of
   handling the non-option ARGV-elements.
   See the comments about RETURN_IN_ORDER and REQUIRE_ORDER, above.

   Long-named options begin with `--' instead of `-'.
   Their names may be abbreviated as long as the abbreviation is unique
   or is an exact match for some defined option.  If they have an
   argument, it follows the option name in the same ARGV-element, separated
   from the option name by a `=', or else the in next ARGV-element.
   When `getopt' finds a long-named option, it returns #0 if that option's
   `flag' field is nonzero, the value of the option's `val' field
   if the `flag' field is zero.

   LONGOPTS is a array of `option'-records terminated by an
   element containing a name which is a empty string.
                               LONGIND returns the index in LONGOPT of the long-named option found.
   It is only valid when a long-named option has been found by the most
   recent call.

   If LONG_ONLY is true, '-' as well as '--' can introduce
   long-named options.  *)



function _getopt_internal(     argc : integer;
                           var argv : array of string;
                          optstring : string;
                           longopts : array of option;
                        var longind : integer;
                          long_only : boolean ) : integer;

var
  (**    original variable/pointer 'p' not used.
         "longopts[<some index>]" used instead   **)
  indfound       : integer;
  option_index   : integer;

  equal_sign_pos : integer; (* \  substitutes the function of *)
  option_part    : string;  (* /  original variable `nameend' *)

  c              : char;
  temp_pos       : integer;

  pfound : ^option;
  exact  : boolean;
  ambig  : boolean;


begin
  indfound := 0;
  optarg := '';

  if (optind = 0) then
  begin
    optstring := _getopt_initialize (optstring);
    optind := 1;		(* Don't scan ARGV[0], the program name.  *)
  end;


  if (nextchar = '') then
  begin
      (* Advance to the next ARGV-element.  *)

    if (ordering = PERMUTE) then
    begin
      (* If we have just processed some options following some non-options,
         exchange them so that the options come first.  *)

      if ( (first_nonopt <> last_nonopt) and (last_nonopt <> optind) ) then
        exchange( argv )
      else if (last_nonopt <> optind) then
        first_nonopt := optind;

      (* Skip any additional non-options
         and extend the range of non-options previously skipped.  *)

      while ( (optind < argc) and
        ( (argv[optind][1] <> '-') or (length(argv[optind])=1) ) ) do
        inc(optind);
      last_nonopt := optind;
	  end;

      (* The special ARGV-element `--' means premature end of options.
	 Skip it like a null option,
	 then exchange with previous non-options as if it were an option,
	 then skip everything else like a non-option.  *)

    if ( (optind <> argc) and (argv[optind] = '--')) then
	  begin
      inc(optind);

      if ( (first_nonopt <> last_nonopt) and (last_nonopt <> optind) ) then
        exchange( argv )
      else if (first_nonopt = last_nonopt) then
        first_nonopt := optind;
      last_nonopt := argc;

      optind := argc;
	  end;



      (* If we have done all the ARGV-elements, stop the scan
         and back over any non-options that we skipped and permuted.  *)

    if (optind = argc) then
	  begin
      (* Set the next-arg-index to point at the non-options
         that we previously skipped, so the caller will digest them.  *)
      if (first_nonopt <> last_nonopt) then
        optind := first_nonopt;
            _getopt_internal := EOF_getopt;
            exit;
  	end;

      (* If we have come to a non-option and did not permute it,
	 either stop the scan or describe it to the caller and pass it by.  *)

    if ( (argv[optind][1] <> '-') or (length(argv[optind]) = 1) ) then
	  begin
	    if (ordering = REQUIRE_ORDER) then
      begin
        _getopt_internal := EOF_getopt;
        exit;
      end;
      inc(optind);
      optarg := argv[optind];
      _getopt_internal := 1;
      exit;
    end;


      (* We have found another option-ARGV-element.
	 Skip the initial punctuation.  *)

    nextchar := argv[optind];
    delete( nextchar, 1, 1 );

    if ( (longopts[0].name <> '') and (argv[optind][2] = '-') ) then
      delete( nextchar, 1, 1 );

  end; (* if (nextchar = '')  *)


  (* Decode the current option-ARGV-element.  *)

  (* Check whether the ARGV-element is a long option.

     If long_only and the ARGV-element has the form "-f", where f is
     a valid short option, don't consider it an abbreviated form of
     a long option that starts with f.  Otherwise there would be no
     way to give the -f short option.

     On the other hand, if there's a long option "fubar" and
     the ARGV-element is "-fu", do consider that an abbreviation of
     the long option, just like "--fu", and not "-f" with arg "u".

     This distinction seems to be the most useful approach.  *)

(**                           if ( str[2]       or xxxx )
                              if ( str[2]!='\0' or xxxx )

                              str[2]=='\0' <==> len(str) = 2
                              str[2]!='\0' <==> len(str) != 2           **)

  if ( (longopts[0].name <> '') and
       ( (argv[optind][2] = '-') or
         (long_only and ( (length(argv[optind]) <> 2) or
                          (pos(argv[optind][2], optstring) = 0)
                        )
         )
       )
     ) then
  begin       (* found a long option *)

    pfound := nil;
    exact  := false;
    ambig  := false;

    equal_sign_pos := pos( '=', nextchar );
    if (equal_sign_pos <> 0) then
      begin
        option_part := copy(nextchar,1,equal_sign_pos-1);
      end
    else
      option_part := nextchar;

    (* Test all long options for either exact match
 or abbreviated matches.  *)
    option_index := 0;
    while ((option_index <= High(longopts)) and (longopts[option_index].name <> '')) do
    begin
      if ( pos(option_part, longopts[option_index].name) = 1 ) then
      begin
        if (option_part = longopts[option_index].name) then
        begin
          (* Exact match found.  *)
          pfound := @longopts[option_index];
          indfound := option_index;
          exact := true;
          break;
        end
        else if (pfound = nil) then
        begin
          (* First nonexact match found.  *)
          pfound := @longopts[option_index];
          indfound := option_index;
        end
        else
          (* Second or later nonexact match found.  *)
          ambig := true;

      end; (* if *)

      inc(option_index);
    end; (* while *)


    if (ambig and not exact) then
    begin
      if (opterr) then
        writeln( argv[0], ': option `', argv[optind], ''' is ambiguous');
      nextchar := '';
      inc(optind);
      _getopt_internal := integer('?');
      exit;
    end;

    if (pfound <> nil) then
    begin
      option_index := indfound;
      inc(optind);

      if (equal_sign_pos <> 0) then
      begin
        if (pfound^.has_arg <> no_argument) then
          optarg := copy( nextchar, equal_sign_pos+1, length(nextchar)-(equal_sign_pos) )
        else begin
          if (opterr) then
            if (argv[optind - 1][2] = '-') then
              (* --option *)
              writeln(argv[0], ': option `--', pfound^.name,
                      ''' doesn''t allow an argument')
            else
              (* +option or -option *)
              writeln(argv[0], ': option `', argv[optind - 1][1], pfound^.name,
                     ''' doesn''t allow an argument');

          nextchar := '';
          _getopt_internal := integer('?');
          exit;
        end;
      end (* if (equal_sign_pos <> 0) *)
      else if (pfound^.has_arg = required_argument) then
      begin
        if (optind < argc) then
          begin
            optarg := argv[optind];
            inc(optind);
          end
        else begin
          if (opterr) then
            writeln( argv[0], ': option `', argv[optind - 1], ''' requires an argument');
          nextchar := '';
          if (optstring[1] = ':') then
            _getopt_internal := integer(':')
          else
            _getopt_internal := integer('?');
          exit;
        end;
      end;

      nextchar := '';
      longind := option_index;
      if (pfound^.flag <> nil) then
      begin
        pfound^.flag^ := pfound^.val;
        _getopt_internal := 0;
        exit;
      end;
      _getopt_internal := pfound^.val;
      exit;


      end; (* if (pfound <> nil) *)


        (* Can't find it as a long option.  If this is not getopt_long_only,
     or the option starts with '--' or is not a valid short
     option, then it's an error.
     Otherwise interpret it as a short option.  *)

    if ( (not long_only) or ( argv[optind][2] = '-' )
         or (pos( nextchar[1], optstring ) = 0) ) then
    begin
      if (opterr) then
        begin
          if (argv[optind][2] = '-') then
            (* --option *)
            writeln( argv[0], ': unrecognized option `--', nextchar, '''')
          else
            (* +option or -option *)
            writeln( argv[0], ': unrecognized option `', argv[optind][1], nextchar, '''');
        end;
      nextchar := '';
      inc(optind);
      _getopt_internal := integer('?');
      exit;
    end;

 end; (* if (longopts[0].name <> '') or ......... *)


(* Look at and handle the next short option-character.  *)

  c := nextchar[1];
  delete(nextchar, 1, 1);

  (* Increment `optind' when we start to process its last character.  *)
  if (nextchar = '') then
    inc(optind);

  temp_pos := pos( c, optstring );

  if ( (temp_pos = 0) or (c = ':') ) then
  begin
    if (opterr) then
    begin
      if (posixly_correct) then
        (* 1003.2 specifies the format of this message.  *)
        writeln( argv[0], ': illegal option -- ', c )
      else
        writeln( argv[0], ': invalid option -- ', c );
    end;
    optopt := c;
    _getopt_internal := integer('?');
    exit;
  end;


  if (Length(optstring) > temp_pos) and  (optstring[temp_pos+1] = ':') then
  begin
    if (length(optstring) > temp_pos + 1) and (optstring[temp_pos+2] = ':') then
    begin
      (* This is an option that accepts an argument optionally.  *)
      if (nextchar <> '') then
      begin
        optarg := nextchar;
        inc(optind);
      end
      else
        optarg := '';
      nextchar := '';
    end (* if (optstring[temp_pos+2] = ':') *)
    else begin
      (* This is an option that requires an argument.  *)

      if (nextchar <> '') then
      begin
        optarg := nextchar;
        (* If we end this ARGV-element by taking the rest as an arg,
        we must advance to the next element now.  *)
        inc(optind);
      end
      else if (optind = argc) then
      begin
        if (opterr) then
        begin
          (* 1003.2 specifies the format of this message.  *)
          writeln( argv[0], ': option requires an argument -- ', c);
        end;
        optopt := c;
        if (optstring[1] = ':') then
          c := ':'
        else
          c := '?';
      end
      else begin
          (* We already incremented `optind' once;
       increment it again when taking next ARGV-elt as argument.  *)
          optarg := argv[optind];
          inc(optind);
      end;
      nextchar := '';

    end;

  end; (* if (optstring[temp_pos+1] = ':') *)

  _getopt_internal := integer(c);

end; (* function _getopt_internal *)





function getopt(      argc : integer;
                  var argv : array of string;
                 optstring : string ) : integer;
begin

  getopt := _getopt_internal (argc, argv, optstring,
                             dummy_option,
                             dummy_null,
                             false);

end; (* function getopt *)






function getopt_long( argc : integer; var argv : array of string;
                      options : string;
		      long_options : array of option; var opt_index : integer ) : integer;
begin
  getopt_long := _getopt_internal (argc, argv, options,
                                   long_options,
                                   opt_index,
                                   false);
end; (* function getopt_long *)












function getopt_long_only( argc : integer; var argv : array of string;
                           options : string;
		           long_options : array of option;
                           var opt_index : integer ) : integer;
begin
  getopt_long_only := _getopt_internal (argc, argv, options,
                                        long_options,
                                        opt_index,
                                        true);
end; (* function getopt_long_only *)


//duanyb, 使用initialization
initialization

  argc := paramcount + 1;
  new(argvptr);
  for i:=0 to argc do
    argvptr^[i] := paramstr(i);

finalization

  dispose(argvptr);

end.
