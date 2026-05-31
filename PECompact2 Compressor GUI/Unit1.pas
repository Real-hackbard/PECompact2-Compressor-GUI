unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls, WinApi.ShellAPI, Vcl.Menus,
  System.IniFiles;

type
  TForm1 = class(TForm)
    Label2: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    Bevel1: TBevel;
    Image1: TImage;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    ComboBox2: TComboBox;
    CheckBox22: TCheckBox;
    ListView2: TListView;
    ImageList1: TImageList;
    ListView3: TListView;
    Label3: TLabel;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    Label1: TLabel;
    ScrollBar1: TScrollBar;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    Label4: TLabel;
    CheckBox21: TCheckBox;
    PopupMenu1: TPopupMenu;
    Information1: TMenuItem;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    ComboBox3: TComboBox;
    GroupBox3: TGroupBox;
    ComboBox4: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure Information1Click(Sender: TObject);
    procedure Label7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label7MouseLeave(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label9MouseLeave(Sender: TObject);
    procedure Label9MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
  private
    { Private declarations }
    procedure GetAvailableFiles(pComboBox: TComboBox);
  public
    { Public declarations }
    procedure WriteOptions;
    procedure ReadOptions;
  end;

var
  Form1: TForm1;
  app: String;
  TIF : TIniFile;

implementation

{$R *.dfm}

uses
  Unit2;

  { To wait until the packer has finished its work, it is best to use the
    Windows API functions `CreateProcess` and `WaitForSingleObject`. This
    causes your main program to pause until the external process has completed. }
procedure ShellExecAndWait(dateiname, Parameter: string; ShowHide: Integer);
var
  executeInfo: TShellExecuteInfo;
  dw: DWORD;
begin
  // Initialize structure
   FillChar(executeInfo, SizeOf(executeInfo), 0);
   with executeInfo do
      begin
         // Process Information
         cbSize := SizeOf(executeInfo);
         // Waiting, initializing
         fMask := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_DDEWAIT;
         // Process Safety
         Wnd := GetActiveWindow();
         // Do not inherit handles
         executeInfo.lpVerb := 'open';
         // Combine parameters and program names
         executeInfo.lpParameters := PChar(Parameter);
         lpFile := PChar(dateiname);
         // Hide Standard Console
         nShow := ShowHide;
      end;
      if ShellExecuteEx(@executeInfo) then dw := executeInfo.HProcess
         else
            begin
              // Error message if the program does not start
              ShowMessage('Error: ' + SysErrorMessage(GetLastError));
              Exit;
            end;

            // Wait until the process is finished.
      while WaitForSingleObject(executeInfo.hProcess, 50) <> WAIT_OBJECT_0 do
      Application.ProcessMessages;
      // Completing the process
      CloseHandle(dw);
end;


{ This procedure can be used to pause a program for a specific duration.
  To do so, the time must be specified in milliseconds in the lower section.
  Afterwards, the pack command must be replaced with this one. }
{
procedure ExecuteAndWait(ProgramPath, Parameters: string);
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  CmdLine: string;
begin
  // Combine parameters and program names
  CmdLine := Format('"%s" %s', [ProgramPath, Parameters]);

  // Initialize structure
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);

  // Start process
  if CreateProcess(
    nil,                               // No module name (program name is in CmdLine)
    PChar(CmdLine),                    // Command Line
    nil,                               // Process Safety
    nil,                               // Thread Safety
    False,                             // Do not inherit handles
    NORMAL_PRIORITY_CLASS,             // Priority Class
    nil,                               // Apply environment variables
    nil,                               // Use Current Directory
    StartupInfo,                       // Startup Information
    ProcessInfo                        // Process Information
  ) then
  begin
    // Wait until the process finishes (INFINITE = wait indefinitely)
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);


    // Instead of `WaitForSingleObject(ProcessInfo.hProcess, INFINITE);`, use this block:
    //repeat
    //  Application.ProcessMessages;
    // until WaitForSingleObject(ProcessInfo.hProcess, 50) <> WAIT_TIMEOUT;


    // Close handles to prevent memory leaks.
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end
  else
    RaiseLastOSError; // Error message if the program does not start
end;
}

// get main program application path
function MainDir : string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TForm1.WriteOptions;    // ################### Options Write
var
  OPT :string;
begin
   OPT := 'Options';

   if not DirectoryExists(MainDir + 'Options\')
   then ForceDirectories(MainDir + 'Options\');

   TIF := TIniFile.Create(MainDir + 'Options\Options.ini');
   with TIF do
   begin
    WriteBool(OPT,'AllowMultipleCompressions',CheckBox1.Checked);
    WriteBool(OPT,'CompressExports',CheckBox2.Checked);
    WriteBool(OPT,'CompressResources',CheckBox3.Checked);
    WriteBool(OPT,'EmulateOverlayExtraData',CheckBox4.Checked);
    WriteBool(OPT,'EnforceMemoryProtection',CheckBox5.Checked);
    WriteBool(OPT,'PerformCodeIntegrity',CheckBox6.Checked);
    WriteBool(OPT,'RestoreImportDirectoryatRuntime',CheckBox7.Checked);
    WriteBool(OPT,'SkipSharedSections',CheckBox8.Checked);
    WriteBool(OPT,'StripDebugData',CheckBox9.Checked);
    WriteBool(OPT,'StripFixUps',CheckBox10.Checked);
    WriteBool(OPT,'TrimVirtualMemory',CheckBox11.Checked);
    WriteBool(OPT,'TruncatelastSectionSize',CheckBox12.Checked);
    WriteBool(OPT,'UseWindowsDLLLoader',CheckBox13.Checked);
    WriteBool(OPT,'NoBackup',CheckBox14.Checked);
    WriteBool(OPT,'MergeSections',CheckBox15.Checked);
    WriteBool(OPT,'Quiet',CheckBox16.Checked);
    WriteBool(OPT,'CodeIntegrityCheck',CheckBox17.Checked);
    WriteBool(OPT,'Verbose',CheckBox19.Checked);
    WriteBool(OPT,'StripUnusedResources',CheckBox20.Checked);
    WriteInteger(OPT,'DecoderType',ComboBox1.ItemIndex);
    WriteInteger(OPT,'APIHookPlugin',ComboBox3.ItemIndex);
    WriteInteger(OPT,'Priorityclass',ComboBox4.ItemIndex);
    WriteInteger(OPT,'CompressLevel',ScrollBar1.Position);
    WriteBool(OPT,'ShowConsole',CheckBox21.Checked);
    WriteBool(OPT,'TestCodecbeforeCompress',CheckBox18.Checked);
    WriteInteger(OPT,'PlugInLoader',ComboBox2.ItemIndex);
    WriteBool(OPT,'SelectCodectoUse',CheckBox22.Checked);
    Free;
   end;
end;

procedure TForm1.ReadOptions;    // ################### Options Read
var
  OPT:string;
begin
  OPT := 'Options';
  if FileExists(MainDir + 'Options\Options.ini') then
  begin
    TIF:=TIniFile.Create(MainDir + 'Options\Options.ini');
    with TIF do
    begin
      CheckBox1.Checked:=ReadBool(OPT,'AllowMultipleCompressions',CheckBox1.Checked);
      CheckBox2.Checked:=ReadBool(OPT,'CompressExports',CheckBox2.Checked);
      CheckBox3.Checked:=ReadBool(OPT,'CompressResources',CheckBox3.Checked);
      CheckBox4.Checked:=ReadBool(OPT,'EmulateOverlayExtraData',CheckBox4.Checked);
      CheckBox5.Checked:=ReadBool(OPT,'EnforceMemoryProtection',CheckBox5.Checked);
      CheckBox6.Checked:=ReadBool(OPT,'PerformCodeIntegrity',CheckBox6.Checked);
      CheckBox7.Checked:=ReadBool(OPT,'RestoreImportDirectoryatRuntime',CheckBox7.Checked);
      CheckBox8.Checked:=ReadBool(OPT,'SkipSharedSections',CheckBox8.Checked);
      CheckBox9.Checked:=ReadBool(OPT,'StripDebugData',CheckBox9.Checked);
      CheckBox10.Checked:=ReadBool(OPT,'StripFixUps',CheckBox10.Checked);
      CheckBox11.Checked:=ReadBool(OPT,'TrimVirtualMemory',CheckBox11.Checked);
      CheckBox12.Checked:=ReadBool(OPT,'TruncatelastSectionSize',CheckBox12.Checked);
      CheckBox13.Checked:=ReadBool(OPT,'UseWindowsDLLLoader',CheckBox13.Checked);
      CheckBox14.Checked:=ReadBool(OPT,'NoBackup',CheckBox14.Checked);
      CheckBox15.Checked:=ReadBool(OPT,'MergeSections',CheckBox15.Checked);
      CheckBox16.Checked:=ReadBool(OPT,'Quiet',CheckBox16.Checked);
      CheckBox17.Checked:=ReadBool(OPT,'CodeIntegrityCheck',CheckBox17.Checked);
      CheckBox19.Checked:=ReadBool(OPT,'Verbose',CheckBox19.Checked);
      CheckBox20.Checked:=ReadBool(OPT,'StripUnusedResources',CheckBox20.Checked);
      ComboBox1.ItemIndex:=ReadInteger(OPT,'DecoderType',ComboBox1.ItemIndex);
      ComboBox3.ItemIndex:=ReadInteger(OPT,'APIHookPlugin',ComboBox3.ItemIndex);
      ComboBox4.ItemIndex:=ReadInteger(OPT,'Priorityclass',ComboBox4.ItemIndex);
      ScrollBar1.Position:=ReadInteger(OPT,'CompressLevel',ScrollBar1.Position);
      CheckBox21.Checked:=ReadBool(OPT,'ShowConsole',CheckBox21.Checked);
      CheckBox18.Checked:=ReadBool(OPT,'TestCodecbeforeCompress',CheckBox18.Checked);
      ComboBox2.ItemIndex:=ReadInteger(OPT,'PlugInLoader',ComboBox2.ItemIndex);
      CheckBox22.Checked:=ReadBool(OPT,'SelectCodectoUse',CheckBox22.Checked);
      Free;
    end;
  end;
end;

// Search the folder for driver files and populate a "ComboBox" with them.
procedure TForm1.GetAvailableFiles(pComboBox: TComboBox);
var
  lDir: String;                   // Starting directory for file search
  lSearchRecord: TSearchRec;      // Regarding the search itself
begin
  // If I'm already looking for the available files, then I want to...
  // No duplicate entries from previous file searches
  pCombobox.Clear;

  // I'm only searching in the same directory as my EXE file in the folder "Hooks"
  // The program is running.
  lDir := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName) +'Hooks\');

  // Does any file in the desired format exist at all?
  // (here a DLL file).
  if FindFirst(lDir + '*.dll', faAnyFile, lSearchRecord) = 0 then
  begin
    repeat
      if (lSearchRecord.Attr <> faDirectory) then
        pComboBox.Items.Add(lSearchRecord.Name);
    until FindNext(lSearchRecord) <> 0;

    // Complete search
    FindClose(lSearchRecord);
  end;
end;

// get drivers & tools filesize
function GetFileSize(FileName: string): Int64;
 var
  Handle: Integer;
  iFileSize: Int64;
 begin
  iFileSize := 0;
  Handle := FileOpen(FileName, fmOpenRead);

  if Handle <> -1 then
   try
    iFileSize := iFileSize + FileSeek(Handle, Int64(0), 2);
   finally
    FileClose(Handle);
   end;

  Result := iFileSize;
 end;

 // fill the Drivers in ListView
procedure LV_InsertFiles(strPath: string; ListView: TListView; ImageList: TImageList);
var
  i: Integer;
  Icon: TIcon;
  SearchRec: TSearchRec;
  ListItem: TListItem;
  FileInfo: SHFILEINFO;
begin
  Icon := TIcon.Create;
  ListView.Items.BeginUpdate;
  try
    // find all driver files in "Drivers" folder and fill them
    i := FindFirst(strPath + '*.dll', faAnyFile, SearchRec);
    while i = 0 do
    begin
      with ListView do
      begin
        if ((SearchRec.Attr and FaDirectory <> FaDirectory) and
          (SearchRec.Attr and FaVolumeId <> FaVolumeID)) then
        begin
          // fill listview
          ListItem := ListView.Items.Add;
          SHGetFileInfo(PChar(strPath + SearchRec.Name), 0, FileInfo,SizeOf(FileInfo), SHGFI_DISPLAYNAME);
          // type driver filename
          Listitem.Caption := FileInfo.szDisplayName;
          // type file extinsion
          ListItem.SubItems.Add(ExtractFileExt(ListItem.Caption));
          SHGetFileInfo(PChar(strPath + SearchRec.Name), 0, FileInfo, SizeOf(FileInfo), SHGFI_TYPENAME);
          // get driver file size
          ListItem.SubItems.Add(IntToStr(GetFileSize(ExtractFilePath(Application.ExeName) + 'Drivers\' +
                                Listitem.Caption) div 1000) + ' kb');
          // type name
          ListItem.SubItems.Add(FileInfo.szTypeName);
          // get windows sytsem icon handles
          SHGetFileInfo(PChar(strPath + SearchRec.Name), 0, FileInfo,SizeOf(FileInfo), SHGFI_ICON or SHGFI_SMALLICON);
          icon.Handle := FileInfo.hIcon;
          ListItem.ImageIndex := ImageList.AddIcon(Icon);
          DestroyIcon(FileInfo.hIcon);
        end;
      end;
      i := FindNext(SearchRec);
    end;
  finally
    Icon.Free;
    ListView.Items.EndUpdate;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  If OpenDialog1.Execute then
    begin
      Edit1.Text := OpenDialog1.FileName;
      Button2.Enabled := True;
      StatusBar1.Panels[1].Text := IntToStr(GetFileSize(Edit1.Text) div 1000) + ' Kb';
    end;
    StatusBar1.SetFocus;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  { Important!!!
    Do not delete the spaces within the parameter strings; otherwise,
    "PECompact2.exe" will not recognize them as such.}

  Screen.Cursor := crHourGlass;
  Label3.Caption := '';  // clear parameters

  // The loader host module provides the loader (or decompression stub)
  // to PECompcat.
  Label3.Caption := ' /LoaderHost:' + 'Drivers\' + ComboBox2.Text;

  // The loader itself is compressed and this module is the CODEC host for
  // its compression algorithm.
  if CheckBox22.Checked = true then begin
    Label3.Caption := ' /LoaderCodecHost:' + 'Drivers\' + ListView3.Selected.Caption;
  end;

  // Allow Multiple  Compressions (on single file)
  if CheckBox1.Checked = true then Label3.Caption := Label3.Caption + ' /Mc';
  if CheckBox2.Checked = true then begin
    Label3.Caption := Label3.Caption + ' /CompressExports:Yes';
  end else begin
    Label3.Caption := Label3.Caption + ' /CompressExports:No';
  end;

  // Compress Safe Resources
  if CheckBox3.Checked = true then Label3.Caption := Label3.Caption + ' /Cr:Yes';

  // Keep Overlay / Extra-data
  if CheckBox4.Checked = true then Label3.Caption := Label3.Caption + ' /Ko';

  // Prior to compression, an executable's sections are often set to restrict
  // write access to their virtual memory. Enabling this option causes
  // PECompact to restore the virtual memory access rights at runtime.
  if CheckBox5.Checked = true then Label3.Caption := Label3.Caption + ' /EnableMemoryProtection:Yes';

  // The code integrity check is a quick runtime test on reconstructed code.
  // A CRC32 codec is provided for full integrity checking and should be
  // used instead of this switch.
  if CheckBox6.Checked = true then Label3.Caption := Label3.Caption + ' /Cic:Yes';

  // If checked the original import directory is restored at runtime so that
  // applications which hook imports to extend or modify third-party applications
  // while running can find those of compressed modules.
  if CheckBox7.Checked = true then
  begin
    Label3.Caption := Label3.Caption + ' /Ri:Yes';
  end else begin
    Label3.Caption := Label3.Caption + ' /Ri:No';
  end;

  // If checked sections marked as shared between instances are not compressed.
  // If non checked these sections are unshared then compressed.
  if CheckBox8.Checked = true then
  begin
    Label3.Caption := Label3.Caption + ' /Ssh:Yes';
  end else begin
    Label3.Caption := Label3.Caption + ' /Ssh:No';
  end;

  // Debug information is included so that debuggers may identify symbols.
  if CheckBox9.Checked = true then
  begin
    Label3.Caption := Label3.Caption + ' /Sd:Yes';
  end else begin
    Label3.Caption := Label3.Caption + ' /Sd:No';
  end;

  // Fixups allow a PE module to be rebased. That is, loaded an address
  // different from that which it expected.
  if CheckBox10.Checked = true then
  begin
    Label3.Caption := Label3.Caption + ' /Sf:Yes';
  end else begin
    Label3.Caption := Label3.Caption + ' /Sf:No';
  end;

  // If "Yes" the virtual memory of compressed applications will be temporarily
  // trimmed at runtime (paged out). As the pages are referenced again Windows
  // will of course page them back in.
  if CheckBox11.Checked = true then
  begin
    Label3.Caption := Label3.Caption + ' /Tm:Yes';
  end else begin
    Label3.Caption := Label3.Caption + ' /Tm:No';
  end;

  // Truncates the last section to its unaligned raw data size. This results
  // in an executable that is, at most, 511 bytes smaller.
  if CheckBox12.Checked = true then
  begin
    Label3.Caption := Label3.Caption + ' /Tl:Yes';
  end else begin
    Label3.Caption := Label3.Caption + ' /Tl:No';
  end;

  // When this option is \"Yes\" all imported modules are added to the new
  // import table so that Windows is responsible for loading them instead of
  // the PECompact loader. When this option is \"No"\, the new import table
  // may be smaller resulting in a smaller executable.
  if CheckBox13.Checked = true then
  begin
    Label3.Caption := Label3.Caption + ' /Wl:Yes';
  end else begin
    Label3.Caption := Label3.Caption + ' /Wl:No';
  end;

  // If this switch is present, the file PECompact 2 processes will not be
  // backed up. The default is to backup any file processed by PECompact 2.
  if CheckBox14.Checked = true then
  begin
    Label3.Caption := Label3.Caption + ' /Nb:Yes';
  end else begin
    Label3.Caption := Label3.Caption + ' /Nb:No';
  end;

  // This option indicates whether or not to merge congruent, wholly
  // compressible sections together.
  if CheckBox15.Checked = true then
  begin
    Label3.Caption := Label3.Caption + ' /Ms:Yes';
  end else begin
    Label3.Caption := Label3.Caption + ' /Ms:No';
  end;

  // The code integrity check is a quick runtime test on reconstructed code.
  // A CRC32 codec is provided for full integrity checking and should be
  // used instead of this switch. The default value is "Yes". Turning this
  // option on will expand the loader by a few bytes.
  if CheckBox17.Checked = true then
  begin
    Label3.Caption := Label3.Caption + ' /Cic:Yes';
  end else begin
    Label3.Caption := Label3.Caption + ' /Cic:No';
  end;

  // Test Codec before Compress
  if CheckBox18.Checked = true then Label3.Caption := Label3.Caption + ' /Tc';

  // If this switch is present, verbose messages will be emitted to the
  // standard output device.
  if CheckBox19.Checked = true then Label3.Caption := Label3.Caption + ' /V';

  // If this switch is present, PECompact 2 reduces the amount of writing
  // to the console.
  if CheckBox16.Checked = true then Label3.Caption := Label3.Caption + ' /Q';

  //  Strip Unused Resources
  if CheckBox20.Checked = true then
  begin
    Label3.Caption := Label3.Caption + ' /Sur:Yes';
  end else begin
    Label3.Caption := Label3.Caption + ' /Sur:No';
  end;

  // Compression Level (Global Decoder Options)
  Label3.Caption := Label3.Caption + ' /Cl:' + IntToStr(ScrollBar1.Position);


  // The fast decoder performs better than the 'small' decoder, but occupies
  // more physical space. The default is "Auto", by which the small decoders
  // are used for files less than 48kB in size and fast decoders used for
  // all other files.
  case ComboBox1.ItemIndex of
    0 : Label3.Caption := Label3.Caption + ' /Dt:Small';
    1 : Label3.Caption := Label3.Caption + ' /Dt:Fast';
    2 : Label3.Caption := Label3.Caption + ' /Dt:Auto';
  end;

  // An API Hook plugin may facilitate any number of different features.
  // This switch indicates which API Hook plugins to utilize. There is no
  // default value (no API hooks used).
  if ComboBox3.Text <> 'None' then
  begin
    Label3.Caption := Label3.Caption + ' /Hh:' + 'Hooks\' + ComboBox3.Text;
  end;

  // This switch specifies the priority class in which to perform the compression.
  case ComboBox4.ItemIndex of
    0 : Label3.Caption := Label3.Caption + ' /Priority:idle';
    1 : Label3.Caption := Label3.Caption + ' /Priority:low';
    2 : Label3.Caption := Label3.Caption + ' /Priority:high';
    3 : Label3.Caption := Label3.Caption + ' /Priority:realtime';
  end;

  Application.ProcessMessages;
  // The path to PECompact2.exe
  app := ExtractFilePath(Application.ExeName)+'Drivers\PECompact2.exe';

  // Execute and wait until the Packer process has finished.
  if CheckBox21.Checked = true then
  begin
    // Visible execution
    StatusBar1.Panels[3].Text := 'Packing process startet, please wait..';
    ShellExecAndWait(PChar(app), PChar(' ' + Edit1.Text + Label3.Caption), 1);
  end else begin
    // hide execution
    ShellExecAndWait(PChar(app), PChar(' ' + Edit1.Text + Label3.Caption), 0);
  end;

  { This is the standard console execute "ShellExecute"
  try
    if CheckBox21.Checked = true then
    begin
    ShellExecute(Handle, 'open', PChar(app),
               PChar(' ' + Edit1.Text + Label3.Caption), nil, SW_SHOWNORMAL);
  end else begin
    ShellExecute(Handle, 'open', PChar(app),
               PChar(' ' + Edit1.Text + Label3.Caption), nil, SW_HIDE);
    end;
  finally
  end; }

  { This can be used as a unit of time when a specific duration needs to
    be waited out.
    The time is specified in the function. }
  // ExecuteAndWait(PChar(app), PChar(' ' + Edit1.Text + Label3.Caption));

  // get the new file size after pack process
  StatusBar1.Panels[3].Text := IntToStr(GetFileSize(Edit1.Text) div 1000) + ' Kb';
  Screen.Cursor := crDefault;
  StatusBar1.SetFocus;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  // save all options
  WriteOptions;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
var
  item : TListItem;
begin
  ListView2.Clear;
  item := ListView2.Items.Add;
  item.Caption := ComboBox2.Text;
  item.SubItems.Add('1');
  StatusBar1.SetFocus;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Prevent flickering in the components.
  DoubleBuffered := true;

  // Pause tooltips for 50 seconds.
  Application.HintPause := 0;
  Application.HintHidePause := 50000;

  // Define the size of the ListView icons
  ListView3.SmallImages := ImageList1;

  // Fill the ListView with the drivers.
  LV_InsertFiles(ExtractFilePath(Application.ExeName) +
                 'Drivers\', ListView3, ImageList1);

  // Hints for then CheckBox Components
  CheckBox1.Hint := 'Multiple compressions refer to two distinct features:' + #13#10 +
                    'using the /MultiCompress command-line switch to force-pack ' + #13#10 +
                    'an already compressed executable, or chaining multiple CODEC' + #13#10 +
                    'plug-ins together during a single packing session.';
  CheckBox2.Hint := 'Determines whether the Export Table of a Portable Executable' + #13#10 +
                    '(PE) is compressed. By default, the packer relocates the' + #13#10 +
                    'Export Table so that symbols remain visible to other modules' + #13#10 +
                    'without the entire file needing to be decompressed in advance.';
  CheckBox3.Hint := 'This option allows for specification of resources that should be ' + #13#10 +
                    'compressed. By default, all are compressed except the first group' + #13#10 +
                    'icon and icons it references, version, and manifest resources.';
  CheckBox4.Hint := 'To successfully unpack or reverse-engineer an executable packed' + #13#10 +
                    'with PECompact2, you often need to emulate overlay extra data. This' + #13#10 +
                    'overlay (data appended to the end of the PE file) frequently contains' + #13#10 +
                    'critical resources, such as configuration scripts, icon packages,' + #13#10 +
                    'or installer archives.';
  CheckBox5.Hint := 'The "Enforce Memory Protection" feature in PECompact (and similar' + #13#10 +
                    'packers like RLPack) locks memory pages to prevent dumping,' + #13#10 +
                    'modifying, or executing code outside of designated boundaries.';
  CheckBox6.Hint := 'PECompact2 includes built-in options to "Perform Code Integrity"' + #13#10 +
                    'checks, which act as a security measure to ensure the executable' + #13#10 +
                    'hasn`t been modified or corrupted after being compressed.';
  CheckBox7.Hint := 'The "Restore Import Directory at Runtime" setting in PECompact2' + #13#10 +
                    'controls whether the original Import Table (Import Directory) of a' + #13#10 +
                    'packed executable file (PE) is reconstructed in memory after the' + #13#10 +
                    'unpacking process is complete.';
  CheckBox8.Hint := 'PECompact2 includes an option to preserve shared sections, which' + #13#10 +
                    'are typically found in DLLs. By default, the compressor skips' + #13#10 +
                    'compressing these sections to allow multiple instances of a module' + #13#10 +
                    'or DLL to share memory and save system resources.';
  CheckBox9.Hint := 'Strip Debug Data (often toggled via the command-line' + #13#10 +
                    'argument /StripDebug or /SD) is a configuration setting that' + #13#10 +
                    'controls whether debugging symbols and directories are permanently' + #13#10 +
                    'removed from the executable during the compression process.';
  CheckBox10.Hint :='The Strip FixUps option (also known as Relocations or /StripFixups)' + #13#10 +
                    'controls whether base relocation information (fixups) is removed from' + #13#10 +
                    'the executable file to save additional file size.';
  CheckBox11.Hint :='The specific feature you are referring to is a runtime option that' + #13#10 +
                    'commands a compressed application to temporarily page out (trim) its' + #13#10 +
                    'working memory when executing.';
  CheckBox12.Hint :='To truncate the last section size in a PECompact2 packed executable,' + #13#10 +
                    'you need to adjust two fields in the Portable Executable (PE) headers' + #13#10 +
                    'using a hex editor or a PE manipulation tool like CFF Explorer or LordPE.';
  CheckBox13.Hint :='The "Use Windows DLL Loader" option (often controlled via the Import' + #13#10 +
                    'Table Mode) determines whether the Windows operating system or' + #13#10 +
                    'PECompact`s own unpacking code is responsible for loading imported' + #13#10 +
                    'DLLs at program startup.';
  CheckBox14.Hint :='Do not create a backup copy.';
  CheckBox15.Hint :='In PECompact2, the "Merge Sections" option instructs the packer to' + #13#10 +
                    'combine congruent, wholly compressible sections into a single section' + #13#10 +
                    'during the compression process to achieve a smaller file size and' + #13#10 +
                    'a reduced memory footprint.';
  CheckBox16.Hint :='If you append this parameter to the console application, the tool' + #13#10 +
                    'reduces the text output in the console window to a minimum.';
  CheckBox17.Hint :='Code Integrity Check is a runtime security feature that verifies the' + #13#10 +
                    'executable`s reconstructed code in memory to prevent tampering or' + #13#10 +
                    'memory corruption.';
  CheckBox19.Hint :='PECompact2 command-line utility includes a verbose flag (or switch)' + #13#10 +
                    'that forces the program to emit detailed, step-by-step processing' + #13#10 +
                    'and compression messages to your standard output device (console).';
  CheckBox20.Hint :='"Strip Unused Resources" (or similar "Remove Unused Resources")' + #13#10 +
                    'setting before executing the compression to permanently discard' + #13#10 +
                    'obsolete icons, version info, and localized strings from the binary.';
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  // read the "Options.ini" file
  ReadOptions;
  // Fill driver files in "ComboBox"
  GetAvailableFiles(ComboBox3);
  // This is necessary to ensure that a malicious API hook plugin cannot be utilized.
  ComboBox3.Items.Add('None');
  // jump to the last item
  ComboBox3.ItemIndex := ComboBox3.Items.Count - 1;
  // update PlugIn Loader ComboBox
  ComboBox2.OnChange(sender);
end;

procedure TForm1.Information1Click(Sender: TObject);
begin
  // Information for Codecs
  Form2.ShowModal;
end;

procedure TForm1.Label7Click(Sender: TObject);
begin
  if shellexecute(handle,'open','http://www.7-zip.org',nil,nil,sw_show)<=32
   then showmessage('Website could not be opened.!');
end;

procedure TForm1.Label7MouseLeave(Sender: TObject);
begin
  Label7.Font.Color := clBlack;
  Label7.Font.Style := [];
end;

procedure TForm1.Label7MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label7.Font.Color := clBlue;
  Label7.Font.Style := [fsUnderline];
end;

procedure TForm1.Label9Click(Sender: TObject);
begin
  if shellexecute(handle,'open','http://www.ibsensoftware.com',nil,nil,sw_show)<=32
   then showmessage('Website could not be opened.!');
end;

procedure TForm1.Label9MouseLeave(Sender: TObject);
begin
  Label9.Font.Color := clBlack;
  Label9.Font.Style := [];
end;

procedure TForm1.Label9MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label9.Font.Color := clBlue;
  Label9.Font.Style := [fsUnderline];
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  Label1.Caption := 'Compress Level : ' + IntToStr(ScrollBar1.Position);
end;

end.
