unit Main;

interface //#################################################################### Å°

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors,
  FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D, FMX.Types3D, FMX.MaterialSources,
  LUX.Brep.Face.TriFlip.D3, LUX.Brep.Face.TriFlip.D3.FMX;

type
  TForm1 = class(TForm)
    Viewport3D1: TViewport3D;
    Grid3D1: TGrid3D;
    Light1: TLight;
    Camera1: TCamera;
    Dummy1: TDummy;
    Dummy2: TDummy;
    LightMaterialSource1: TLightMaterialSource;
    procedure FormCreate(Sender: TObject);
    procedure Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure Viewport3D1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  private
    { private êÈåæ }
    _MouseS :TShiftState;
    _MouseP :TPointF;
  public
    { public êÈåæ }
    _FaceModel  :TTriFaceModel3D;
    _FaceObject :TTriFaceObject3D;
  end;

var
  Form1: TForm1;

implementation //############################################################### Å°

{$R *.fmx}

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
begin
     _FaceModel := TTriFaceModel3D.Create;

     with _FaceModel do
     begin
          LoadFromFile( '..\..\_DATA\Torus3.obj' );
     end;

     with LightMaterialSource1 do
     begin
          Texture.LoadFromFile( '..\..\_DATA\Texture.bmp' );
     end;

     _FaceObject := TTriFaceObject3D.Create( Self );

     with _FaceObject do
     begin
          Parent := Viewport3D1;

          Material := LightMaterialSource1;

          HitTest := False;

          Model := _FaceModel;
     end;
end;

//------------------------------------------------------------------------------

procedure TForm1.Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     _MouseS := Shift;
     _MouseP := TPointF.Create( X, Y );
end;

procedure TForm1.Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
   P :TPointF;
begin
     if ssLeft in _MouseS then
     begin
          P := TPointF.Create( X, Y );

          with Dummy1.RotationAngle do Y := Y + ( P.X - _MouseP.X );
          with Dummy2.RotationAngle do X := X - ( P.Y - _MouseP.Y );

          _MouseP := P;
     end;
end;

procedure TForm1.Viewport3D1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     Viewport3D1MouseMove( Sender, Shift, X, Y );

     _MouseS := [];
end;

end. //######################################################################### Å°
