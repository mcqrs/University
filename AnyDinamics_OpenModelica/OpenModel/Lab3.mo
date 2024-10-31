model Lab3_n
  Modelica.Electrical.Analog.Basic.Resistor R1(R = 3) annotation(
    Placement(transformation(origin = {-80, 66}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SW1 annotation(
    Placement(transformation(origin = {-80, 28}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Ground EA1 annotation(
    Placement(transformation(origin = {-80, -72}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Transformer L1_L2(L1 = 4, L2 = 2, M = 1) annotation(
    Placement(transformation(origin = {0, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Electrical.Analog.Basic.Capacitor C1(C = 5)  annotation(
    Placement(transformation(origin = {-20, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Resistor R3(R = 2) annotation(
    Placement(transformation(origin = {30, 80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Capacitor C2(C = 10) annotation(
    Placement(transformation(origin = {70, 80}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SW3 annotation(
    Placement(transformation(origin = {80, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Resistor R4(R = 7) annotation(
    Placement(transformation(origin = {80, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse1(period = 10, width = 100) annotation(
    Placement(transformation(origin = {-116, 28}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse2(period = 10, width = 100) annotation(
    Placement(transformation(origin = {48, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground EA2 annotation(
    Placement(transformation(origin = {80, -72}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sources.SineVoltage U1(V = 20)  annotation(
    Placement(transformation(origin = {-80, -6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.SineVoltage U2(V = 25)  annotation(
    Placement(transformation(origin = {16, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(SW1.p, R1.n) annotation(
    Line(points = {{-80, 38}, {-80, 56}}, color = {0, 0, 255}));
  connect(C1.n, R1.p) annotation(
    Line(points = {{-20, 60}, {-20, 80}, {-80, 80}, {-80, 76}}, color = {0, 0, 255}));
  connect(R3.n, C2.p) annotation(
    Line(points = {{40, 80}, {60, 80}}, color = {0, 0, 255}));
  connect(C2.n, SW3.p) annotation(
    Line(points = {{80, 80}, {80, 40}}, color = {0, 0, 255}));
  connect(SW3.n, R4.p) annotation(
    Line(points = {{80, 20}, {80, 0}}, color = {0, 0, 255}));
  connect(booleanPulse2.y, SW3.control) annotation(
    Line(points = {{60, 30}, {68, 30}}, color = {255, 0, 255}));
  connect(booleanPulse1.y, SW1.control) annotation(
    Line(points = {{-104, 28}, {-92, 28}}, color = {255, 0, 255}));
  connect(C1.p, L1_L2.n2) annotation(
    Line(points = {{-20, 40}, {-18, 40}, {-18, -2}, {-10, -2}}, color = {0, 0, 255}));
  connect(R4.n, L1_L2.p1) annotation(
    Line(points = {{80, -20}, {45, -20}, {45, -22}, {10, -22}}, color = {0, 0, 255}));
  connect(EA2.p, R4.n) annotation(
    Line(points = {{80, -62}, {80, -20}}, color = {0, 0, 255}));
  connect(R3.p, U2.n) annotation(
    Line(points = {{20, 80}, {16, 80}, {16, 42}}, color = {0, 0, 255}));
  connect(U2.p, L1_L2.n1) annotation(
    Line(points = {{16, 22}, {10, 22}, {10, -2}}, color = {0, 0, 255}));
  connect(U1.p, SW1.n) annotation(
    Line(points = {{-80, 4}, {-80, 18}}, color = {0, 0, 255}));
  connect(U1.n, EA1.p) annotation(
    Line(points = {{-80, -16}, {-80, -62}}, color = {0, 0, 255}));
  connect(U1.n, L1_L2.p2) annotation(
    Line(points = {{-80, -16}, {-80, -22}, {-10, -22}}, color = {0, 0, 255}));

annotation(
    uses(Modelica(version = "4.0.0")));
end Lab3_n;
