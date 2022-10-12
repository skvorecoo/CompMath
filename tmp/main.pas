uses math;

var k: Real;

const a=1.0;
      b=1.9;
      E=0.0001;

function f(x: Real): Real;

begin
  f:=sin(x+0.5)-2*x+1.5;
end;

function ff(x: Real): Real;

begin
  ff:=cos(x+0.5)-2;
end;

function fff(x: Real): Real;

begin
  fff:=-sin(x+0.5);
end;

procedure Combined;

var xk, xks: Real;

begin
  if f(a)*fff(a)>0 then
  begin
    xk:=a;
    xks:=b;
  end;
  if f(b)*fff(b)>0 then
  begin
    xk:=b;
    xks:=a;
  end;
  repeat
    xk:=xk-(f(xk)/ff(xk));
    xks:=xks-f(xks)*((xks-xk)/(f(xks)-f(xk)));
  until (abs(xk-xks)) <= E; 
  if ff(0)*fff(0)>0 then
    WriteLn((xk+xks)*0.5:0:4);
  if ff(0)*fff(0)<0 then
    WriteLn((xk+xks)*0.5:0:4);
end;

function w(center: Real): Real;

begin
  w:=center-f(center)/k;
end;

procedure Iterative;

var center, d: Real;

begin
  center:=0;
  if abs(ff(a)) > abs(ff(b)) then
    k:=(ff(a)/2)
  else
    k:=(ff(b)/2);
  repeat
    if abs(center) > abs(w(center)) then
      d:=abs(center-w(center))
    else
      d:=abs(w(center)-center);
    center:=w(center);
  until d <= E;
  WriteLn(w(center):0:4);
end;

begin
  WriteLn('Фунция: f(x)=sin(x+0.5)-2*x+1.5 Интервал: [1.0; 1.9] E=0.0001');
  WriteLn('Производные: f`=cos(x+0.5)-2 f``=-sin(x+0.5)');
  Write('Метод итераций: ');
  Iterative;
  Write('Комбинированный метод: ');
  Combined;
  ReadLn;
end.