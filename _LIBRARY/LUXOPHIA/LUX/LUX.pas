﻿unit LUX;

interface //#################################################################### ■

uses System.SysUtils, System.UITypes, System.Math.Vectors,
     FMX.Graphics, FMX.Types3D, FMX.Controls3D, FMX.Objects3D;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     PPByte = ^PByte;

     PInt8   = ^Int8;
     PUInt8  = ^UInt8;
     PInt16  = ^Int16;
     PUInt16 = ^UInt16;
     PInt32  = ^Int32;
     PUInt32 = ^UInt32;

     PIntPtr  = ^IntPtr;
     PUIntPtr = ^UIntPtr;

     TArray2<TValue_> = array of TArray <TValue_>;
     TArray3<TValue_> = array of TArray2<TValue_>;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HMatrix3D

     HMatrix3D = record helper for TMatrix3D
     private
       ///// アクセス
       function GetTranslate :TPoint3D;
       procedure SetTranslate( const Translate_:TPoint3D );
     public
       ///// プロパティ
       property Translate :TPoint3D read GetTranslate write SetTranslate;
       ///// 定数
       class function Identity :TMatrix3D; static;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HBitmapData

     HBitmapData = record helper for TBitmapData
     private
       ///// アクセス
       function GetColor( const X_,Y_:Integer ) :TAlphaColor;
       procedure SetColor( const X_,Y_:Integer; const Color_:TAlphaColor );
     public
       ///// プロパティ
       property Color[ const X_,Y_:Integer ] :TAlphaColor read GetColor write SetColor;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRay3D

     TRay3D = record
     private
     public
       Pos :TVector3D;
       Vec :TVector3D;
       /////
       constructor Create( const Pos_,Vec_:TVector3D );
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRangeArray<_TValue_>

     TRangeArray<_TValue_> = record
     private
       _Values :TArray<_TValue_>;
       _MinI   :Integer;
       _MaxI   :Integer;
       ///// アクセス
       function GetValues( I_:Integer ) :_TValue_;
       procedure SetValues( I_:Integer; const Value_:_TValue_ );
       procedure SetMinI( const MinI_:Integer );
       procedure SetMaxI( const MaxI_:Integer );
       function GetCount :Integer;
       ///// メソッド
       procedure InitArray;
     public
       constructor Create( const MinI_,MaxI_:Integer );
       ///// プロパティ
       property Values[ I_:Integer ] :_TValue_ read GetValues write SetValues; default;
       property MinI                 :Integer  read   _MinI   write SetMinI  ;
       property MaxI                 :Integer  read   _MaxI   write SetMaxI  ;
       property Count                :Integer  read GetCount                 ;
       ///// メソッド
       procedure SetRange( const I_:Integer ); overload;
       procedure SetRange( const MinI_,MaxI_:Integer ); overload;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMarginArray<_TValue_>

     TMarginArray<_TValue_> = record
     private
       _Values :TArray<_TValue_>;
       _LowerN :Integer;
       _Count  :Integer;
       _UpperN :Integer;
       ///// アクセス
       function GetValues( I_:Integer ) :_TValue_;
       procedure SetValues( I_:Integer; const Value_:_TValue_ );
       procedure SetLowerN( const LowerN_:Integer );
       procedure SetCount( const Count_:Integer );
       procedure SetUpperN( const UpperN_:Integer );
       ///// メソッド
       procedure InitArray;
     public
       constructor Create( const LowerN_,Count_,UpperN_:Integer );
       ///// プロパティ
       property Values[ I_:Integer ] :_TValue_ read GetValues write SetValues; default;
       property LowerN               :Integer  read   _LowerN write SetLowerN;
       property Count                :Integer  read   _Count  write SetCount ;
       property UpperN               :Integer  read   _UpperN write SetUpperN;
     end;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HCanvas

     HCanvas = class helper for TCanvas
     private
     protected
       ///// アクセス
       function GetMatrix :TMatrix;
       procedure SetMatrix( const Matrix_:TMatrix );
     public
       property Matrix :TMatrix read GetMatrix write SetMatrix;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HControl3D

     HControl3D = class helper for TControl3D
     private
     protected
       ///// アクセス
       function GetAbsolMatrix :TMatrix3D;
       procedure SetAbsoluteMatrix( const AbsoluteMatrix_:TMatrix3D ); virtual;
       function GetLocalMatrix :TMatrix3D; virtual;
       procedure SetLocalMatrix( const LocalMatrix_:TMatrix3D ); virtual;
       ///// メソッド
       procedure RecalcFamilyAbsolute;
       procedure RecalcChildrenAbsolute;
     public
       ///// プロパティ
       property AbsoluteMatrix :TMatrix3D read GetAbsolMatrix write SetAbsoluteMatrix;
       property LocalMatrix    :TMatrix3D read GetLocalMatrix write SetLocalMatrix   ;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HCustomMesh

     HCustomMesh = class helper for TCustomMesh
     private
     protected
       ///// アクセス
       function GetMeshData :TMeshData;
     public
       ///// プロパティ
       property MeshData :TMeshData read GetMeshData;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TIter< TValue_ >

     TIter< TValue_ > = class
     private
     protected
       ///// アクセス
       function GetValue :TValue_; virtual; abstract;
       procedure SetValue( const Value_:TValue_ ); virtual; abstract;
     public
       ///// プロパティ
       property Value :TValue_ read GetValue write SetValue;
     end;

const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

      Pi2 = 2 * Pi;
      Pi3 = 3 * Pi;
      Pi4 = 4 * Pi;

      P2i = Pi / 2;
      P3i = Pi / 3;
      P4i = Pi / 4;

      CRLF = #13#10;

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

{$IF SizeOf( Extended ) = 10 }
  function Int( const X_:Extended ) :Extended; inline; overload;
  function Frac( const X_:Extended ) :Extended; inline; overload;
  function Exp( const X_:Extended ) :Extended; inline; overload;
  function Cos( const X_:Extended ) :Extended; inline; overload;
  function Sin( const X_:Extended ) :Extended; inline; overload;
  function Ln( const X_:Extended ) :Extended; inline; overload;
  function ArcTan( const X_:Extended ) :Extended; inline; overload;
  function Sqrt( const X_:Extended ) :Extended; inline; overload;
  function Tangent( const X_:Extended ) :Extended; inline; overload;
  procedure SineCosine( const X_:Extended; var Sin_,Cos_:Extended ); inline; overload;
  function ExpMinus1( const X_:Extended) :Extended; inline; overload;
  function LnXPlus1( const X_:Extended) :Extended; inline; overload;
{$ENDIF}

function Pow2( const X_:Integer ) :Integer; inline; overload;
function Pow2( const X_:Single ) :Single; inline; overload;
function Pow2( const X_:Double ) :Double; inline; overload;

function Pow3( const X_:Integer ) :Integer; inline; overload;
function Pow3( const X_:Single ) :Single; inline; overload;
function Pow3( const X_:Double ) :Double; inline; overload;

function Roo2( const X_:Single ) :Single; inline; overload;
function Roo2( const X_:Double ) :Double; inline; overload;

function Roo3( const X_:Single ) :Single; inline; overload;
function Roo3( const X_:Double ) :Double; inline; overload;

function ClipRange( const X_,Min_,Max_:Integer ) :Integer; inline; overload;
function ClipRange( const X_,Min_,Max_:Single ) :Single; inline; overload;
function ClipRange( const X_,Min_,Max_:Double ) :Double; inline; overload;

function Min( const A_,B_,C_:Integer ) :Integer; overload;
function Min( const A_,B_,C_:Single ) :Single; overload;
function Min( const A_,B_,C_:Double ) :Double; overload;

function Max( const A_,B_,C_:Integer ) :Integer; overload;
function Max( const A_,B_,C_:Single ) :Single; overload;
function Max( const A_,B_,C_:Double ) :Double; overload;

function MinI( const A_,B_,C_:Integer ) :Integer; inline; overload;
function MinI( const A_,B_,C_:Single ) :Integer; inline; overload;
function MinI( const A_,B_,C_:Double ) :Integer; inline; overload;

function MaxI( const A_,B_,C_:Integer ) :Integer; inline; overload;
function MaxI( const A_,B_,C_:Single ) :Integer; inline; overload;
function MaxI( const A_,B_,C_:Double ) :Integer; inline; overload;

function MinI( const Vs_:array of Integer ) :Integer; overload;
function MinI( const Vs_:array of Single ) :Integer; overload;
function MinI( const Vs_:array of Double ) :Integer; overload;

function MaxI( const Vs_:array of Integer ) :Integer; overload;
function MaxI( const Vs_:array of Single ) :Integer; overload;
function MaxI( const Vs_:array of Double ) :Integer; overload;

function RealMod( const X_,Range_:Integer ) :Integer; overload;
function RealMod( const X_,Range_:Int64 ) :Int64; overload;

function FileToBytes( const FileName_:string ) :TBytes;

implementation //############################################################### ■

uses System.Classes, System.Math,
     FMX.Types;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HMatrix3D

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function HMatrix3D.GetTranslate :TPoint3D;
begin
     with Result do
     begin
          X := m41;
          Y := m42;
          Z := m43;
     end;
end;

procedure HMatrix3D.SetTranslate( const Translate_:TPoint3D );
begin
     with Translate_ do
     begin
          m41 := X;
          m42 := Y;
          m43 := Z;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////////// 定数

class function HMatrix3D.Identity :TMatrix3D;
begin
     with Result do
     begin
          m11 := 1;  m12 := 0;  m13 := 0;  m14 := 0;
          m21 := 0;  m22 := 1;  m23 := 0;  m24 := 0;
          m31 := 0;  m32 := 0;  m33 := 1;  m34 := 0;
          m41 := 0;  m42 := 0;  m43 := 0;  m44 := 1;
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HBitmapData

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function HBitmapData.GetColor( const X_,Y_:Integer ) :TAlphaColor;
begin
     Result := GetPixel( X_, Y_ );
end;

procedure HBitmapData.SetColor( const X_,Y_:Integer; const Color_:TAlphaColor );
begin
     SetPixel( X_, Y_, Color_ );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRay3D

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TRay3D.Create( const Pos_,Vec_:TVector3D );
begin
     Pos := Pos_;
     Vec := Vec_;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRangeArray<_TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function TRangeArray<_TValue_>.GetValues( I_:Integer ) :_TValue_;
begin
     Dec( I_, _MinI );  Result := _Values[ I_ ];
end;

procedure TRangeArray<_TValue_>.SetValues( I_:Integer; const Value_:_TValue_ );
begin
     Dec( I_, _MinI );  _Values[ I_ ] := Value_;
end;

procedure TRangeArray<_TValue_>.SetMinI( const MinI_:Integer );
begin
     _MinI := MinI_;

     InitArray;
end;

procedure TRangeArray<_TValue_>.SetMaxI( const MaxI_:Integer );
begin
     _MaxI := MaxI_;

     InitArray;
end;

function TRangeArray<_TValue_>.GetCount :Integer;
begin
     Result := _MaxI - _MinI + 1;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TRangeArray<_TValue_>.InitArray;
begin
     SetLength( _Values, GetCount );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TRangeArray<_TValue_>.Create( const MinI_,MaxI_:Integer );
begin
     SetRange( MinI_, MaxI_ );
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TRangeArray<_TValue_>.SetRange( const I_:Integer );
begin
     SetRange( I_, I_ );
end;

procedure TRangeArray<_TValue_>.SetRange( const MinI_,MaxI_:Integer );
begin
     _MinI := MinI_;
     _MaxI := MaxI_;

     InitArray;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMarginArray<_TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function TMarginArray<_TValue_>.GetValues( I_:Integer ) :_TValue_;
begin
     Inc( I_, _LowerN );  Result := _Values[ I_ ];
end;

procedure TMarginArray<_TValue_>.SetValues( I_:Integer; const Value_:_TValue_ );
begin
     Inc( I_, _LowerN );  _Values[ I_ ] := Value_;
end;

procedure TMarginArray<_TValue_>.SetLowerN( const LowerN_:Integer );
begin
     _LowerN := LowerN_;

     InitArray;
end;

procedure TMarginArray<_TValue_>.SetCount( const Count_:Integer );
begin
     _Count := Count_;

     InitArray;
end;

procedure TMarginArray<_TValue_>.SetUpperN( const UpperN_:Integer );
begin
     _UpperN := UpperN_;

     InitArray;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TMarginArray<_TValue_>.InitArray;
begin
     SetLength( _Values, _LowerN + _Count + _UpperN );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TMarginArray<_TValue_>.Create( const LowerN_,Count_,UpperN_:Integer );
begin
     _LowerN := LowerN_;
     _Count  :=Count_ ;
     _UpperN :=UpperN_;

     InitArray;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HCanvas

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function HCanvas.GetMatrix :TMatrix;
begin
     with Self do
     begin
          Result := FMatrix;
     end;
end;

procedure HCanvas.SetMatrix( const Matrix_:TMatrix );
begin
     inherited SetMatrix( Matrix_ );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HControl3D

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function HControl3D.GetAbsolMatrix :TMatrix3D;
begin
     if FRecalcAbsolute then
     begin
          if FParent is TControl3D then FAbsoluteMatrix := FLocalMatrix * TControl3D(FParent).AbsoluteMatrix
                                   else FAbsoluteMatrix := FLocalMatrix;

          Result := FAbsoluteMatrix;

          FInvAbsoluteMatrix := FAbsoluteMatrix.Inverse;

          FRecalcAbsolute := False;
     end
     else Result := FAbsoluteMatrix;
end;

procedure HControl3D.SetAbsoluteMatrix( const AbsoluteMatrix_:TMatrix3D );
begin
        FAbsoluteMatrix := AbsoluteMatrix_;
     FInvAbsoluteMatrix := AbsoluteMatrix_.Inverse;

     if Assigned( FParent ) and ( FParent is TControl3D )
     then FLocalMatrix := FAbsoluteMatrix * TControl3D( FParent ).AbsoluteMatrix.Inverse
     else FLocalMatrix := FAbsoluteMatrix;

     RecalcChildrenAbsolute;
end;

function HControl3D.GetLocalMatrix :TMatrix3D;
begin
     Result := FLocalMatrix;
end;

procedure HControl3D.SetLocalMatrix( const LocalMatrix_:TMatrix3D );
begin
     FLocalMatrix := LocalMatrix_;

     RecalcFamilyAbsolute;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure HControl3D.RecalcFamilyAbsolute;
begin
     RecalcAbsolute;
end;

procedure HControl3D.RecalcChildrenAbsolute;
var
   F :TFmxObject;
begin
     FRecalcAbsolute := False;

     if Assigned( Children ) then
     begin
          for F in Children do
          begin
               if F is TControl3D then TControl3D( F ).RecalcFamilyAbsolute;
          end;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HCustomMesh

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function HCustomMesh.GetMeshData :TMeshData;
begin
     Result := Data;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

{$IF SizeOf( Extended ) = 10 }

function Int( const X_:Extended ) :Extended;
begin
     Result := System.Int( X_ );
end;

function Frac( const X_:Extended ) :Extended;
begin
     Result := System.Frac( X_ );
end;

function Exp( const X_:Extended ) :Extended;
begin
     Result := System.Exp( X_ );
end;

function Cos( const X_:Extended ) :Extended;
begin
     Result := System.Cos( X_ );
end;

function Sin( const X_:Extended ) :Extended;
begin
     Result := System.Sin( X_ );
end;

function Ln( const X_:Extended ) :Extended;
begin
     Result := System.Ln( X_ );
end;

function ArcTan( const X_:Extended ) :Extended;
begin
     Result := System.ArcTan( X_ );
end;

function Sqrt( const X_:Extended ) :Extended;
begin
     Result := System.Sqrt( X_ );
end;

function Tangent( const X_:Extended ) :Extended;
begin
     Result := System.Tangent( X_ );
end;

procedure SineCosine( const X_:Extended; var Sin_,Cos_:Extended );
begin
     System.SineCosine( X_, Sin_, Cos_ );
end;

function ExpMinus1( const X_:Extended) :Extended;
begin
     Result := System.ExpMinus1( X_ );
end;

function LnXPlus1( const X_:Extended) :Extended;
begin
     Result := System.LnXPlus1( X_ );
end;

{$ENDIF}

////////////////////////////////////////////////////////////////////////////////

function Pow2( const X_:Integer ) :Integer;
begin
     Result := Sqr( X_ );
end;

function Pow2( const X_:Single ) :Single;
begin
     Result := Sqr( X_ );
end;

function Pow2( const X_:Double ) :Double;
begin
     Result := Sqr( X_ );
end;

////////////////////////////////////////////////////////////////////////////////

function Pow3( const X_:Integer ) :Integer;
begin
     Result := X_ * Pow2( X_ );
end;

function Pow3( const X_:Single ) :Single;
begin
     Result := X_ * Pow2( X_ );
end;

function Pow3( const X_:Double ) :Double;
begin
     Result := X_ * Pow2( X_ );
end;

////////////////////////////////////////////////////////////////////////////////

function Roo2( const X_:Single ) :Single;
begin
     Result := Sqrt( X_ );
end;

function Roo2( const X_:Double ) :Double;
begin
     Result := Sqrt( X_ );
end;

////////////////////////////////////////////////////////////////////////////////

function Roo3( const X_:Single ) :Single;
begin
     Result := Power( X_, 1/3 );
end;

function Roo3( const X_:Double ) :Double;
begin
     Result := Power( X_, 1/3 );
end;

////////////////////////////////////////////////////////////////////////////////

function ClipRange( const X_,Min_,Max_:Integer ) :Integer;
begin
     if X_ < Min_ then Result := Min_
                  else
     if X_ > Max_ then Result := Max_
                  else Result := X_;
end;

function ClipRange( const X_,Min_,Max_:Single ) :Single;
begin
     if X_ < Min_ then Result := Min_
                  else
     if X_ > Max_ then Result := Max_
                  else Result := X_;
end;

function ClipRange( const X_,Min_,Max_:Double ) :Double;
begin
     if X_ < Min_ then Result := Min_
                  else
     if X_ > Max_ then Result := Max_
                  else Result := X_;
end;

////////////////////////////////////////////////////////////////////////////////

function Min( const A_,B_,C_:Integer ) :Integer;
begin
     if A_ <= B_ then
     begin
          if A_ <= C_ then Result := A_
                      else Result := C_;
     end
     else
     begin
          if B_ <= C_ then Result := B_
                      else Result := C_;
     end;
end;

function Min( const A_,B_,C_:Single ) :Single;
begin
     if A_ <= B_ then
     begin
          if A_ <= C_ then Result := A_
                      else Result := C_;
     end
     else
     begin
          if B_ <= C_ then Result := B_
                      else Result := C_;
     end;
end;

function Min( const A_,B_,C_:Double ) :Double;
begin
     if A_ <= B_ then
     begin
          if A_ <= C_ then Result := A_
                      else Result := C_;
     end
     else
     begin
          if B_ <= C_ then Result := B_
                      else Result := C_;
     end;
end;

////////////////////////////////////////////////////////////////////////////////

function Max( const A_,B_,C_:Integer ) :Integer;
begin
     if A_ >= B_ then
     begin
          if A_ >= C_ then Result := A_
                      else Result := C_;
     end
     else
     begin

          if B_ >= C_ then Result := B_
                      else Result := C_;
     end;
end;

function Max( const A_,B_,C_:Single ) :Single;
begin
     if A_ >= B_ then
     begin
          if A_ >= C_ then Result := A_
                      else Result := C_;
     end
     else
     begin

          if B_ >= C_ then Result := B_
                      else Result := C_;
     end;
end;

function Max( const A_,B_,C_:Double ) :Double;
begin
     if A_ >= B_ then
     begin
          if A_ >= C_ then Result := A_
                      else Result := C_;
     end
     else
     begin

          if B_ >= C_ then Result := B_
                      else Result := C_;
     end;
end;

////////////////////////////////////////////////////////////////////////////////

function MinI( const A_,B_,C_:Integer ) :Integer;
begin
     if A_ <= B_ then
     begin
          if A_ <= C_ then Result := 1
                      else Result := 3;
     end
     else
     begin
          if B_ <= C_ then Result := 2
                      else Result := 3;
     end;
end;

function MinI( const A_,B_,C_:Single ) :Integer;
begin
     if A_ <= B_ then
     begin
          if A_ <= C_ then Result := 1
                      else Result := 3;
     end
     else
     begin
          if B_ <= C_ then Result := 2
                      else Result := 3;
     end;
end;

function MinI( const A_,B_,C_:Double ) :Integer;
begin
     if A_ <= B_ then
     begin
          if A_ <= C_ then Result := 1
                      else Result := 3;
     end
     else
     begin
          if B_ <= C_ then Result := 2
                      else Result := 3;
     end;
end;

////////////////////////////////////////////////////////////////////////////////

function MaxI( const A_,B_,C_:Integer ) :Integer;
begin
     if A_ >= B_ then
     begin
          if A_ >= C_ then Result := 1
                      else Result := 3;
     end
     else
     begin
          if B_ >= C_ then Result := 2
                      else Result := 3;
     end;
end;

function MaxI( const A_,B_,C_:Single ) :Integer;
begin
     if A_ >= B_ then
     begin
          if A_ >= C_ then Result := 1
                      else Result := 3;
     end
     else
     begin
          if B_ >= C_ then Result := 2
                      else Result := 3;
     end;
end;

function MaxI( const A_,B_,C_:Double ) :Integer;
begin
     if A_ >= B_ then
     begin
          if A_ >= C_ then Result := 1
                      else Result := 3;
     end
     else
     begin
          if B_ >= C_ then Result := 2
                      else Result := 3;
     end;
end;

////////////////////////////////////////////////////////////////////////////////

function MinI( const Vs_:array of Integer ) :Integer;
var
   I, V0, V1 :Integer;
begin
     Result := 0;  V0 := Vs_[ 0 ];

     for I := 1 to High( Vs_ ) do
     begin
          V1 := Vs_[ I ];

          if V1 < V0 then
          begin
               Result := I;  V0 := V1;
          end
     end
end;

function MinI( const Vs_:array of Single ) :Integer;
var
   I :Integer;
   V0, V1 :Single;
begin
     Result := 0;  V0 := Vs_[ 0 ];

     for I := 1 to High( Vs_ ) do
     begin
          V1 := Vs_[ I ];

          if V1 < V0 then
          begin
               Result := I;  V0 := V1;
          end
     end
end;

function MinI( const Vs_:array of Double ) :Integer;
var
   I :Integer;
   V0, V1 :Double;
begin
     Result := 0;  V0 := Vs_[ 0 ];

     for I := 1 to High( Vs_ ) do
     begin
          V1 := Vs_[ I ];

          if V1 < V0 then
          begin
               Result := I;  V0 := V1;
          end
     end
end;

////////////////////////////////////////////////////////////////////////////////

function MaxI( const Vs_:array of Integer ) :Integer;
var
   I, V0, V1 :Integer;
begin
     Result := 0;  V0 := Vs_[ 0 ];

     for I := 1 to High( Vs_ ) do
     begin
          V1 := Vs_[ I ];

          if V1 > V0 then
          begin
               Result := I;  V0 := V1;
          end
     end
end;

function MaxI( const Vs_:array of Single ) :Integer;
var
   I :Integer;
   V0, V1 :Single;
begin
     Result := 0;  V0 := Vs_[ 0 ];

     for I := 1 to High( Vs_ ) do
     begin
          V1 := Vs_[ I ];

          if V1 > V0 then
          begin
               Result := I;  V0 := V1;
          end
     end
end;

function MaxI( const Vs_:array of Double ) :Integer;
var
   I :Integer;
   V0, V1 :Double;
begin
     Result := 0;  V0 := Vs_[ 0 ];

     for I := 1 to High( Vs_ ) do
     begin
          V1 := Vs_[ I ];

          if V1 > V0 then
          begin
               Result := I;  V0 := V1;
          end
     end
end;

////////////////////////////////////////////////////////////////////////////////

function RealMod( const X_,Range_:Integer ) :Integer;
begin
     Result := X_ mod Range_;  if Result < 0 then Inc( Result, Range_ );
end;

function RealMod( const X_,Range_:Int64 ) :Int64;
begin
     Result := X_ mod Range_;  if Result < 0 then Inc( Result, Range_ );
end;

////////////////////////////////////////////////////////////////////////////////

function FileToBytes( const FileName_:string ) :TBytes;
begin
     with TMemoryStream.Create do
     begin
          try
             LoadFromFile( FileName_ );

             SetLength( Result, Size );

             Read( Result, Size );

          finally
                 Free;
          end;
     end;
end;

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

     Randomize;

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
