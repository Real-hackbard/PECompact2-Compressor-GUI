unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellAPI, ComCtrls, Vcl.Imaging.jpeg,
  Utils, System.ImageList, Vcl.ImgList, Vcl.XPMan;

type
  TForm1 = class(TForm)
    Label2: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    StyleXP: TXPManifest;
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
    CheckBox72: TCheckBox;
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
    ScrollBar2: TScrollBar;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    Label4: TLabel;
    CheckBox21: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  app: String;

implementation

{$R *.dfm}
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
    i := FindFirst(strPath + '*.dll', faAnyFile, SearchRec);
    while i = 0 do
    begin
      with ListView do
      begin
        if ((SearchRec.Attr and FaDirectory <> FaDirectory) and
          (SearchRec.Attr and FaVolumeId <> FaVolumeID)) then
        begin
          ListItem := ListView.Items.Add;
          SHGetFileInfo(PChar(strPath + SearchRec.Name), 0, FileInfo,SizeOf(FileInfo), SHGFI_DISPLAYNAME);
          Listitem.Caption := FileInfo.szDisplayName;

          ListItem.SubItems.Add(ExtractFileExt(ListItem.Caption));

          //ListItem.SubItems.Add(IntToStr(MyGetFileSize(strPath + '\' + FileInfo.szDisplayName).QuadPart));

          SHGetFileInfo(PChar(strPath + SearchRec.Name), 0, FileInfo, SizeOf(FileInfo), SHGFI_TYPENAME);
          ListItem.SubItems.Add(FileInfo.szTypeName);
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

function Get_File_Size4(const S: string): Int64;
var
  FD: TWin32FindData;
  FH: THandle;
begin
  FH := FindFirstFile(PChar(S), FD);
  if FH = INVALID_HANDLE_VALUE then Result := 0
  else
    try
      Result := FD.nFileSizeHigh;
      Result := Result shl 32;
      Result := Result + FD.nFileSizeLow;
    finally
      //CloseHandle(FH);
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  If OpenDialog1.Execute then
    begin
      Edit1.Text := OpenDialog1.FileName;
      Button2.Enabled := True;
    end;
    StatusBar1.Panels[1].Text := IntToStr( Get_File_Size4(Edit1.Text)) + ' Kb';
    StatusBar1.SetFocus;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Label3.Caption := '';
  Label3.Caption := ' /LoaderHost:"' + ComboBox2.Text + '"';

  if CheckBox72.Checked = true then begin
  Label3.Caption := ' /LoaderCodecHost:"' + ListView3.Selected.Caption + '"';
  end;

  if CheckBox1.Checked = true then Label3.Caption := Label3.Caption + ' /MC';
  if CheckBox2.Checked = true then begin
  Label3.Caption := Label3.Caption + ' /CompressExports:Yes';
  end else begin
  Label3.Caption := Label3.Caption + ' /CompressExports:No';
  end;
  if CheckBox3.Checked = true then Label3.Caption := Label3.Caption + ' /Cr:Yes';
  if CheckBox4.Checked = true then Label3.Caption := Label3.Caption + ' /Ko';
  if CheckBox5.Checked = true then Label3.Caption := Label3.Caption + ' /EnableMemoryProtection:Yes';
  if CheckBox6.Checked = true then Label3.Caption := Label3.Caption + ' /Cic:Yes';

  if CheckBox7.Checked = true then begin
  Label3.Caption := Label3.Caption + ' /Ri:Yes';
  end else begin
  Label3.Caption := Label3.Caption + ' /Ri:No';
  end;
  if CheckBox8.Checked = true then begin
  Label3.Caption := Label3.Caption + ' /Ssh:Yes';
  end else begin
  Label3.Caption := Label3.Caption + ' /Ssh:No';
  end;

  if CheckBox9.Checked = true then begin
  Label3.Caption := Label3.Caption + ' /Sd:Yes';
  end else begin
  Label3.Caption := Label3.Caption + ' /Sd:No';
  end;

  if CheckBox10.Checked = true then begin
  Label3.Caption := Label3.Caption + ' /Sf:Yes';
  end else begin
  Label3.Caption := Label3.Caption + ' /Sf:No';
  end;

  if CheckBox11.Checked = true then begin
  Label3.Caption := Label3.Caption + ' /Tm:Yes';
  end else begin
  Label3.Caption := Label3.Caption + ' /Tm:No';
  end;

  if CheckBox12.Checked = true then begin
  Label3.Caption := Label3.Caption + ' /Tl:Yes';
  end else begin
  Label3.Caption := Label3.Caption + ' /Tl:No';
  end;

  if CheckBox13.Checked = true then begin
  Label3.Caption := Label3.Caption + ' /Wl:Yes';
  end else begin
  Label3.Caption := Label3.Caption + ' /Wl:No';
  end;

  if CheckBox14.Checked = true then begin
  Label3.Caption := Label3.Caption + ' /Nb:Yes';
  end else begin
  Label3.Caption := Label3.Caption + ' /Nb:No';
  end;

  if CheckBox15.Checked = true then begin
  Label3.Caption := Label3.Caption + ' /Ms:Yes';
  end else begin
  Label3.Caption := Label3.Caption + ' /Ms:No';
  end;


  if CheckBox17.Checked = true then begin
  Label3.Caption := Label3.Caption + ' /Cic:Yes';
  end else begin
  Label3.Caption := Label3.Caption + ' /Cic:No';
  end;

  if CheckBox18.Checked = true then Label3.Caption := Label3.Caption + ' /Tc';
  if CheckBox19.Checked = true then Label3.Caption := Label3.Caption + ' /V';
  if CheckBox16.Checked = true then Label3.Caption := Label3.Caption + ' /Q';

  if CheckBox20.Checked = true then begin
  Label3.Caption := Label3.Caption + ' /Sur:Yes';
  end else begin
  Label3.Caption := Label3.Caption + ' /Sur:No';
  end;

  Label3.Caption := Label3.Caption + ' /Cl:' + IntToStr(ScrollBar2.Position);
  Application.ProcessMessages;

  app := ExtractFilePath(Application.ExeName)+'Drivers\PECompact2.exe';
  {
  try
  ShellExecute(Handle, 'open', PChar(app), PChar(Edit1.Text + Label3.Caption),
              nil, SW_SHOWNORMAL);
  finally
  end;

   }


   try
    if CheckBox21.Checked = true then begin
    ShellExecute(Handle, 'open', PChar(app),
               PChar(' ' + Edit1.Text + Label3.Caption), nil, SW_SHOWNORMAL);
    end else begin
    ShellExecute(Handle, 'open', PChar(app),
               PChar(' ' + Edit1.Text + Label3.Caption), nil, SW_HIDE);
    end;
  finally
  end;



  //StatusBar1.Panels[3].Text := IntToStr( Get_File_Size4(Edit1.Text)) + ' Kb';
  StatusBar1.SetFocus;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
var item : TListItem;
begin
  ListView2.Clear;
  item := ListView2.Items.Add;
  item.Caption := ComboBox2.Text;
  item.SubItems.Add('1');
  StatusBar1.SetFocus;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ListView3.SmallImages := ImageList1;
  LV_InsertFiles(ExtractFilePath(Application.ExeName) + 'Drivers\', ListView3, ImageList1);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ComboBox2.OnChange(sender);
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
  Label1.Caption := 'Compress Level : ' + IntToStr(ScrollBar2.Position);
end;

end.
