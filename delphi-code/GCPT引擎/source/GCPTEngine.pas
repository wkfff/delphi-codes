unit GCPTEngine;

interface

const
  CKCopy = '复制';
  CKTable = '表';
  CKTo = '到';
  CKComma = '，';
  CKWhere = '其中';
  CKLQuote = '“';
  CKRQuote = '”';
  CKLSquareBracket = '[';
  CKRSquareBracket = ']';
  CKSemicolon = '；';
  CKDelete = '删除';


//function read(ATXTFileName: string): string;
procedure CopyTablesXXJ2MDB(const AXXJFileName, AMDBFileName: string;
  );

implementation

end.
