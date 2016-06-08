program DevCan_Demo_VCL;

uses
  Vcl.Forms,
  DevCamDemo in 'DevCamDemo.pas' {fmDevCam},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmDevCam, fmDevCam);
  Application.Run;
end.
