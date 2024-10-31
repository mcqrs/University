model lab1
  parameter Real k0 = 2;
  parameter Real K=2;
  parameter Real a = 1;
  parameter Real k1 = 4;
  parameter Real k3 = -1;
  parameter Real k4 = 4;
  parameter Real c=3;
  Real x(start=-c), y(start=-c), F;
  

equation
  if (x<-a) then
    F = k0*x;
  elseif (x<0) then
    F = -K;
  elseif (x < a) then
    F = K;
  else
    F = k0*x;
  end if;
 
  der (x) = y;
  der (y) = -k1*F-k4*x+k3*x^3;

end lab1;
