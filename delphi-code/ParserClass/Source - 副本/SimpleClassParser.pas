unit SimpleClassParser;

interface

uses
  ClassParser, Classes;

type
  TSimpleClassParser = class(TClassParser)
  private
    FLines: TStringList;
  protected
    procedure DoParse; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TSimpleClassParser }

constructor TSimpleClassParser.Create;
begin
  FLines := TStringList.Create;
end;

destructor TSimpleClassParser.Destroy;
begin
  FLines.Free;
  inherited;
end;

procedure TSimpleClassParser.DoParse;
var
  s: string;
begin
  inherited;
  while not Eof(FTextFile) do
  begin
    Readln(FTextFile, s);
    FLines.Add(s);
  end;



end;

end.
