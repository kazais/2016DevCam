unit DevCamDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.WinXCtrls, Vcl.Themes, Vcl.Styles, System.ImageList, Vcl.ImgList,
  Vcl.CategoryButtons, System.Actions, Vcl.ActnList, Vcl.ComCtrls,
  System.Notification, System.Win.TaskbarCore, Vcl.Taskbar, Unit2,
  Vcl.Samples.Spin;

type
  TfmDevCam = class(TForm)
    svDev: TSplitView;
    pnTop: TPanel;
    imMenu: TImage;
    lbStyle: TLabel;
    cbStyle: TComboBox;
    ilIcons: TImageList;
    CategoryButtons1: TCategoryButtons;
    AlMenu: TActionList;
    acHome: TAction;
    acLayout: TAction;
    acPower: TAction;
    pnMenu: TPanel;
    swDockStyle: TToggleSwitch;
    swPlacement: TToggleSwitch;
    swShowstyle: TToggleSwitch;
    swClickStyle: TToggleSwitch;
    pnBody: TPanel;
    rpanelAnimation: TRelativePanel;
    swAnimation: TToggleSwitch;
    lblAnimationDelay: TLabel;
    lblAnimationStep: TLabel;
    trkAnimationDelay: TTrackBar;
    trkAnimationStep: TTrackBar;
    SearchBox1: TSearchBox;
    rpanelTaskbarState: TRelativePanel;
    lbTaskbarstate: TLabel;
    swTaskbarState: TToggleSwitch;
    trkTaskbarstate: TTrackBar;
    ActivityIndicator1: TActivityIndicator;
    lbTitle: TLabel;
    Timer1: TTimer;
    NotificationCenter1: TNotificationCenter;
    Taskbar1: TTaskbar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ScrollBar1: TScrollBar;
    procedure FormCreate(Sender: TObject);
    procedure cbStyleChange(Sender: TObject);
    procedure imMenuClick(Sender: TObject);
    procedure acHomeExecute(Sender: TObject);
    procedure acLayoutExecute(Sender: TObject);
    procedure swDockStyleClick(Sender: TObject);
    procedure swPlacementClick(Sender: TObject);
    procedure swShowstyleClick(Sender: TObject);
    procedure imMenuclose(sv: TSplitView);
    procedure acPowerExecute(Sender: TObject);
    procedure swAnimationClick(Sender: TObject);
    procedure trkAnimationDelayChange(Sender: TObject);
    procedure trkAnimationStepChange(Sender: TObject);
    procedure swTaskbarStateClick(Sender: TObject);
    procedure setwaitingcur(ai: TActivityIndicator);
    procedure Timer1Timer(Sender: TObject);
    procedure trkTaskbarstateChange(Sender: TObject);
    procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject;
      ANotification: TNotification);
    procedure ScrollBar1Change(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  fmDevCam: TfmDevCam;

implementation

{$R *.dfm}

procedure TfmDevCam.acHomeExecute(Sender: TObject);

var
  MyNotification: TNotification;
begin
  // Log(actHome.Caption + ' Clicked');
  MyNotification := NotificationCenter1.CreateNotification;
  try
    MyNotification.Name := 'Windows10Notification Home';
    MyNotification.Title := 'Windows 10 Notification ';
    MyNotification.AlertBody := 'RAD Studio 10.1 Berlin';

    NotificationCenter1.PresentNotification(MyNotification);
  finally
    MyNotification.Free;
  end;
  if swClickStyle.State = tssOff then
    imMenuclose(svDev);
end;

procedure TfmDevCam.acLayoutExecute(Sender: TObject);
begin
  pnMenu.Visible := not(pnMenu.Visible);
  if swClickStyle.State = tssOff then
    imMenuclose(svDev);

end;

procedure TfmDevCam.acPowerExecute(Sender: TObject);
begin
  if swClickStyle.State = tssOff then
    imMenuclose(svDev);

end;

procedure TfmDevCam.cbStyleChange(Sender: TObject);
begin
  Taskbar1.BeforeDestruction;
  Taskbar1.Destroy;
  TStyleManager.SetStyle(cbStyle.Text);
  Taskbar1 := TTaskbar.Create(fmDevCam);
end;

procedure TfmDevCam.FormCreate(Sender: TObject);
var
  StyleName: string;
begin

  // タイトル記載
  lbTitle.Caption := fmDevCam.Caption;
  // Windows Style リストボックスへ投入
  for StyleName in TStyleManager.StyleNames do
    cbStyle.Items.Add(StyleName);

  cbStyle.ItemIndex := cbStyle.Items.IndexOf(TStyleManager.ActiveStyle.Name);

  //SplitView 幅調整用スライダーセット
  ScrollBar1.Max := svDev.Width + 100;
  ScrollBar1.Min := svDev.Width;
  ScrollBar1.Position := svDev.Width;
end;

procedure TfmDevCam.imMenuclose(sv: TSplitView);
begin
  if sv.Opened then
  begin
    sv.Close;
    if pnMenu.Visible then
      pnMenu.Visible := False;
  end
  else
    sv.Open;
end;

procedure TfmDevCam.NotificationCenter1ReceiveLocalNotification(Sender: TObject;
  ANotification: TNotification);
begin
  if ANotification.Name = 'Windows10NotificationTaskbar' then
  begin
    trkTaskbarstate.Position := 0;
    if fmDevCam.WindowState = wsMinimized then
      fmDevCam.WindowState := wsNormal;

  end;
end;

procedure TfmDevCam.ScrollBar1Change(Sender: TObject);
begin
  svDev.Width := ScrollBar1.Position;
end;

procedure TfmDevCam.imMenuClick(Sender: TObject);
begin
  imMenuclose(svDev);
end;

procedure TfmDevCam.swAnimationClick(Sender: TObject);
begin
  svDev.UseAnimation := boolean(swAnimation.State);
  lblAnimationDelay.Enabled := svDev.UseAnimation;
  trkAnimationDelay.Enabled := svDev.UseAnimation;
  lblAnimationStep.Enabled := svDev.UseAnimation;
  trkAnimationStep.Enabled := svDev.UseAnimation;
end;

procedure TfmDevCam.swDockStyleClick(Sender: TObject);
begin
  svDev.DisplayMode := TSplitViewDisplayMode(swDockStyle.State);
end;

procedure TfmDevCam.swPlacementClick(Sender: TObject);
begin
  svDev.Placement := TSplitViewPlacement(swPlacement.State);
end;

procedure TfmDevCam.swShowstyleClick(Sender: TObject);
begin
  svDev.CloseStyle := TSplitViewCloseStyle(swShowstyle.State);
end;

procedure TfmDevCam.swTaskbarStateClick(Sender: TObject);
begin
  if swTaskbarState.State = tssOn then
  begin
    Timer1.Enabled := True;
    trkTaskbarstate.Enabled := True;
    { Unit2.Form2. } Taskbar1.ProgressState := TTaskBarProgressState.Normal;
    setwaitingcur(ActivityIndicator1);
  end
  else
  begin
    Timer1.Enabled := False;
    trkTaskbarstate.Enabled := False;
    ActivityIndicator1.IndicatorType := TActivityIndicatorType.aitSectorRing;
    { Unit2.Form2. } Taskbar1.ProgressState := TTaskBarProgressState.Paused;
  end;
end;

procedure TfmDevCam.Timer1Timer(Sender: TObject);
begin
  if trkTaskbarstate.Position < trkTaskbarstate.Max then
    trkTaskbarstate.Position := trkTaskbarstate.Position + 1;
end;

procedure TfmDevCam.trkAnimationDelayChange(Sender: TObject);
begin
  svDev.AnimationDelay := trkAnimationDelay.Position * 5;
  lblAnimationDelay.Caption := 'Animation Delay (' +
    IntToStr(svDev.AnimationDelay) + ')';
end;

procedure TfmDevCam.trkAnimationStepChange(Sender: TObject);
begin
  svDev.AnimationStep := trkAnimationStep.Position * 5;
  lblAnimationStep.Caption := 'Animation Step (' +
    IntToStr(svDev.AnimationStep) + ')';
end;

procedure TfmDevCam.trkTaskbarstateChange(Sender: TObject);
begin

  if trkTaskbarstate.Position = 0 then
  begin
    Timer1.Enabled := False;
    swTaskbarState.State := tssOff;

  end;

  { unit2.Form2. } Taskbar1.ProgressMaxValue := trkTaskbarstate.Max;
  { unit2.Form2. } Taskbar1.ProgressValue := trkTaskbarstate.Position;
  lbTaskbarstate.Caption := 'タスクバー状況表示 (' +
    IntToStr(trkTaskbarstate.Position * 4) + ')';
  setwaitingcur(ActivityIndicator1);
end;

procedure TfmDevCam.setwaitingcur(ai: TActivityIndicator);
var
  MyNotification: TNotification;

begin

  case trkTaskbarstate.Position of
    0:
      begin
        ai.IndicatorType := TActivityIndicatorType.aitMomentumDots;
        ai.Animate := False;
      end;
    25:
      begin
        if { Unit2.Form2. } Taskbar1.ProgressState <> TTaskBarProgressState.Indeterminate
        then
          { Unit2.Form2. }
          Taskbar1.ProgressState := TTaskBarProgressState.Indeterminate;

        if ai.IndicatorType <> TActivityIndicatorType.aitRotatingSector then
          ai.IndicatorType := TActivityIndicatorType.aitRotatingSector;
        if ai.Animate = False then
          ai.Animate := True;

        // NotificationCenter
        MyNotification := NotificationCenter1.CreateNotification;
        try
          MyNotification.Name := 'Windows10NotificationTaskbar';
          MyNotification.Title := 'Windows 10 Notification ';
          MyNotification.AlertBody := 'タスクバーが100％に達しました';

          NotificationCenter1.PresentNotification(MyNotification);
        finally
          MyNotification.Free;
        end;

      end;
  else
    if { Unit2.Form2. } Taskbar1.ProgressState <> TTaskBarProgressState.Normal
    then
      { Unit2.Form2. } Taskbar1.ProgressState := TTaskBarProgressState.Normal;

    if ai.IndicatorType <> TActivityIndicatorType.aitMomentumDots then
      ai.IndicatorType := TActivityIndicatorType.aitMomentumDots;
    if ai.Animate = False then
      ai.Animate := True;

  end;
end;

end.
