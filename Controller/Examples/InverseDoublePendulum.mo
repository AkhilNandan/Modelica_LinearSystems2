within Modelica_LinearSystems2.Controller.Examples;
model InverseDoublePendulum "Controlled inverse double pendulum"
  extends Modelica.Icons.Example;
  extends Controller.Templates.SimpleStateSpaceControl(
    redeclare Controller.Examples.Components.InverseDoublePendulum2 plant(
      additionalMeasurableOutputs=true,
      m_trolley=1,
      n=6,
      l=6,
      length=1,
      cartDisturbance=true,
      bodyDisturbance=true,
      phi2_start=0,
      m_load=1,
      phi1_start=1.5707963267949),
    preFilter(
      matrixName="M_pa",
      matrixOnFile=true,
      fileName=DataDir + "inverseDoublePendulumController.mat"),
    feedbackMatrix(
      matrixOnFile=true,
      matrixName="K_pa",
      fileName=DataDir + "inverseDoublePendulumController.mat"),
    sampleClock(sampleTime=0.003, blockType=Modelica_LinearSystems2.Controller.Types.BlockType.Continuous));

  Modelica.Blocks.Sources.Pulse pulse(
    offset=0,
    startTime=1,
    period=20,
    width=50,
    amplitude=10)
              annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Components.AccelerationLimiter accelerationLimiter(
    v_limit=20,
    velocityLimitation=false,
    withDelay2=false,
    a_limit=4)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Noise noise(
    firstSeed={43,123,162},
    blockType=Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.Discrete,
    y_min=-0.05,
    y_max=0.05,
    sampleFactor=50)
             annotation (Placement(transformation(extent={{0,60},{20,80}})));

  Noise noise1(
    y_min=-0.5,
    y_max=0.5,
    blockType=Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.Discrete,
    sampleFactor=50)
    annotation (Placement(transformation(extent={{0,30},{20,50}})));

equation
  connect(accelerationLimiter.u, pulse.y) annotation (Line(
      points={{-82,0},{-89,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(accelerationLimiter.s, preFilter.u[1]) annotation (Line(
      points={{-59,6},{-50,6},{-50,0},{-42,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(noise1.y, plant.dist) annotation (Line(
      points={{21,40},{86,40},{86,12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(noise.y, plant.dist2) annotation (Line(
      points={{21,70},{94,70},{94,12}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-120,-100},{120,
            100}}), graphics),
    experiment(
      StopTime=40,
      NumberOfIntervals=2000,
      Tolerance=1e-005),
    experimentSetupOutput,
    Documentation(info="<html>
<p>
This example shows a control system with constant state feedback.
The system model of a crane trolley system is taken from [1]. The
feedback matrix and the pre filter can be loaded from MATLAB files. By default, this files
are generated by call of Modelica_LinearSystems2.Examples.StateSpace.craneController.
</p>

<h4><a name=\"References\">References</a></h4>
<pre>
  [1] F&ouml;llinger, O. \"Regelungstechnik\", H&uuml;thig-Verlag
</pre>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}})));
end InverseDoublePendulum;
