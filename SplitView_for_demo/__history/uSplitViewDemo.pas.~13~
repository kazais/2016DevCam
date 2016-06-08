// ---------------------------------------------------------------------------

// This software is Copyright (c) 2015 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of an Embarcadero developer tools product.
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

// ---------------------------------------------------------------------------

unit uSplitViewDemo;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.WinXCtrls,
  Vcl.StdCtrls,
  Vcl.CategoryButtons,
  Vcl.Buttons,
  Vcl.ImgList,
  Vcl.Imaging.PngImage,
  Vcl.ComCtrls,
  Vcl.ActnList, System.Win.TaskbarCore, Vcl.Taskbar, System.Notification;

type
  TSplitViewForm = class(TForm)
    pnlToolbar: TPanel;
    pnlSettings: TPanel;
    SV: TSplitView;
    catMenuItems: TCategoryButtons;
    imlIcons: TImageList;
    imgMenu: TImage;
    cbxVclStyles: TComboBox;
    lblAnimationDelay: TLabel;
    lblAnimationStep: TLabel;
    trkAnimationDelay: TTrackBar;
    trkAnimationStep: TTrackBar;
    ActionList1: TActionList;
    actHome: TAction;
    actLayout: TAction;
    actPower: TAction;
    chkCloseOnMenuClick: TCheckBox;
    lblTitle: TLabel;
    lblVclStyle: TLabel;
    swDisplaymode: TToggleSwitch;
    swPlacement: TToggleSwitch;
    swClosestyle: TToggleSwitch;
    rpanelAnimation: TRelativePanel;
    swAnimation: TToggleSwitch;
    rpanelTaskbarState: TRelativePanel;
    trkTaskbarstate: TTrackBar;
    Taskbar1: TTaskbar;
    ActivityIndicator1: TActivityIndicator;
    swTaskbarState: TToggleSwitch;
    lbTaskbarstate: TLabel;
    Timer1: TTimer;
    NotificationCenter1: TNotificationCenter;
    SearchBox1: TSearchBox;
    rpanelLyout: TRelativePanel;
    procedure FormCreate(Sender: TObject);
    // procedure grpDisplayModeClick(Sender: TObject);
    // procedure grpPlacementClick(Sender: TObject);
    // procedure grpCloseStyleClick(Sender: TObject);
    procedure SVClosed(Sender: TObject);
    procedure SVClosing(Sender: TObject);
    procedure SVOpened(Sender: TObject);
    procedure SVOpening(Sender: TObject);
    procedure catMenuItemsCategoryCollapase(Sender: TObject;
      const Category: TButtonCategory);
    procedure imgMenuClick(Sender: TObject);
    // procedure chkUseAnimationClick(Sender: TObject);
    procedure trkAnimationDelayChange(Sender: TObject);
    procedure trkAnimationStepChange(Sender: TObject);
    procedure actHomeExecute(Sender: TObject);
    procedure actLayoutExecute(Sender: TObject);
    procedure actPowerExecute(Sender: TObject);
    procedure cbxVclStylesChange(Sender: TObject);
    procedure swDisplaymodeClick(Sender: TObject);
    procedure swPlacementClick(Sender: TObject);
    procedure swClosestyleClick(Sender: TObject);
    procedure swAnimationClick(Sender: TObject);
    procedure trkTaskbarstateChange(Sender: TObject);
    procedure swTaskbarStateClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject;
      ANotification: TNotification);
  private
    // procedure Log(const Msg: string);
    procedure setwaitingcur(ai: TActivityIndicator);
  public
  end;

var
  SplitViewForm: TSplitViewForm;

implementation

uses
  Vcl.Themes;

{$R *.dfm}

procedure TSplitViewForm.setwaitingcur(ai: TActivityIndicator);
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
        if Taskbar1.ProgressState <> TTaskBarProgressState.Indeterminate then
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
    if Taskbar1.ProgressState <> TTaskBarProgressState.Normal then
      Taskbar1.ProgressState := TTaskBarProgressState.Normal;

    if ai.IndicatorType <> TActivityIndicatorType.aitMomentumDots then
      ai.IndicatorType := TActivityIndicatorType.aitMomentumDots;
    if ai.Animate = False then
      ai.Animate := True;

  end;
end;

procedure TSplitViewForm.FormCreate(Sender: TObject);
var
  StyleName: string;
begin
  for StyleName in TStyleManager.StyleNames do
    cbxVclStyles.Items.Add(StyleName);

  cbxVclStyles.ItemIndex := cbxVclStyles.Items.IndexOf
    (TStyleManager.ActiveStyle.Name);
end;

procedure TSplitViewForm.cbxVclStylesChange(Sender: TObject);
begin
  TStyleManager.SetStyle(cbxVclStyles.Text);
end;

procedure TSplitViewForm.imgMenuClick(Sender: TObject);
begin
  if SV.Opened then
    SV.Close
  else
    SV.Open;
end;

procedure TSplitViewForm.NotificationCenter1ReceiveLocalNotification
  (Sender: TObject; ANotification: TNotification);
begin
  if ANotification.Name = 'Windows10NotificationTaskbar' then
  begin
    trkTaskbarstate.Position := 0;
    if SplitViewForm.WindowState = wsMinimized then
  SplitViewForm.WindowState := wsNormal;

  end;

end;

// procedure TSplitViewForm.grpDisplayModeClick(Sender: TObject);
// begin
// SV.DisplayMode := TSplitViewDisplayMode(grpDisplayMode.ItemIndex);
// end;
//
// procedure TSplitViewForm.grpCloseStyleClick(Sender: TObject);
// begin
// SV.CloseStyle := TSplitViewCloseStyle(grpCloseStyle.ItemIndex);
// end;
//
// procedure TSplitViewForm.grpPlacementClick(Sender: TObject);
// begin
// SV.Placement := TSplitViewPlacement(grpPlacement.ItemIndex);
// end;

procedure TSplitViewForm.SVClosed(Sender: TObject);
begin
  // When TSplitView is closed, adjust ButtonOptions and Width
  catMenuItems.ButtonOptions := catMenuItems.ButtonOptions - [boShowCaptions];
  if SV.CloseStyle = svcCompact then
    catMenuItems.Width := SV.CompactWidth;
end;

procedure TSplitViewForm.SVClosing(Sender: TObject);
begin
  //
end;

procedure TSplitViewForm.SVOpened(Sender: TObject);
begin
  // When not animating, change size of catMenuItems when TSplitView is opened
  catMenuItems.ButtonOptions := catMenuItems.ButtonOptions + [boShowCaptions];
  catMenuItems.Width := SV.OpenedWidth;
end;

procedure TSplitViewForm.SVOpening(Sender: TObject);
begin
  // When animating, change size of catMenuItems at the beginning of open
  catMenuItems.ButtonOptions := catMenuItems.ButtonOptions + [boShowCaptions];
  catMenuItems.Width := SV.OpenedWidth;
end;

procedure TSplitViewForm.swClosestyleClick(Sender: TObject);
begin
  SV.CloseStyle := TSplitViewCloseStyle(swClosestyle.State);
end;

procedure TSplitViewForm.swDisplaymodeClick(Sender: TObject);
begin
  SV.DisplayMode := TSplitViewDisplayMode(swDisplaymode.State);
end;

procedure TSplitViewForm.swPlacementClick(Sender: TObject);
begin
  SV.Placement := TSplitViewPlacement(swPlacement.State);
end;

procedure TSplitViewForm.swTaskbarStateClick(Sender: TObject);
begin
  if swTaskbarState.State = tssOn then
  begin
    Timer1.Enabled := True;
    trkTaskbarstate.Enabled := True;
    Taskbar1.ProgressState := TTaskBarProgressState.Normal;
    setwaitingcur(ActivityIndicator1);
  end
  else
  begin
    Timer1.Enabled := False;
    trkTaskbarstate.Enabled := False;
    ActivityIndicator1.IndicatorType := TActivityIndicatorType.aitSectorRing;
    Taskbar1.ProgressState := TTaskBarProgressState.Paused;
  end;

end;

procedure TSplitViewForm.Timer1Timer(Sender: TObject);
begin
  if trkTaskbarstate.Position < trkTaskbarstate.Max then
    trkTaskbarstate.Position := trkTaskbarstate.Position + 1;
end;

procedure TSplitViewForm.trkTaskbarstateChange(Sender: TObject);

begin

  if trkTaskbarstate.Position = 0 then
  begin
    Timer1.Enabled := False;
    swTaskbarState.State := tssOff;

  end;

  Taskbar1.ProgressMaxValue := trkTaskbarstate.Max;
  Taskbar1.ProgressValue := trkTaskbarstate.Position;
  lbTaskbarstate.Caption := 'タスクバー状況表示 (' +
    IntToStr(trkTaskbarstate.Position * 4) + ')';
  setwaitingcur(ActivityIndicator1);

end;

procedure TSplitViewForm.swAnimationClick(Sender: TObject);
begin
  SV.UseAnimation := boolean(swAnimation.State);
  lblAnimationDelay.Enabled := SV.UseAnimation;
  trkAnimationDelay.Enabled := SV.UseAnimation;
  lblAnimationStep.Enabled := SV.UseAnimation;
  trkAnimationStep.Enabled := SV.UseAnimation;
end;

// procedure TSplitViewForm.chkUseAnimationClick(Sender: TObject);
// begin
// SV.UseAnimation := chkUseAnimation.Checked;
// lblAnimationDelay.Enabled := SV.UseAnimation;
// trkAnimationDelay.Enabled := SV.UseAnimation;
// lblAnimationStep.Enabled := SV.UseAnimation;
// trkAnimationStep.Enabled := SV.UseAnimation;
// end;

procedure TSplitViewForm.trkAnimationDelayChange(Sender: TObject);
begin
  SV.AnimationDelay := trkAnimationDelay.Position * 5;
  lblAnimationDelay.Caption := 'Animation Delay (' +
    IntToStr(SV.AnimationDelay) + ')';
end;

procedure TSplitViewForm.trkAnimationStepChange(Sender: TObject);
begin
  SV.AnimationStep := trkAnimationStep.Position * 5;
  lblAnimationStep.Caption := 'Animation Step (' +
    IntToStr(SV.AnimationStep) + ')';
end;

procedure TSplitViewForm.actHomeExecute(Sender: TObject);
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
  if SV.Opened and chkCloseOnMenuClick.Checked then
    SV.Close;
end;

procedure TSplitViewForm.actLayoutExecute(Sender: TObject);
begin
  // Log(actLayout.Caption + ' Clicked');
  rpanelLyout.Visible := not(rpanelLyout.Visible);
  if SV.Opened and chkCloseOnMenuClick.Checked then
    SV.Close;
end;

procedure TSplitViewForm.actPowerExecute(Sender: TObject);
begin
  // Log(actPower.Caption + ' Clicked');
  if SV.Opened and chkCloseOnMenuClick.Checked then
    SV.Close;
end;

procedure TSplitViewForm.catMenuItemsCategoryCollapase(Sender: TObject;
  const Category: TButtonCategory);
begin
  // Prevent the catMenuItems Category group from being collapsed
  catMenuItems.Categories[0].Collapsed := False;
end;

// procedure TSplitViewForm.Log(const Msg: string);
// var
// Idx: Integer;
// begin
// Idx := lstLog.Items.Add(Msg);
// lstLog.TopIndex := Idx;
// end;

end.
