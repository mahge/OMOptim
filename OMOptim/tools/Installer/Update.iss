; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{2C27A169-E374-4967-BBE3-B488F2F412AA}
AppName=OMOptim
AppVerName=OMOptim {code:GetAppCurrentVersion|''}
AppVersion={code:GetAppCurrentVersion|''}
AppPublisher=Hubert Thieriot (ARMINES)
CreateAppDir=no
DisableProgramGroupPage=yes
;DefaultDirName={%OPENMODELICAHOME}
VersionInfoVersion=0.9
DefaultGroupName=OMOptim
OutputBaseFilename=updateOMOptim
Compression=lzma
SolidCompression=yes
;WizardImageFile=D:\Documents\MinEIT\Developpement\OMOptim\trunk\files\Resources\icons\Synchronize\Synchronize_256x256.png
;WizardSmallImageFile=D:\Documents\MinEIT\Developpement\OMOptim\trunk\files\Resources\icons\Synchronize\Synchronize_32x32.png
ChangesAssociations=yes



[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "..\..\bin\OMOptim.exe"; DestDir: {code:GetOMDir}\bin; Flags: ignoreversion
Source: "..\..\bin\glpk_4_47.dll"; DestDir: {code:GetOMDir}\bin; Flags: ignoreversion
Source: "..\..\Core\CERES\CERESInfo.mo"; DestDir: {code:GetOMDir}; Flags: ignoreversion

;Source:  "OMOptim.ico"; DestDir: {code:GetOMDir}\bin;
Source:  "..\..\..\..\..\Documentation\OMDoc\OMOptim\OMOptimUsersGuide.pdf"; DestDir: {code:GetOMDir}\share\doc\omoptim;

Source: "..\..\build\version.txt"; DestDir: {tmp}; Flags: dontcopy

[Icons]
;Name: "{group}\OMOptim"; Filename: "{app}\OMOptim.exe" ; IconFilename: {app}\OMOptim.ico;                                        
Name: "{commondesktop}\OMOptim"; Filename: "{code:GetOMDir}\bin\OMOptim.exe"; IconFilename: {code:GetOMDir}\bin\OMOptim.exe; IconIndex: 0; Tasks: desktopicon

[Registry]
; Cr�ation de la cl� primaire
;Root: HKCU; Subkey: Software\OMOptim; Flags: uninsdeletekey
; Inscription des valeurs de cl�s secondaires
;Root: HKCU; Subkey: Software\OMOptim\Setup; ValueType: string; ValueName: "Version"; ValueData: "0.9"

; add OMOptim path in environment variables
;Root: HKCU; Subkey: Environment; ValueType: string; ValueName: "OMOptimPATH"; ValueData:  {app}

;Root: HKCR; Subkey: ".min"; ValueType: string; ValueName: ""; ValueData: "OMOptimFile"; Flags: uninsdeletevalue
;Root: HKCR; Subkey: "OMOptimFile"; ValueType: string; ValueName: ""; ValueData: "OMOptimFile"; Flags: uninsdeletekey
;Root: HKCR; Subkey: "OMOptimFile\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{code:GetOMDir}\bin\OMOptim.exe,0"
Root: HKCR; Subkey: "OMOptimFile\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{code:GetOMDir}\bin\OMOptim.exe"" ""%1"""

; etc.

[Dirs]
;Name: {app}\Modelica


[Code]

var

  LightMsgPage: TOutputMsgWizardPage;
  //KeyPage: TInputQueryWizardPage;
  OMDirPage: TInputDirWizardPage;

  OMDir2: String;

function GetAppCurrentVersion(param: String): String;
var
		Version: String;
	begin
		ExtractTemporaryFile('version.txt');
		LoadStringFromFile(ExpandConstant('{tmp}\version.txt'), Version);
		Result := Version;
	end;


  
  procedure URLLabelOnClick(Sender: TObject);
var
  ErrorCode: Integer;
begin
  ShellExec('open', 'http://www.ida.liu.se/labs/pelab/modelica/OpenModelica/releases/', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;

  procedure URLLabel2OnClick(Sender: TObject);
var
  ErrorCode: Integer;
begin
  ShellExec('open', 'http://www.microsoft.com/downloads/thankyou.aspx?familyId=9b2da534-3e03-4391-8a4d-074b9f2bc1bf&displayLang=fr', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;




  procedure InitializeWizard;
  var
    URLLabel: TNewStaticText;
    URLLabel2: TNewStaticText;

begin
  { Taken from CodeDlg.iss example script }
  { Create custom pages to show during install }

  OMDirPage := CreateInputDirPage(wpSelectDir,
    'OpenModelica Directory', '',
    'Please select OpenModelica main folder.',
    False, '');
  OMDirPage.Add('');


if RegQueryStringValue(HKCU, 'Environment',
     'OPENMODELICAHOME', OMDir2) then begin
    OMDirPage.Values[0] := OMDir2;
  end


  OMDir2 :=  OMDirPage.Values[0];

  LightMsgPage := CreateOutputMsgPage(wpWelcome,
    'Preconditions', 'This is an update only. Please be sure OpenModelica is already installed',
    'Open Modelica ');

    
    
    
     URLLabel := TNewStaticText.Create(LightMsgPage);
  URLLabel.Caption := 'Download open modelica';
  URLLabel.Cursor := crHand;
  URLLabel.OnClick := @URLLabelOnClick;
  URLLabel.Parent := LightMsgPage.Surface;
  { Alter Font *after* setting Parent so the correct defaults are inherited first }
  URLLabel.Font.Style := URLLabel.Font.Style + [fsUnderline];
  URLLabel.Font.Color := clBlue;
  URLLabel.Top := 20;


 // URLLabel2 := TNewStaticText.Create(LightMsgPage);
 // URLLabel2.Caption := 'Download VCRedist';
 // URLLabel2.Cursor := crHand;
 // URLLabel2.OnClick := @URLLabel2OnClick;
 // URLLabel2.Parent := LightMsgPage.Surface;
 // { Alter Font *after* setting Parent so the correct defaults are inherited first }
 // URLLabel2.Font.Style := URLLabel2.Font.Style + [fsUnderline];
 // URLLabel2.Font.Color := clBlue;
 // URLLabel2.Top := 75;          

end;


function GetOMDir(Param: String): String;
begin
  { Return the selected DataDir }
  //MsgBox(OMDirPage.Values[0], mbError, MB_OK);

 // OMDirPage.Values[0] := %OPENMODELICAHOME
  Result := OMDirPage.Values[0];
  end;

	

  





