// import 'dart:math';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
// import 'dart:math' as math;

// import 'dart:math' as math;
// import 'package:flutter/material.dart';

// void main() {
//   runApp(WaterAttenuationApp());
// }

// class WaterAttenuationApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: WaterAttenuationCalculator(),
//     );
//   }
// }

// class WaterAttenuationCalculator extends StatefulWidget {
//   @override
//   _WaterAttenuationCalculatorState createState() =>
//       _WaterAttenuationCalculatorState();
// }

// class _WaterAttenuationCalculatorState
//     extends State<WaterAttenuationCalculator> {
//   final TextEditingController fController = TextEditingController();
//   final TextEditingController pController = TextEditingController();
//   final TextEditingController tController = TextEditingController();
//   final TextEditingController rainAttenuationController =
//       TextEditingController();

//   String waterResult = '';
//   String oxygenResult = '';
//   String grhResult = '';
//   String khResult = '';
//   String ahResult = '';
//   String grvResult = '';
//   String kvResult = '';
//   String avResult = '';

//   void calculate() {
//     double f = double.parse(fController.text);
//     double p = double.parse(pController.text);
//     double T = double.parse(tController.text);
//     double R = double.parse(rainAttenuationController.text);

//     double waterAttenuation = calculateWaterAttenuation(f, p, T);
//     double oxygenAttenuation = calculateOxyAttenuation(f, p, T);
//     num GRH = calculateGRH(R, f);
//     num KH = calculateKH(f);
//     double AH = calculateAH(f);
//     num GRV = calculateGRV(R, f);
//     num KV = calculateKV(f);
//     double AV = calculateAV(f);

//     setState(() {
//       waterResult = 'Water Attenuation: $waterAttenuation dB/km';
//       oxygenResult = 'Oxygen Attenuation: $oxygenAttenuation dB/km';
//       grhResult = 'GRH: $GRH';
//       khResult = 'KH: $KH';
//       ahResult = 'AH: $AH';
//       grvResult = 'GRV: $GRV';
//       kvResult = 'KV: $KV';
//       avResult = 'AV: $AV';
//     });
//   }

//   double calculateOxyAttenuation(double f, double p, double T) {
//     List<List<double>> oxytab = [
//       [50.474214, 0.975, 9.651, 6.690, 0.0, 2.566, 6.850],
//       [50.987745, 2.529, 8.653, 7.170, 0.0, 2.246, 6.800],
//       [51.503360, 6.193, 7.709, 7.640, 0.0, 1.947, 6.729],
//       [52.021429, 14.320, 6.819, 8.110, 0.0, 1.667, 6.640],
//       [52.542418, 31.240, 5.983, 8.580, 0.0, 1.388, 6.526],
//       [53.066934, 64.290, 5.201, 9.060, 0.0, 1.349, 6.206],
//       [53.595775, 124.600, 4.474, 9.550, 0.0, 2.227, 5.085],
//       [54.130025, 227.300, 3.800, 9.960, 0.0, 3.170, 3.750],
//       [54.671180, 389.700, 3.182, 10.370, 0.0, 3.558, 2.654],
//       [55.221384, 627.100, 2.618, 10.890, 0.0, 2.560, 2.952],
//       [55.783815, 945.300, 2.109, 11.340, 0.0, -1.172, 6.135],
//       [56.264774, 543.400, 0.014, 17.030, 0.0, 3.525, -0.978],
//       [56.363399, 1331.800, 1.654, 11.890, 0.0, -2.378, 6.547],
//       [56.968211, 1746.600, 1.255, 12.230, 0.0, -3.545, 6.451],
//       [57.612486, 2120.100, 0.910, 12.620, 0.0, -5.416, 6.056],
//       [58.323877, 2363.700, 0.621, 12.950, 0.0, -1.932, 0.436],
//       [58.446588, 1442.100, 0.083, 14.910, 0.0, 6.768, -1.273],
//       [59.164204, 2379.900, 0.387, 13.530, 0.0, -6.561, 2.309],
//       [59.590983, 2090.700, 0.207, 14.080, 0.0, 6.957, -0.776],
//       [60.306056, 2103.400, 0.207, 14.150, 0.0, -6.395, 0.699],
//       [60.434778, 2438.000, 0.386, 13.390, 0.0, 6.342, -2.825],
//       [61.150562, 2479.500, 0.621, 12.920, 0.0, 1.014, -0.584],
//       [61.800158, 2275.900, 0.910, 12.630, 0.0, 5.014, -6.619],
//       [62.411220, 1915.400, 1.255, 12.170, 0.0, 3.029, -6.759],
//       [62.486253, 1503.000, 0.083, 15.130, 0.0, -4.499, 0.844],
//       [62.997984, 1490.200, 1.654, 11.740, 0.0, 1.856, -6.675],
//       [63.568526, 1078.000, 2.108, 11.340, 0.0, 0.658, -6.139],
//       [64.127775, 728.700, 2.617, 10.880, 0.0, -3.036, -2.895],
//       [64.678910, 461.300, 3.181, 10.380, 0.0, -3.968, -2.590],
//       [65.224078, 274.000, 3.800, 9.960, 0.0, -3.528, -3.680],
//       [65.764779, 153.000, 4.473, 9.550, 0.0, -2.548, -5.002],
//       [66.302096, 80.400, 5.200, 9.060, 0.0, -1.660, -6.091],
//       [66.836834, 39.800, 5.982, 8.580, 0.0, -1.680, -6.393],
//       [67.369601, 18.560, 6.818, 8.110, 0.0, -1.956, -6.475],
//       [67.900868, 8.172, 7.708, 7.640, 0.0, -2.216, -6.545],
//       [68.431006, 3.397, 8.652, 7.170, 0.0, -2.492, -6.600],
//       [68.960312, 1.334, 9.650, 6.690, 0.0, -2.773, -6.650],
//       [118.750334, 940.300, 0.010, 16.640, 0.0, -0.439, 0.079],
//       [368.498246, 67.400, 0.048, 16.400, 0.0, 0.000, 0.000],
//       [424.763020, 637.700, 0.044, 16.400, 0.0, 0.000, 0.000],
//       [487.249273, 237.400, 0.049, 16.000, 0.0, 0.000, 0.000],
//       [715.392902, 98.100, 0.145, 16.000, 0.0, 0.000, 0.000],
//       [773.839490, 572.300, 0.141, 16.200, 0.0, 0.000, 0.000],
//       [834.145546, 183.100, 0.145, 14.700, 0.0, 0.000, 0.000]
//     ];

//     List<double> fi = oxytab.map((row) => row[0]).toList();
//     List<double> a1 = oxytab.map((row) => row[1]).toList();
//     List<double> a2 = oxytab.map((row) => row[2]).toList();
//     List<double> a3 = oxytab.map((row) => row[3]).toList();
//     List<double> a4 = oxytab.map((row) => row[4]).toList();
//     List<double> a5 = oxytab.map((row) => row[5]).toList();
//     List<double> a6 = oxytab.map((row) => row[6]).toList();

//     double theta = 300 / T;
//     double rho = 7.5;
//     double e = rho * T / 216.7;
//     double p_tot = p + e;

//     List<double> Si_O2 = List.generate(a1.length, (i) {
//       return a1[i] * pow(10, -7) * p * pow(theta, 3) * exp(a2[i] * (1 - theta));
//     });

//     List<double> delta_f = List.generate(a3.length, (i) {
//       return a3[i] *
//           pow(10, -4) *
//           (p * pow(theta, 0.8 - a4[i]) + 1.1 * e * theta);
//     });

//     delta_f =
//         delta_f.map((df) => sqrt(pow(df, 2) + 2.25 * pow(10, -6))).toList();

//     List<double> delta = List.generate(a5.length, (i) {
//       return (a5[i] + a6[i] * theta) * pow(10, -4) * p_tot * pow(theta, 0.8);
//     });

//     List<double> Fi_O2 = List.generate(fi.length, (i) {
//       double fiVal = fi[i];
//       double df = delta_f[i];
//       double d = delta[i];
//       return (f / fiVal) *
//           ((df - d * (fiVal - f)) / (pow(fiVal - f, 2) + pow(df, 2)) +
//               (df - d * (fiVal + f)) / (pow(fiVal + f, 2) + pow(df, 2)));
//     });

//     double d = 5.6 * pow(10, -4) * p_tot * pow(theta, 0.8);

//     double ND = (f * p * pow(theta, 2)) *
//         ((6.14 * pow(10, -5) / (d * (1 + pow(f / d, 2)))) +
//             (1.4 * pow(10, -12) * p * pow(theta, 1.5)) /
//                 (1 + 1.9 * pow(10, -5) * pow(f, 1.5)));

//     double Ni_O2 = List.generate(Si_O2.length, (i) {
//           return Si_O2[i] * Fi_O2[i];
//         }).reduce((a, b) => a + b) +
//         ND;

//     double GO = Ni_O2 * 0.1820 * 30;

//     return GO;
//   }

//   double calculateWaterAttenuation(double f, double p, double T) {
//     List<List<double>> watvaptab = [
//       [22.235080, 0.1130, 2.143, 28.11, 0.69, 4.800, 1.00],
//       [67.803960, 0.0012, 8.735, 28.58, 0.69, 4.930, 0.82],
//       [119.995940, 0.0008, 8.356, 29.48, 0.70, 4.780, 0.79],
//       [183.310091, 2.4200, 0.668, 30.50, 0.64, 5.300, 0.85],
//       [321.225644, 0.0483, 6.181, 23.03, 0.67, 4.690, 0.54],
//       [325.152919, 1.4990, 1.540, 27.83, 0.68, 4.850, 0.74],
//       [336.222601, 0.0011, 9.829, 26.93, 0.69, 4.740, 0.61],
//       [380.197372, 11.5200, 1.048, 28.73, 0.54, 5.380, 0.89],
//       [390.134508, 0.0046, 7.350, 21.52, 0.63, 4.810, 0.55],
//       [437.346667, 0.0650, 5.050, 18.45, 0.60, 4.230, 0.48],
//       [439.150812, 0.9218, 3.596, 21.00, 0.63, 4.290, 0.52],
//       [443.018295, 0.1976, 5.050, 18.60, 0.60, 4.230, 0.50],
//       [448.001075, 10.3200, 1.405, 26.32, 0.66, 4.840, 0.67],
//       [470.888947, 0.3297, 3.599, 21.52, 0.66, 4.570, 0.65],
//       [474.689127, 1.2620, 2.381, 23.55, 0.65, 4.650, 0.64],
//       [488.491133, 0.2520, 2.853, 26.02, 0.69, 5.040, 0.72],
//       [503.568532, 0.0390, 6.733, 16.12, 0.61, 3.980, 0.43],
//       [504.482692, 0.0130, 6.733, 16.12, 0.61, 4.010, 0.45],
//       [547.676440, 9.7010, 0.114, 26.00, 0.70, 4.500, 1.00],
//       [552.020960, 14.7700, 0.114, 26.00, 0.70, 4.500, 1.00],
//       [556.936002, 487.4000, 0.159, 32.10, 0.69, 4.110, 1.00],
//       [620.700807, 5.0120, 2.200, 24.38, 0.71, 4.680, 0.68],
//       [645.866155, 0.0713, 8.580, 18.00, 0.60, 4.000, 0.50],
//       [658.005280, 0.3022, 7.820, 32.10, 0.69, 4.140, 1.00],
//       [752.033227, 239.6000, 0.396, 30.60, 0.68, 4.090, 0.84],
//       [841.053973, 0.0140, 8.180, 15.90, 0.33, 5.760, 0.45],
//       [859.962313, 0.1472, 7.989, 30.60, 0.68, 4.090, 0.84],
//       [899.306675, 0.0605, 7.917, 29.85, 0.68, 4.530, 0.90],
//       [902.616173, 0.0426, 8.432, 28.65, 0.70, 5.100, 0.95],
//       [906.207325, 0.1876, 5.111, 24.08, 0.70, 4.700, 0.53],
//       [916.171582, 8.3400, 1.442, 26.70, 0.70, 4.780, 0.78],
//       [923.118427, 0.0869, 10.220, 29.00, 0.70, 5.000, 0.80],
//       [970.315022, 8.9720, 1.920, 25.50, 0.64, 4.940, 0.67],
//       [987.926764, 132.1000, 0.258, 29.85, 0.68, 4.550, 0.90],
//       [1780.000000, 22300.0000, 0.952, 176.20, 0.50, 30.500, 5.00]
//     ];

//     List<double> fi = watvaptab.map((row) => row[0]).toList();
//     List<double> b1 = watvaptab.map((row) => row[1]).toList();
//     List<double> b2 = watvaptab.map((row) => row[2]).toList();
//     List<double> b3 = watvaptab.map((row) => row[3]).toList();
//     List<double> b4 = watvaptab.map((row) => row[4]).toList();
//     List<double> b5 = watvaptab.map((row) => row[5]).toList();
//     List<double> b6 = watvaptab.map((row) => row[6]).toList();

//     double vd1 = 7.5;
//     double e = (vd1 * T) / 216.7;
//     double theta = 300 / T;
//     double pe = p + e;

//     List<double> Si_vapor = List.generate(b1.length, (i) {
//       return b1[i] *
//           pow(10, -1) *
//           e *
//           pow(theta, 3.5) *
//           exp(b2[i] * (1 - theta));
//     });

//     List<double> delta_f = List.generate(b3.length, (i) {
//       return b3[i] *
//           pow(10, -4) *
//           (pe * pow(theta, b4[i]) + b5[i] * e * pow(theta, b6[i]));
//     });

//     delta_f = delta_f.map((df) {
//       return 0.535 * df +
//           sqrt(0.217 * pow(df, 2) +
//               (2.1316 * pow(10, -12) * pow(fi[delta_f.indexOf(df)], 2)) /
//                   theta);
//     }).toList();

//     List<double> Fi_vapor = List.generate(fi.length, (i) {
//       return (f / fi[i]) *
//           ((delta_f[i] - 0 * (fi[i] - f)) /
//                   (pow(fi[i] - f, 2) + pow(delta_f[i], 2)) +
//               (delta_f[i] - 0 * (fi[i] + f)) /
//                   (pow(fi[i] + f, 2) + pow(delta_f[i], 2)));
//     });

//     double Ni_vapor = List.generate(Si_vapor.length, (i) {
//       return Si_vapor[i] * Fi_vapor[i];
//     }).reduce((a, b) => a + b);

//     double Gw = Ni_vapor * 0.1820 * 30;

//     return Gw;
//   }

//   num calculateKH(double f) {
//     List<double> akh = [-5.33980, -0.35351, -0.23789, -0.94158];
//     List<double> bkh = [-0.10008, 1.26970, 0.86036, 0.64552];
//     List<double> ckh = [1.13098, 0.45400, 0.15354, 0.16817];

//     double mkh = -0.18961;
//     double ckhConst = 0.71147;

//     List<double> KHValues = [];

//     for (int i = 0; i < 4; i++) {
//       double KHi = akh[i] *
//           math.exp(-(math.pow((math.log(f) / math.ln10 - bkh[i]) / ckh[i], 2)));
//       KHValues.add(KHi);
//     }

//     double sumKH = KHValues.reduce((a, b) => a + b);
//     double KHS = sumKH + mkh * math.log(f) / math.ln10 + ckhConst;
//     num KH = math.pow(10, KHS);

//     return KH;
//   }

//   double calculateAH(double f) {
//     List<double> aah = [-0.14318, 0.29591, 0.32177, -5.37610, 16.1721];
//     List<double> bah = [1.82442, 0.77564, 0.63773, -0.96230, -3.29980];
//     List<double> cah = [-0.55187, 0.19822, 0.13164, 1.47828, 3.43990];

//     double mah = 0.67849;
//     double cahConst = -1.95537;

//     List<double> AHValues = [];

//     for (int i = 0; i < 5; i++) {
//       double AHi = aah[i] *
//           math.exp(-(math.pow((math.log(f) / math.ln10 - bah[i]) / cah[i], 2)));
//       AHValues.add(AHi);
//     }

//     double AH = AHValues.reduce((a, b) => a + b) +
//         mah * math.log(f) / math.ln10 +
//         cahConst;

//     return AH;
//   }

//   num calculateGRH(double R, double f) {
//     num KH = calculateKH(f);
//     double AH = calculateAH(f);
//     num GRH = KH * math.pow(R, AH);

//     return GRH;
//   }

//   num calculateKV(double f) {
//     List<double> akv = [-3.80595, -3.44965, -0.39902, 0.50167];
//     List<double> bkv = [0.56934, -0.22911, 0.73042, 1.07319];
//     List<double> ckv = [0.81061, 0.51059, 0.11899, 0.27195];

//     double mkv = -0.16398;
//     double ckvConst = 0.63297;

//     List<double> KVValues = [];

//     for (int i = 0; i < 4; i++) {
//       double KVi = akv[i] *
//           math.exp(-(math.pow((math.log(f) / math.ln10 - bkv[i]) / ckv[i], 2)));
//       KVValues.add(KVi);
//     }

//     double sumKV = KVValues.reduce((a, b) => a + b);
//     double KVS = sumKV + mkv * math.log(f) / math.ln10 + ckvConst;
//     num KV = math.pow(10, KVS);

//     return KV;
//   }

//   double calculateAV(double f) {
//     List<double> aav = [-0.07771, 0.56727, -0.20238, -48.2991, 48.5833];
//     List<double> bav = [2.33840, 0.95545, 1.14520, 0.791669, 0.791459];
//     List<double> cav = [-0.76284, 0.54039, 0.26809, 0.116226, 0.116479];

//     double mav = -0.053739;
//     double cavConst = 0.83433;

//     List<double> AVValues = [];

//     for (int i = 0; i < 5; i++) {
//       double AVi = aav[i] *
//           math.exp(-(math.pow((math.log(f) / math.ln10 - bav[i]) / cav[i], 2)));
//       AVValues.add(AVi);
//     }

//     double AV = AVValues.reduce((a, b) => a + b) +
//         mav * math.log(f) / math.ln10 +
//         cavConst;

//     return AV;
//   }

//   num calculateGRV(double R, double f) {
//     num KV = calculateKV(f);
//     double AV = calculateAV(f);
//     num GRV = KV * math.pow(R, AV);

//     return GRV;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Water Attenuation Calculator'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             TextField(
//               controller: fController,
//               decoration: InputDecoration(labelText: 'Frequency (f)'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: pController,
//               decoration: InputDecoration(labelText: 'Pressure (p)'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: tController,
//               decoration: InputDecoration(labelText: 'Temperature (T)'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: rainAttenuationController,
//               decoration: InputDecoration(labelText: 'Rain Attenuation (R)'),
//               keyboardType: TextInputType.number,
//             ),
//             ElevatedButton(
//               onPressed: calculate,
//               child: Text('Calculate'),
//             ),
//             SizedBox(height: 20.0),
//             Text(waterResult),
//             Text(oxygenResult),
//             Text(khResult),
//             Text(ahResult),
//             Text(grhResult),
//             Text(kvResult),
//             Text(avResult),
//             Text(grvResult),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:math';

// void main() {
//   double f = 30; // frequency in GHz
//   double distance = 1; // distance in km
//   double attenuation = calculateWaterAttenuation(f, distance);

//         double r = 2.0;  // Example range
//  // Example distance

//   String result = calculateGRH(f, r, d);
//   print("GRH: $result dB");
//   print(
//       'The oxygen attenuation for frequency $f GHz and distance $distance km is ${attenuation.toStringAsFixed(4)} dB');
// }

// List<List<double>> watvaptab = [
//   [22.235080, 0.1079, 2.144, 26.38, 0.76, 5.087, 1.00],
//   [67.803960, 0.0011, 8.732, 28.58, 0.69, 4.930, 0.82],
//   [119.995940, 0.0007, 8.353, 29.48, 0.70, 4.780, 0.79],
//   [183.310087, 2.2730, 0.668, 29.06, 0.77, 5.022, 0.85],
//   [321.225630, 0.0470, 6.179, 24.04, 0.67, 4.398, 0.54],
//   [325.152888, 1.5140, 1.541, 28.23, 0.64, 4.893, 0.74],
//   [336.227764, 0.0010, 9.825, 26.93, 0.69, 4.740, 0.61],
//   [380.197353, 11.670, 1.048, 28.11, 0.54, 5.063, 0.89],
//   [390.134508, 0.0045, 7.347, 21.52, 0.63, 4.810, 0.55],
//   [437.346667, 0.0632, 5.048, 18.45, 0.60, 4.230, 0.48],
//   [439.150807, 0.9098, 3.595, 20.07, 0.63, 4.483, 0.52],
//   [443.018343, 0.1920, 5.048, 15.55, 0.60, 5.083, 0.50],
//   [448.001085, 10.410, 1.405, 25.64, 0.66, 5.028, 0.67],
//   [470.888999, 0.3254, 3.597, 21.34, 0.66, 4.506, 0.65],
//   [474.689092, 1.2600, 2.379, 23.20, 0.65, 4.804, 0.64],
//   [488.490108, 0.2529, 2.852, 25.86, 0.69, 5.201, 0.72],
//   [503.568532, 0.0372, 6.731, 16.12, 0.61, 3.980, 0.43],
//   [504.482692, 0.0124, 6.731, 16.12, 0.61, 4.010, 0.45],
//   [547.676440, 0.9785, 0.158, 26.00, 0.70, 4.500, 1.00],
//   [552.020960, 0.1840, 0.158, 26.00, 0.70, 4.500, 1.00],
//   [556.935985, 497.000, 0.159, 30.86, 0.69, 4.552, 1.00],
//   [620.700807, 5.0150, 2.391, 24.38, 0.71, 4.856, 0.68],
//   [645.766085, 0.0067, 8.633, 18.00, 0.60, 4.000, 0.50],
//   [658.005280, 0.2732, 7.816, 32.10, 0.69, 4.140, 1.00],
//   [752.033113, 243.400, 0.396, 30.86, 0.68, 4.352, 0.84],
//   [841.051732, 0.0134, 8.177, 15.90, 0.33, 5.760, 0.45],
//   [859.965698, 0.1325, 8.055, 30.60, 0.68, 4.090, 0.84],
//   [899.303175, 0.0547, 7.914, 29.85, 0.68, 4.530, 0.90],
//   [902.611085, 0.0386, 8.429, 28.65, 0.70, 5.100, 0.95],
//   [906.205957, 0.1836, 5.110, 24.08, 0.70, 4.700, 0.53],
//   [916.171582, 8.4000, 1.441, 26.73, 0.70, 5.150, 0.78],
//   [923.112692, 0.0079, 10.293, 29.00, 0.70, 5.000, 0.80],
//   [970.315022, 9.0090, 1.919, 25.50, 0.64, 4.940, 0.67],
//   [987.926764, 134.600, 0.257, 29.85, 0.68, 4.550, 0.90],
//   [1780.000000, 17506.0, 0.952, 196.3, 2.00, 24.15, 5.00]
// ];

// double calculateWaterAttenuation(double f, double d) {
//   List<double> fi = watvaptab.map((row) => row[0]).toList();
//   List<double> b1 = watvaptab.map((row) => row[1]).toList();
//   List<double> b2 = watvaptab.map((row) => row[2]).toList();
//   List<double> b3 = watvaptab.map((row) => row[3]).toList();
//   List<double> b4 = watvaptab.map((row) => row[4]).toList();
//   List<double> b5 = watvaptab.map((row) => row[5]).toList();
//   List<double> b6 = watvaptab.map((row) => row[6]).toList();

//   double T = 298;
//   double vd1 = 7.5;
//   double e = (vd1 * T) / 216.7;
//   double theta = 300 / T;
//   double p = 1013.25;

//   List<double> Si_vapor = [];
//   List<double> delta_fo = [];
//   List<double> delta_f = [];
//   List<double> Fi_vapor = [];

//   for (int i = 0; i < fi.length; i++) {
//     Si_vapor.add(
//         b1[i] * pow(10, -1) * e * pow(theta, 3.5) * exp(b2[i] * (1 - theta)));
//     delta_fo.add(b3[i] *
//         pow(10, -4) *
//         (p * pow(theta, b4[i]) + b5[i] * e * pow(theta, b6[i])));
//     delta_f.add(0.535 * delta_fo[i] +
//         sqrt(0.217 * pow(delta_fo[i], 2) +
//             (2.1316 * pow(10, -12) * pow(fi[i], 2)) / theta));

//     Fi_vapor.add((f / fi[i]) *
//         ((delta_f[i] - 0 * (fi[i] - f)) /
//                 (pow((fi[i] - f), 2) + pow(delta_f[i], 2)) +
//             (delta_f[i] - 0 * (fi[i] + f)) /
//                 (pow((fi[i] + f), 2) + pow(delta_f[i], 2))));
//   }

//   double Ni_vapor = 0;
//   for (int i = 0; i < Si_vapor.length; i++) {
//     Ni_vapor += Si_vapor[i] * Fi_vapor[i];
//   }

//   double Gw = Ni_vapor * 0.1820 * f;
//   String GWF = Gw.toStringAsFixed(4);
//   double GWFDouble = double.parse(GWF);
//   GWFDouble = GWFDouble * d;

//   return GWFDouble;
// }

// String calculateGRH(double f, double r, double d) {
//   // Coefficients
//   final akh1 = -5.33980;
//   final akh2 = -0.35351;
//   final akh3 = -0.23789;
//   final akh4 = -0.94158;

//   final bkh1 = -0.10008;
//   final bkh2 = 1.26970;
//   final bkh3 = 0.86036;
//   final bkh4 = 0.64552;

//   final ckh1 = 1.13098;
//   final ckh2 = 0.45400;
//   final ckh3 = 0.15354;
//   final ckh4 = 0.16817;

//   final mkh = -0.18961;
//   final ckh = 0.71147;

//   final aah1 = -0.14318;
//   final aah2 = 0.29591;
//   final aah3 = 0.32177;
//   final aah4 = -5.37610;
//   final aah5 = 16.1721;

//   final bah1 = 1.82442;
//   final bah2 = 0.77564;
//   final bah3 = 0.63773;
//   final bah4 = -0.96230;
//   final bah5 = -3.29980;

//   final cah1 = -0.55187;
//   final cah2 = 0.19822;
//   final cah3 = 0.13164;
//   final cah4 = 1.47828;
//   final cah5 = 3.43990;

//   final mah = 0.67849;
//   final cah = -1.95537;

//   // Calculate KH
//   final logF = log(f) / ln10;
//   final KH1 = akh1 * exp(-pow((logF - bkh1) / ckh1, 2));
//   final KH2 = akh2 * exp(-pow((logF - bkh2) / ckh2, 2));
//   final KH3 = akh3 * exp(-pow((logF - bkh3) / ckh3, 2));
//   final KH4 = akh4 * exp(-pow((logF - bkh4) / ckh4, 2));
//   final KHS = KH1 + KH2 + KH3 + KH4 + mkh * logF + ckh;
//   final KH = pow(10, KHS);

//   // Calculate AH
//   final AH1 = aah1 * exp(-pow((logF - bah1) / cah1, 2));
//   final AH2 = aah2 * exp(-pow((logF - bah2) / cah2, 2));
//   final AH3 = aah3 * exp(-pow((logF - bah3) / cah3, 2));
//   final AH4 = aah4 * exp(-pow((logF - bah4) / cah4, 2));
//   final AH5 = aah5 * exp(-pow((logF - bah5) / cah5, 2));
//   final AH = AH1 + AH2 + AH3 + AH4 + AH5 + mah * logF + cah;

//   // Calculate GRH
//   final GRH = KH * pow(r, AH);
//   final GRHF = GRH.toStringAsFixed(3);

//   // Convert GRH from dB/km to dB
//   final GRFH = double.parse(GRHF) * d;

//   return GRFH.toStringAsFixed(3);
// }

import 'dart:math';

import 'package:nep/python.dart';

void main() {
  double f = 30; // frequency in GHz
  double d = 1; // distance in km
  double attenuation = calculateWaterAttenuation(f, d);

  double r = 22.0; // Example range
  String fsplValue = freeSpacePathLoss(f, d);
  String grv = calculateGRV(f, r, d);
  double wva = calculateWaterAttenuation(f, d);
  // Example distance

  String result = calculateGRH(f, r, d);
  print("GRH: $result dB");

  String result2 = calculateGRV(f, r, d);
  print("Rain attenuation(verticle polorization)(db): $result2 2dB");
  String result3 = freeSpacePathLoss(f, d);
  print("Free Space Path Loss: $result3 dB");
  String result4 =
      pathLossVer(double.parse(fsplValue), double.parse(grv), d, wva, 0.019);
  print("Path Loss: $result4 dB");
  print('water vapour attenuation(db) ${attenuation.toStringAsFixed(3)} dB');
}

List<List<double>> watvaptab = [
  [22.235080, 0.1079, 2.144, 26.38, 0.76, 5.087, 1.00],
  [67.803960, 0.0011, 8.732, 28.58, 0.69, 4.930, 0.82],
  [119.995940, 0.0007, 8.353, 29.48, 0.70, 4.780, 0.79],
  [183.310087, 2.2730, 0.668, 29.06, 0.77, 5.022, 0.85],
  [321.225630, 0.0470, 6.179, 24.04, 0.67, 4.398, 0.54],
  [325.152888, 1.5140, 1.541, 28.23, 0.64, 4.893, 0.74],
  [336.227764, 0.0010, 9.825, 26.93, 0.69, 4.740, 0.61],
  [380.197353, 11.670, 1.048, 28.11, 0.54, 5.063, 0.89],
  [390.134508, 0.0045, 7.347, 21.52, 0.63, 4.810, 0.55],
  [437.346667, 0.0632, 5.048, 18.45, 0.60, 4.230, 0.48],
  [439.150807, 0.9098, 3.595, 20.07, 0.63, 4.483, 0.52],
  [443.018343, 0.1920, 5.048, 15.55, 0.60, 5.083, 0.50],
  [448.001085, 10.410, 1.405, 25.64, 0.66, 5.028, 0.67],
  [470.888999, 0.3254, 3.597, 21.34, 0.66, 4.506, 0.65],
  [474.689092, 1.2600, 2.379, 23.20, 0.65, 4.804, 0.64],
  [488.490108, 0.2529, 2.852, 25.86, 0.69, 5.201, 0.72],
  [503.568532, 0.0372, 6.731, 16.12, 0.61, 3.980, 0.43],
  [504.482692, 0.0124, 6.731, 16.12, 0.61, 4.010, 0.45],
  [547.676440, 0.9785, 0.158, 26.00, 0.70, 4.500, 1.00],
  [552.020960, 0.1840, 0.158, 26.00, 0.70, 4.500, 1.00],
  [556.935985, 497.000, 0.159, 30.86, 0.69, 4.552, 1.00],
  [620.700807, 5.0150, 2.391, 24.38, 0.71, 4.856, 0.68],
  [645.766085, 0.0067, 8.633, 18.00, 0.60, 4.000, 0.50],
  [658.005280, 0.2732, 7.816, 32.10, 0.69, 4.140, 1.00],
  [752.033113, 243.400, 0.396, 30.86, 0.68, 4.352, 0.84],
  [841.051732, 0.0134, 8.177, 15.90, 0.33, 5.760, 0.45],
  [859.965698, 0.1325, 8.055, 30.60, 0.68, 4.090, 0.84],
  [899.303175, 0.0547, 7.914, 29.85, 0.68, 4.530, 0.90],
  [902.611085, 0.0386, 8.429, 28.65, 0.70, 5.100, 0.95],
  [906.205957, 0.1836, 5.110, 24.08, 0.70, 4.700, 0.53],
  [916.171582, 8.4000, 1.441, 26.73, 0.70, 5.150, 0.78],
  [923.112692, 0.0079, 10.293, 29.00, 0.70, 5.000, 0.80],
  [970.315022, 9.0090, 1.919, 25.50, 0.64, 4.940, 0.67],
  [987.926764, 134.600, 0.257, 29.85, 0.68, 4.550, 0.90],
  [1780.000000, 17506.0, 0.952, 196.3, 2.00, 24.15, 5.00]
];

double calculateWaterAttenuation(double f, double d) {
  List<double> fi = watvaptab.map((row) => row[0]).toList();
  List<double> b1 = watvaptab.map((row) => row[1]).toList();
  List<double> b2 = watvaptab.map((row) => row[2]).toList();
  List<double> b3 = watvaptab.map((row) => row[3]).toList();
  List<double> b4 = watvaptab.map((row) => row[4]).toList();
  List<double> b5 = watvaptab.map((row) => row[5]).toList();
  List<double> b6 = watvaptab.map((row) => row[6]).toList();

  double T = 298;
  double vd1 = 7.5;
  double e = (vd1 * T) / 216.7;
  double theta = 300 / T;
  double p = 1013.25;

  List<double> Si_vapor = [];
  List<double> delta_fo = [];
  List<double> delta_f = [];
  List<double> Fi_vapor = [];

  for (int i = 0; i < fi.length; i++) {
    Si_vapor.add(
        b1[i] * pow(10, -1) * e * pow(theta, 3.5) * exp(b2[i] * (1 - theta)));
    delta_fo.add(b3[i] *
        pow(10, -4) *
        (p * pow(theta, b4[i]) + b5[i] * e * pow(theta, b6[i])));
    delta_f.add(0.535 * delta_fo[i] +
        sqrt(0.217 * pow(delta_fo[i], 2) +
            (2.1316 * pow(10, -12) * pow(fi[i], 2)) / theta));

    Fi_vapor.add((f / fi[i]) *
        ((delta_f[i] - 0 * (fi[i] - f)) /
                (pow((fi[i] - f), 2) + pow(delta_f[i], 2)) +
            (delta_f[i] - 0 * (fi[i] + f)) /
                (pow((fi[i] + f), 2) + pow(delta_f[i], 2))));
  }

  double Ni_vapor = 0;
  for (int i = 0; i < Si_vapor.length; i++) {
    Ni_vapor += Si_vapor[i] * Fi_vapor[i];
  }

  double Gw = Ni_vapor * 0.1820 * f;
  String GWF = Gw.toStringAsFixed(4);
  double GWFDouble = double.parse(GWF);
  GWFDouble = GWFDouble * d;

  return GWFDouble;
}

String calculateGRH(double f, double r, double d) {
  // Coefficients
  final akh1 = -5.33980;
  final akh2 = -0.35351;
  final akh3 = -0.23789;
  final akh4 = -0.94158;

  final bkh1 = -0.10008;
  final bkh2 = 1.26970;
  final bkh3 = 0.86036;
  final bkh4 = 0.64552;

  final ckh1 = 1.13098;
  final ckh2 = 0.45400;
  final ckh3 = 0.15354;
  final ckh4 = 0.16817;

  final mkh = -0.18961;
  final ckh = 0.71147;

  final aah1 = -0.14318;
  final aah2 = 0.29591;
  final aah3 = 0.32177;
  final aah4 = -5.37610;
  final aah5 = 16.1721;

  final bah1 = 1.82442;
  final bah2 = 0.77564;
  final bah3 = 0.63773;
  final bah4 = -0.96230;
  final bah5 = -3.29980;

  final cah1 = -0.55187;
  final cah2 = 0.19822;
  final cah3 = 0.13164;
  final cah4 = 1.47828;
  final cah5 = 3.43990;

  final mah = 0.67849;
  final cah = -1.95537;

  // Calculate KH
  final logF = log(f) / ln10;
  final KH1 = akh1 * exp(-pow((logF - bkh1) / ckh1, 2));
  final KH2 = akh2 * exp(-pow((logF - bkh2) / ckh2, 2));
  final KH3 = akh3 * exp(-pow((logF - bkh3) / ckh3, 2));
  final KH4 = akh4 * exp(-pow((logF - bkh4) / ckh4, 2));
  final KHS = KH1 + KH2 + KH3 + KH4 + mkh * logF + ckh;
  final KH = pow(10, KHS);

  // Calculate AH
  final AH1 = aah1 * exp(-pow((logF - bah1) / cah1, 2));
  final AH2 = aah2 * exp(-pow((logF - bah2) / cah2, 2));
  final AH3 = aah3 * exp(-pow((logF - bah3) / cah3, 2));
  final AH4 = aah4 * exp(-pow((logF - bah4) / cah4, 2));
  final AH5 = aah5 * exp(-pow((logF - bah5) / cah5, 2));
  final AH = AH1 + AH2 + AH3 + AH4 + AH5 + mah * logF + cah;

  // Calculate GRH
  final GRH = KH * pow(r, AH);
  final GRHF = GRH.toStringAsFixed(3);

  // Convert GRH from dB/km to dB
  final GRFH = double.parse(GRHF) * d;

  return GRFH.toStringAsFixed(3);
}

String calculateGRV(double f, double r, double d) {
  // Coefficients for kV
  final akv1 = -3.80595;
  final akv2 = -3.44965;
  final akv3 = -0.39902;
  final akv4 = 0.50167;

  final bkv1 = 0.56934;
  final bkv2 = -0.22911;
  final bkv3 = 0.73042;
  final bkv4 = 1.07319;

  final ckv1 = 0.81061;
  final ckv2 = 0.51059;
  final ckv3 = 0.11899;
  final ckv4 = 0.27195;

  final mkv = -0.16398;
  final ckv = 0.63297;

  // Coefficients for alphaV
  final aav1 = -0.07771;
  final aav2 = 0.56727;
  final aav3 = -0.20238;
  final aav4 = -48.2991;
  final aav5 = 48.5833;

  final bav1 = 2.33840;
  final bav2 = 0.95545;
  final bav3 = 1.14520;
  final bav4 = 0.791669;
  final bav5 = 0.791459;

  final cav1 = -0.76284;
  final cav2 = 0.54039;
  final cav3 = 0.26809;
  final cav4 = 0.116226;
  final cav5 = 0.116479;

  final mav = -0.053739;
  final cav = 0.83433;

  // Calculate KV
  final logF = log(f) / ln10;
  final KV1 = akv1 * exp(-pow((logF - bkv1) / ckv1, 2));
  final KV2 = akv2 * exp(-pow((logF - bkv2) / ckv2, 2));
  final KV3 = akv3 * exp(-pow((logF - bkv3) / ckv3, 2));
  final KV4 = akv4 * exp(-pow((logF - bkv4) / ckv4, 2));
  final KVS = KV1 + KV2 + KV3 + KV4 + mkv * logF + ckv;
  final KV = pow(10, KVS);

  // Calculate AV
  final AV1 = aav1 * exp(-pow((logF - bav1) / cav1, 2));
  final AV2 = aav2 * exp(-pow((logF - bav2) / cav2, 2));
  final AV3 = aav3 * exp(-pow((logF - bav3) / cav3, 2));
  final AV4 = aav4 * exp(-pow((logF - bav4) / cav4, 2));
  final AV5 = aav5 * exp(-pow((logF - bav5) / cav5, 2));
  final AV = AV1 + AV2 + AV3 + AV4 + AV5 + mav * logF + cav;

  // Calculate GRV
  final GRV = KV * pow(r, AV);
  final GRVF = GRV.toStringAsFixed(3);

  // Convert GRV from dB/km to dB
  final GRFH = double.parse(GRVF) * d;

  return GRFH.toStringAsFixed(3);
}

// free space path losss

String freeSpacePathLoss(double f, double d) {
  // Calculate free space path loss (dB)
  final fspl = 20 * log(d) / ln10 + 20 * log(f) / ln10 + 92.45;
  final fsplr = fspl.toStringAsFixed(1);

  // Convert dB/km to dB
  final fsplValue = double.parse(fsplr) * d;

  return fsplValue.toStringAsFixed(1);
}

String pathLossVer(
    double fsplValue, double grv, double d, double wva, double gof) {
  // Calculate path loss (dB)
  final plv = fsplValue + grv * d + wva * d + gof * d;
  final plrv = plv.toStringAsFixed(1);

  return plrv;
}


String pathLossHzlt(double fspl, double grh, double d, double wva, double gof) {
  // Calculate path loss (dB)
  final plh = fspl + grh * d + wva * d + gof * d;
  
  // Format the result to one decimal place
  final plhFormatted = plh.toStringAsFixed(1);
  
  return plhFormatted;
}
