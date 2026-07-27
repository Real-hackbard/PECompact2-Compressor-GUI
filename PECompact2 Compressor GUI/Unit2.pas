unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    StatusBar1: TStatusBar;
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses
  Unit1;

procedure TForm2.FormShow(Sender: TObject);
var
  i: integer;
begin
  Memo1.Clear;
  with Form1.Listview3 do
    for i := 0 to Items.Count - 1 do
    begin
      if Items[i].Selected then
         StatusBar1.Panels[1].Text := Items[i].Caption;
    end;

  if StatusBar1.Panels[1].Text = 'pec2codec_aplib.dll' then
      begin
        Memo1.Lines.Add('aPLib is a high performance compression algorithm with less decompression overhead than FFCE, but slower and does not compress larger files as well as FFCE. Its decompression code is slightly larger than FFCE`s.');
      end;

  if StatusBar1.Panels[1].Text = 'pec2codec_brieflz.dll' then
      begin
        Memo1.Lines.Add('BriefLZ is a compression algorithm optimized for fast compression and reasonable ratios.');
      end;

  if StatusBar1.Panels[1].Text = 'pec2codec_copy.dll' then
      begin
        Memo1.Lines.Add('Retrieves the address of an exported function (also known as a procedure) or variable.');
      end;

  if StatusBar1.Panels[1].Text = 'pec2codec_crc32.dll' then
      begin
        Memo1.Lines.Add('A simple CRC32 checksum routine. If the data is found to be corrupt at runtime, you will see a message box stating such and the module will exit.');
      end;

  if StatusBar1.Panels[1].Text = 'pec2codec_elfhash.dll' then
      begin
        Memo1.Lines.Add('ElfHash is a high-speed checksum algorithm. It is a good replacement for CRC32.');
      end;

  if StatusBar1.Panels[1].Text = 'pec2codec_ffce.dll' then
      begin
        Memo1.Lines.Add('FFCE is the default CODEC for small files. It is a high-performance general purpose compression algorithm. It performs best on larger files and has a decompressor that is slightly smaller than aPLib`s');
      end;

  if StatusBar1.Panels[1].Text = 'pec2codec_inv.dll' then
      begin
        Memo1.Lines.Add('The acronym stands for PECompact 2 Codec (Inverse / Decompressor). This DLL contains the algorithm responsible for unpacking and decompressing data in memory whenever a program compressed with PECompact is launched.');
      end;

  if StatusBar1.Panels[1].Text = 'pec2codec_jcalg1.dll' then
      begin
        Memo1.Lines.Add('JCALG1 is a high-performance general purpose compression algorithm. Compression is much slower, but (especially) at higher compression levels JCALG1 may perform better than other CODECs on some files.');
        Memo1.Lines.Add(#13#10 +'Decompression speed is very fast, comparable with aPLib and NRV2E.');
      end;

  if (StatusBar1.Panels[1].Text = 'pec2codec_lzma.dll') or
     (StatusBar1.Panels[1].Text = 'pec2codec_lzma2.dll') then
      begin
        Memo1.Lines.Add('LZMA2 is the default CODEC for mid-size and large-size modules. It is a high performance compression algorithm that generally compresses substantially tighter than any other of the algorithms listed here.');
      end;

  if StatusBar1.Panels[1].Text = 'pec2codec_messagebox.dll' then
      begin
        Memo1.Lines.Add('At runtime displays a message box entirely configured by the user (at time of encode) and takes action appropriate to the user`s response at runtime. For example, one could install a ');
        Memo1.Lines.Add('Are you sure you want to allow this to run? Yes/No message box on a script interpetor.');
      end;

  if StatusBar1.Panels[1].Text = 'pec2codec_password.dll' then
      begin
        Memo1.Lines.Add('Encrypts a file using password entered by user as key. At runtime, the user is prompted for a password. If correct, the module is decompressed and run. If incorrect, the module exits.');
      end;

  if StatusBar1.Panels[1].Text = 'pec2ldr_antidebug.dll' then
      begin
        Memo1.Lines.Add('These terms refer to anti-reverse engineering techniques associated with the PECompact executable compressor. They are designed to detect if a program is running under an active debugger and halt execution to protect the binary.');
      end;

  if StatusBar1.Panels[1].Text = 'pec2ldr_debug.dll' then
      begin
        Memo1.Lines.Add('Alternate loader used for easier debugging (no SEH traps).');
      end;

  if StatusBar1.Panels[1].Text = 'pec2ldr_default.dll' then
      begin
        Memo1.Lines.Add('Establishes a standard compression method.');
      end;

  if StatusBar1.Panels[1].Text = 'pec2ldr_no_rwx_mem.dll' then
      begin
        Memo1.Lines.Add('In PECompact 2, Use Feature Flags allows you to toggle specific runtime protection and compression behaviors for your executable. To set these feature flags, use the PECompact Graphical Interface (GUI) or the Command-Line Interface (CLI).');
      end;

  if StatusBar1.Panels[1].Text = 'pec2ldr_reduced.dll' then
      begin
        Memo1.Lines.Add('Reduced size loader, for the truly size obsessed.');
      end;

  if StatusBar1.Panels[1].Text = 'pec2rsrc.dll' then
      begin
        Memo1.Lines.Add('pec2rsrc is a command-line tool specifically designed to extract resources (such as icons or bitmaps) from executable files and DLLs that have been packed with PECompact2.');
      end;


end;

end.
