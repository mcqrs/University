model lab2
  Modelica.Blocks.Math.Gain gain1(k = 3.82)  annotation(
    Placement(transformation(origin = {-32, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 0.5, k = 2)  annotation(
    Placement(transformation(origin = {36, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.SecondOrder secondOrder(D = 0.5, k = 1, w = 20)  annotation(
    Placement(transformation(origin = {72, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Integrator integrator(k = 1)  annotation(
    Placement(transformation(origin = {112, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(transformation(origin = {-74, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant const(k = 1)  annotation(
    Placement(transformation(origin = {-112, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain11(k = 1.04) annotation(
    Placement(transformation(origin = {37, -43}, extent = {{-11, -11}, {11, 11}}, rotation = 180)));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
equation
  connect(secondOrder.u, firstOrder.y) annotation(
    Line(points = {{60, 0}, {47, 0}}, color = {0, 0, 127}));
  connect(integrator.u, secondOrder.y) annotation(
    Line(points = {{100, 0}, {83, 0}}, color = {0, 0, 127}));
  connect(gain1.u, feedback.y) annotation(
    Line(points = {{-44, 0}, {-65, 0}}, color = {0, 0, 127}));
  connect(feedback.u1, const.y) annotation(
    Line(points = {{-82, 0}, {-101, 0}}, color = {0, 0, 127}));
  connect(gain11.u, integrator.u) annotation(
    Line(points = {{50.2, -43}, {90.2, -43}, {90.2, 0}, {100.2, 0}}, color = {0, 0, 127}));
  connect(feedback1.y, firstOrder.u) annotation(
    Line(points = {{9, 0}, {24, 0}}, color = {0, 0, 127}));
  connect(gain1.y, feedback1.u1) annotation(
    Line(points = {{-21, 0}, {-8, 0}}, color = {0, 0, 127}));
  connect(integrator.y, feedback.u2) annotation(
    Line(points = {{123, 0}, {123, -72}, {-74, -72}, {-74, -8}}, color = {0, 0, 127}));
  connect(gain11.y, feedback1.u2) annotation(
    Line(points = {{24.9, -43}, {-0.1, -43}, {-0.1, -8}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3")),
  Diagram(coordinateSystem(extent = {{-140, 20}, {140, -80}})),
  version = "");
end lab2;
