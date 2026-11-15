; Instalador do Flameshot ja configurado
; Compilar: ISCC.exe flameshot-setup.iss  (gera Output\Flameshot-Config-Setup.exe)

#define AppName "Flameshot"
#define AppVersion "14.0.0-config1"

[Setup]
AppId={{6B1E8F0C-5A1F-4C1B-9E55-FC0F1A7E2D11}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher=Flameshot (config personalizada)
AppPublisherURL=https://flameshot.org
DefaultDirName={autopf}\Flameshot
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
LicenseFile=LICENSE
OutputDir=Output
OutputBaseFilename=Flameshot-Config-Setup
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin
UsedUserAreasWarning=no
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
UninstallDisplayIcon={app}\bin\flameshot.exe
CloseApplications=yes

[Languages]
Name: "ptbr"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Files]
Source: "app\*"; DestDir: "{app}\bin"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "LICENSE"; DestDir: "{app}"; Flags: ignoreversion
Source: "flameshot.ini"; Flags: dontcopy

[Icons]
Name: "{autoprograms}\{#AppName}"; Filename: "{app}\bin\flameshot.exe"
Name: "{autoprograms}\Pasta de prints"; Filename: "{code:PastaPrints}"

[Run]
Filename: "{app}\bin\flameshot.exe"; Description: "Abrir o Flameshot agora"; Flags: postinstall nowait skipifsilent runasoriginaluser

[UninstallRun]
Filename: "{sys}\taskkill.exe"; Parameters: "/F /IM flameshot.exe"; Flags: runhidden; RunOnceId: "FecharFlameshot"

[Code]
{ Caminho de Imagens\prints do usuario (pasta Imagens pode estar em outro lugar, ex. OneDrive) }
function PastaPrints(Param: String): String;
var
  Pics: String;
begin
  if not RegQueryStringValue(HKCU, 'Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', 'My Pictures', Pics) or (Pics = '') then
    Pics := ExpandConstant('{%USERPROFILE}\Pictures');
  Result := Pics + '\prints';
end;

function PrepareToInstall(var NeedsRestart: Boolean): String;
var
  Code: Integer;
begin
  { Fecha o Flameshot se estiver aberto, para poder trocar os arquivos e a config }
  Exec(ExpandConstant('{sys}\taskkill.exe'), '/F /IM flameshot.exe', '', SW_HIDE, ewWaitUntilTerminated, Code);
  Result := '';
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  Modelo: AnsiString;
  Texto, Prints, CfgDir, Cfg: String;
  Linhas: TArrayOfString;
begin
  if CurStep <> ssPostInstall then
    Exit;

  { Pasta das prints: Imagens\prints }
  Prints := PastaPrints('');
  ForceDirectories(Prints);

  { Config do Flameshot em %APPDATA%\flameshot\flameshot.ini }
  CfgDir := ExpandConstant('{userappdata}\flameshot');
  ForceDirectories(CfgDir);
  Cfg := CfgDir + '\flameshot.ini';
  if FileExists(Cfg) then
    CopyFile(Cfg, Cfg + '.bak', False);

  ExtractTemporaryFile('flameshot.ini');
  if LoadStringFromFile(ExpandConstant('{tmp}\flameshot.ini'), Modelo) then
  begin
    Texto := String(Modelo);
    StringChangeEx(Prints, '\', '/', True);
    StringChangeEx(Texto, '__SAVEPATH__', Prints, True);
    { UTF-8 sem BOM, para funcionar com nome de usuario com acento }
    Linhas := [Texto];
    SaveStringsToUTF8FileWithoutBOM(Cfg, Linhas, False);
  end;
end;
