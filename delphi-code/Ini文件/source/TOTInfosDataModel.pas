unit TOTInfosDataModel;

interface

uses
  SysUtils;

type
  TTOTInfos = class(TObject)
    private
      FName: string;
      FGender: Integer;
      FAge: Integer;
      FBirthday: TDateTime;
      FHobby: string;
      FIntroduce: string;
      procedure SetName(AName: string);
      procedure SetGender(AGender: Integer);
      procedure SetAge(AAge: Integer);
      procedure SetBirthday(ABirthday: TDateTime);
      procedure SetHobby(AHobby: string);
      procedure SetIntroduce(AIntroduce: string);
    published
      property Name: string read FName write SetName;
      property Gender: Integer read FGender write SetGender;
      property Age: Integer read FAge write SetAge;
      property Birthday: TDateTime read FBirthday write SetBirthday;
      property Hobby: string read FHobby write SetHobby;
      property Introduce: string read FIntroduce write SetIntroduce;
  end;

implementation

{ TTOTInfos }

procedure TTOTInfos.SetAge(AAge: Integer);
begin
  FAge := AAge;
end;

procedure TTOTInfos.SetBirthday(ABirthday: TDateTime);
begin
  FBirthday := ABirthday;
end;

procedure TTOTInfos.SetGender(AGender: Integer);
begin
  FGender := AGender;
end;

procedure TTOTInfos.SetHobby(AHobby: string);
begin
  FHobby := AHobby;
end;

procedure TTOTInfos.SetIntroduce(AIntroduce: string);
begin
  FIntroduce := AIntroduce;
end;

procedure TTOTInfos.SetName(AName: string);
begin
  FName := AName;
end;

end.

