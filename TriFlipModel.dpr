program TriFlipModel;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {Form1},
  LUX.D2 in '_LIBRARY\LUXOPHIA\LUX\LUX.D2.pas',
  LUX.D3 in '_LIBRARY\LUXOPHIA\LUX\LUX.D3.pas',
  LUX in '_LIBRARY\LUXOPHIA\LUX\LUX.pas',
  LUX.D1 in '_LIBRARY\LUXOPHIA\LUX\LUX.D1.pas',
  LUX.Brep in '_LIBRARY\LUXOPHIA\LUX.Brep\LUX.Brep.pas',
  LUX.Graph in '_LIBRARY\LUXOPHIA\LUX.Graph\LUX.Graph.pas',
  LUX.Graph.Tree in '_LIBRARY\LUXOPHIA\LUX.Graph\LUX.Graph.Tree.pas',
  LUX.Brep.Poin.D3 in '_LIBRARY\LUXOPHIA\LUX.Brep\LUX.Brep.Poin.D3.pas',
  LUX.Brep.Poin in '_LIBRARY\LUXOPHIA\LUX.Brep\LUX.Brep.Poin.pas',
  LUX.Brep.Face.TriFlip.D3 in '_LIBRARY\LUXOPHIA\LUX.Brep\LUX.Brep.Face.TriFlip.D3.pas',
  LUX.Geometry.D3 in '_LIBRARY\LUXOPHIA\LUX.Geometry\LUX.Geometry.D3.pas',
  LUX.Geometry in '_LIBRARY\LUXOPHIA\LUX.Geometry\LUX.Geometry.pas',
  LUX.Geometry.D2 in '_LIBRARY\LUXOPHIA\LUX.Geometry\LUX.Geometry.D2.pas',
  LUX.Brep.Face.TriFlip in '_LIBRARY\LUXOPHIA\LUX.Brep\LUX.Brep.Face.TriFlip.pas',
  LUX.Brep.Face.TriFlip.D3.FMX in '_LIBRARY\LUXOPHIA\LUX.Brep\LUX.Brep.Face.TriFlip.D3.FMX.pas',
  LUX.Matrix.L2 in '_LIBRARY\LUXOPHIA\LUX.Matrix\LUX.Matrix.L2.pas',
  LUX.Matrix.L3 in '_LIBRARY\LUXOPHIA\LUX.Matrix\LUX.Matrix.L3.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
