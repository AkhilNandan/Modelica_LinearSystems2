within Modelica_LinearSystems2.WorkInProgress.Tests.care;
function care15 "Example 15  from Benner benchmarks"
  extends Modelica.Icons.Function;
  import Modelica_LinearSystems2.Math.Matrices;
  input String outputFile = "";

protected
  Integer N=10;
  Integer n=2*N - 1;
  Real A[n,n];
  Real A11[2,2]=[-1,0; 1,0];
  Real A12[2,2]=[0,0; -1,0];
  Real B[n,N]=zeros(n, N);
  Real R[N,N]=identity(N);
  Real C[N - 1,n]=zeros(N - 1, n);

//  Real Qtilde[N - 1,N - 1]=10*identity(N - 1);
  Real Q[n,n];
  Real G[n,n];
  Real Qr1[n,n];
  Real Qr2[n,n];
  Real Qr3[n,n];
  Real deltaQ1;
  Real deltaQ2;
  Real deltaQ3;
  Real H[2*n,2*n];
  Real condH;
  Real normH;
  Real condX1;
  Real normX1;
  Real condX2;
  Real normX2;
  Real condX3;
  Real normX3;

public
  output Real X1[n,n];
  output Real X2[n,n];
  output Real X3[n,n];
  output Real ku1;
  output Real ku2;
  output Real ku3;
algorithm

  for i in 1:N - 2 loop
    A[2*i - 1:2*i, 2*i - 1:2*i] := A11;
    A[2*i - 1:2*i, 2*i + 1:2*i + 2] := A12;
  end for;
  A[2*N - 3:2*N - 2, 2*N - 3:2*N - 2] := A11;
  A[2*N - 3:2*N - 2, n] := {0,-1};
  A[n, n] := -1;
  for i in 1:N loop
    B[2*i - 1, i] := 1;
  end for;

  for i in 1:N - 1 loop
    C[i, 2*i] := 1;
  end for;

  Q := 10*transpose(C)*C;
  G := B*transpose(B);
  H := [A,-G; -Q,-transpose(A)];
  condH := Modelica.Math.Matrices.conditionNumber(H);
  normH := Matrices.norm(H, 2);
  X1 := Matrices.care(A, B, R, Q, false);
  X2 := Matrices.care(A, B, R, Q, true);
  X3 := [1.4082559065178322e+000,     2.6676190896796159e+000,    -6.5821877192134037e-001,     1.0403124013014682e+000,    -2.4213305071508348e-001,     6.3973908750417130e-001,    -1.3823693339063511e-001,     4.4314597806254619e-001,    -9.4550040089693782e-002,     3.2016958489789538e-001,    -7.2001791061836087e-002,     2.3193432570454367e-001,    -5.9138156142420961e-002,     1.6238522686498319e-001,    -5.1533381176332015e-002,     1.0345269956755773e-001,    -4.7208569311630019e-002,     5.0403617291428171e-002,    -4.5235212708863534e-002;
  2.6676190896796159e+000,     7.6495166131912269e+000,    -1.6273066883781477e+000,     1.5927818788684047e+000,    -4.0057331379729999e-001,     8.5152714962393961e-001,    -1.9659310944162395e-001,     5.5113731416796208e-001,    -1.2297639316465336e-001,     3.8276339101187096e-001,    -8.8235259193352511e-002,     2.7048358127353234e-001,    -6.9549098839561146e-002,     1.8637984242782363e-001,    -5.8932527297422418e-002,     1.1756218375544031e-001,    -5.3049082276130421e-002,     5.6964417726470790e-002,    -5.0403617291430391e-002;
 -6.5821877192134037e-001,    -1.6273066883781477e+000,     1.8243416277240885e+000,     2.2670457758823135e+000,    -5.5432265459688956e-001,     8.4371929185984573e-001,    -1.9844615741414437e-001,     5.1676269433951449e-001,    -1.1568868436277591e-001,     3.5491071886919373e-001,    -8.1686405170275478e-002,     2.5062048605833698e-001,    -6.4397016095746384e-002,     1.7300179840712135e-001,    -5.4813344277716447e-002,     1.0933614458885377e-001,    -4.9560024573569200e-002,     5.3049082276127958e-002,    -4.7208569311627174e-002;
  1.0403124013014682e+000,     1.5927818788684047e+000,     2.2670457758823135e+000,     8.5010437628151578e+000,    -1.8238997978197693e+000,     2.1439191930363632e+000,    -5.2354970696195324e-001,     1.2342905406358069e+000,    -2.8482836863497241e-001,     8.2162089544150141e-001,    -1.9252549200421060e-001,     5.6914323343969642e-001,    -1.4716778649077566e-001,     3.8804576502897303e-001,    -1.2259818111568910e-001,     2.4334426015429533e-001,    -1.0933614458885396e-001,     1.1756218375543964e-001,    -1.0345269956755715e-001;
 -2.4213305071508348e-001,    -4.0057331379729999e-001,    -5.5432265459688956e-001,    -1.8238997978197693e+000,     1.8680285210250251e+000,     2.1440693827176647e+000,    -5.3177440556903477e-001,     7.5548403266649311e-001,    -1.8558252249472512e-001,     4.4721359549995687e-001,    -1.0808390939668928e-001,     2.9597819157177063e-001,    -7.7361593305573073e-002,     1.9757140378220453e-001,    -6.2423659492983979e-002,     1.2259818111569062e-001,    -5.4813344277716183e-002,     5.8932527297423709e-002,    -5.1533381176330897e-002;
  6.3973908750417130e-001,     8.5152714962393961e-001,     8.4371929185984573e-001,     2.1439191930363632e+000,     2.1440693827176647e+000,     8.8838071538270462e+000,    -1.9121350570131288e+000,     2.4144027743098979e+000,    -5.9309880580151031e-001,     1.4206703830636349e+000,    -3.4376089593239723e-001,     9.3918307919693822e-001,    -2.4557457428033913e-001,     6.2610765116617340e-001,    -1.9757140378220456e-001,     3.8804576502897542e-001,    -1.7300179840712107e-001,     1.8637984242782429e-001,    -1.6238522686498102e-001;
 -1.3823693339063511e-001,    -1.9659310944162395e-001,    -1.9844615741414437e-001,    -5.2354970696195324e-001,    -5.3177440556903477e-001,    -1.9121350570131288e+000,     1.8808921559444487e+000,     2.0745202838781052e+000,    -5.2416963060294719e-001,     6.9655150536906829e-001,    -1.8125771063002102e-001,     3.9416451322382728e-001,    -1.0611055279392437e-001,     2.4557457428034329e-001,    -7.7361593305573809e-002,     1.4716778649077725e-001,    -6.4397016095748355e-002,     6.9549098839562368e-002,    -5.9138156142419532e-002;
  4.4314597806254619e-001,     5.5113731416796208e-001,     5.1676269433951449e-001,     1.2342905406358069e+000,     7.5548403266649311e-001,     2.4144027743098979e+000,     2.0745202838781052e+000,     9.0701869962548631e+000,    -1.9710675843105483e+000,     2.5319649580653412e+000,    -6.4614788807763779e-001,     1.4776348007901072e+000,    -3.9416451322382506e-001,     9.3918307919694666e-001,    -2.9597819157177285e-001,     5.6914323343969908e-001,    -2.5062048605833365e-001,     2.7048358127354011e-001,    -2.3193432570454176e-001;
 -9.4550040089693782e-002,    -1.2297639316465336e-001,    -1.1568868436277591e-001,    -2.8482836863497241e-001,    -1.8558252249472512e-001,    -5.9309880580151031e-001,    -5.2416963060294719e-001,    -1.9710675843105483e+000,     1.8852169678091515e+000,     2.0214712016019787e+000,    -5.2219627400018265e-001,     6.4614788807764112e-001,    -1.8125771063002138e-001,     3.4376089593239728e-001,    -1.0808390939668934e-001,     1.9252549200421426e-001,    -8.1686405170278073e-002,     8.8235259193352858e-002,    -7.2001791061837433e-002;
  3.2016958489789538e-001,     3.8276339101187096e-001,     3.5491071886919373e-001,     8.2162089544150141e-001,     4.4721359549995687e-001,     1.4206703830636349e+000,     6.9655150536906829e-001,     2.5319649580653412e+000,     2.0214712016019787e+000,     9.1271514139813448e+000,    -2.0214712016019751e+000,     2.5319649580653465e+000,    -6.9655150536906496e-001,     1.4206703830636469e+000,    -4.4721359549996020e-001,     8.2162089544150407e-001,    -3.5491071886919606e-001,     3.8276339101187495e-001,    -3.2016958489789654e-001;
 -7.2001791061836087e-002,    -8.8235259193352511e-002,    -8.1686405170275478e-002,    -1.9252549200421060e-001,    -1.0808390939668928e-001,    -3.4376089593239723e-001,    -1.8125771063002102e-001,    -6.4614788807763779e-001,    -5.2219627400018265e-001,    -2.0214712016019751e+000,     1.8852169678091517e+000,     1.9710675843105498e+000,    -5.2416963060294630e-001,     5.9309880580151564e-001,    -1.8558252249472756e-001,     2.8482836863497613e-001,    -1.1568868436277815e-001,     1.2297639316465223e-001,    -9.4550040089693546e-002;
  2.3193432570454367e-001,     2.7048358127353234e-001,     2.5062048605833698e-001,     5.6914323343969642e-001,     2.9597819157177063e-001,     9.3918307919693822e-001,     3.9416451322382728e-001,     1.4776348007901072e+000,     6.4614788807764112e-001,     2.5319649580653465e+000,     1.9710675843105498e+000,     9.0701869962548720e+000,    -2.0745202838781021e+000,     2.4144027743099121e+000,    -7.5548403266649689e-001,     1.2342905406358144e+000,    -5.1676269433951971e-001,     5.5113731416796430e-001,    -4.4314597806254674e-001;
 -5.9138156142420961e-002,    -6.9549098839561146e-002,    -6.4397016095746384e-002,    -1.4716778649077566e-001,    -7.7361593305573073e-002,    -2.4557457428033913e-001,    -1.0611055279392437e-001,    -3.9416451322382506e-001,    -1.8125771063002138e-001,    -6.9655150536906496e-001,    -5.2416963060294630e-001,    -2.0745202838781021e+000,     1.8808921559444463e+000,     1.9121350570131264e+000,    -5.3177440556903433e-001,     5.2354970696195180e-001,    -1.9844615741414337e-001,     1.9659310944162223e-001,    -1.3823693339063431e-001;
  1.6238522686498319e-001,     1.8637984242782363e-001,     1.7300179840712135e-001,     3.8804576502897303e-001,     1.9757140378220453e-001,     6.2610765116617340e-001,     2.4557457428034329e-001,     9.3918307919694666e-001,     3.4376089593239728e-001,     1.4206703830636469e+000,     5.9309880580151564e-001,     2.4144027743099121e+000,     1.9121350570131264e+000,     8.8838071538270533e+000,    -2.1440693827176691e+000,     2.1439191930363739e+000,    -8.4371929185984795e-001,     8.5152714962394327e-001,    -6.3973908750416852e-001;
 -5.1533381176332015e-002,    -5.8932527297422418e-002,    -5.4813344277716447e-002,    -1.2259818111568910e-001,    -6.2423659492983979e-002,    -1.9757140378220456e-001,    -7.7361593305573809e-002,    -2.9597819157177285e-001,    -1.0808390939668934e-001,    -4.4721359549996020e-001,    -1.8558252249472756e-001,    -7.5548403266649689e-001,    -5.3177440556903433e-001,    -2.1440693827176691e+000,     1.8680285210250318e+000,     1.8238997978197702e+000,    -5.5432265459689178e-001,     4.0057331379729610e-001,    -2.4213305071508179e-001;
  1.0345269956755773e-001,     1.1756218375544031e-001,     1.0933614458885377e-001,     2.4334426015429533e-001,     1.2259818111569062e-001,     3.8804576502897542e-001,     1.4716778649077725e-001,     5.6914323343969908e-001,     1.9252549200421426e-001,     8.2162089544150407e-001,     2.8482836863497613e-001,     1.2342905406358144e+000,     5.2354970696195180e-001,     2.1439191930363739e+000,     1.8238997978197702e+000,     8.5010437628151774e+000,    -2.2670457758823197e+000,     1.5927818788684029e+000,    -1.0403124013014655e+000;
 -4.7208569311630019e-002,    -5.3049082276130421e-002,    -4.9560024573569200e-002,    -1.0933614458885396e-001,    -5.4813344277716183e-002,    -1.7300179840712107e-001,    -6.4397016095748355e-002,    -2.5062048605833365e-001,    -8.1686405170278073e-002,    -3.5491071886919606e-001,    -1.1568868436277815e-001,    -5.1676269433951971e-001,    -1.9844615741414337e-001,    -8.4371929185984795e-001,    -5.5432265459689178e-001,    -2.2670457758823197e+000,     1.8243416277240905e+000,     1.6273066883781486e+000,    -6.5821877192133904e-001;
  5.0403617291428171e-002,     5.6964417726470790e-002,     5.3049082276127958e-002,     1.1756218375543964e-001,     5.8932527297423709e-002,     1.8637984242782429e-001,     6.9549098839562368e-002,     2.7048358127354011e-001,     8.8235259193352858e-002,     3.8276339101187495e-001,     1.2297639316465223e-001,     5.5113731416796430e-001,     1.9659310944162223e-001,     8.5152714962394327e-001,     4.0057331379729610e-001,     1.5927818788684029e+000,     1.6273066883781486e+000,     7.6495166131912367e+000,    -2.6676190896796150e+000;
 -4.5235212708863534e-002,    -5.0403617291430391e-002,    -4.7208569311627174e-002,    -1.0345269956755715e-001,    -5.1533381176330897e-002,    -1.6238522686498102e-001,    -5.9138156142419532e-002,    -2.3193432570454176e-001,    -7.2001791061837433e-002,    -3.2016958489789654e-001,    -9.4550040089693546e-002,    -4.4314597806254674e-001,    -1.3823693339063431e-001,    -6.3973908750416852e-001,    -2.4213305071508179e-001,    -1.0403124013014655e+000,    -6.5821877192133904e-001,    -2.6676190896796150e+000,     1.4082559065178297e+000];

  ku1:=Modelica_LinearSystems2.Math.Matrices.Internal.k_care_u(A, Q, G, X1);
  ku2:=Modelica_LinearSystems2.Math.Matrices.Internal.k_care_u(A, Q, G, X2);
  ku3:=Modelica_LinearSystems2.Math.Matrices.Internal.k_care_u(A, Q, G, X3);
  Qr1 := X1*G*X1-transpose(A)*X1-X1*A;
  Qr2 := X2*G*X2-transpose(A)*X2-X2*A;
  Qr3 := X3*G*X3-transpose(A)*X3-X3*A;
  deltaQ1 := Modelica.Math.Matrices.norm(Q-Qr1)/Modelica.Math.Matrices.norm(Q);
  deltaQ2 := Modelica.Math.Matrices.norm(Q-Qr2)/Modelica.Math.Matrices.norm(Q);
  deltaQ3 := Modelica.Math.Matrices.norm(Q-Qr3)/Modelica.Math.Matrices.norm(Q);

  condX1 := Modelica.Math.Matrices.conditionNumber(X1);
  normX1 := Matrices.norm(X1, 2);
  condX2 := Modelica.Math.Matrices.conditionNumber(X2);
  normX2 := Matrices.norm(X2, 2);
  condX3 := Modelica.Math.Matrices.conditionNumber(X3);
  normX3 := Matrices.norm(X3, 2);

  Modelica.Utilities.Streams.print("Solution X1 without subsequent Newton refinement",outputFile);
  Modelica.Utilities.Streams.print(Matrices.printMatrix(X1, 16, "X1"),outputFile);
  Modelica.Utilities.Streams.print("Solution X2 with subsequent Newton refinement",outputFile);
  Modelica.Utilities.Streams.print(Matrices.printMatrix(X2, 16, "X2"),outputFile);
  Modelica.Utilities.Streams.print("MATLAB solution X3",outputFile);
  Modelica.Utilities.Streams.print(Matrices.printMatrix(X3, 16, "X3"),outputFile);
  Modelica.Utilities.Streams.print("\n normH = " + String(normH),outputFile);
  Modelica.Utilities.Streams.print("\n condH = " + String(condH),outputFile);
  Modelica.Utilities.Streams.print("\n normX1 = " + String(normX1),outputFile);
  Modelica.Utilities.Streams.print("\n condX1 = " + String(condX1),outputFile);
  Modelica.Utilities.Streams.print("\n ku1 = " + String(ku1),outputFile);
  Modelica.Utilities.Streams.print("\n normX2 = " + String(normX2),outputFile);
  Modelica.Utilities.Streams.print("\n condX2 = " + String(condX2),outputFile);
  Modelica.Utilities.Streams.print("\n ku2 = " + String(ku2),outputFile);
  Modelica.Utilities.Streams.print("\n normX3 = " + String(normX3),outputFile);
  Modelica.Utilities.Streams.print("\n condX3 = " + String(condX3),outputFile);
  Modelica.Utilities.Streams.print("\n ku3 = " + String(ku3),outputFile);
  Modelica.Utilities.Streams.print("\n deltaQ1 = " + String(deltaQ1),outputFile);
  Modelica.Utilities.Streams.print("\n deltaQ2 = " + String(deltaQ2),outputFile);
  Modelica.Utilities.Streams.print("\n deltaQ3 = " + String(deltaQ3),outputFile);

end care15;
