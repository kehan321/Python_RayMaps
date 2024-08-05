import 'dart:math' as math;
import 'dart:math';
import 'dart:typed_data';




num calculateKH(double f) {
  List<double> akh = [-5.33980, -0.35351, -0.23789, -0.94158];
  List<double> bkh = [-0.10008, 1.26970, 0.86036, 0.64552];
  List<double> ckh = [1.13098, 0.45400, 0.15354, 0.16817];

  double mkh = -0.18961;
  double ckhConst = 0.71147;

  List<double> KHValues = [];

  for (int i = 0; i < 4; i++) {
    double KHi = akh[i] *
        math.exp(-(math.pow((math.log(f) / math.ln10 - bkh[i]) / ckh[i], 2)));
    KHValues.add(KHi);
  }

  double sumKH = KHValues.reduce((a, b) => a + b);
  double KHS = sumKH + mkh * math.log(f) / math.ln10 + ckhConst;
  num KH = math.pow(10, KHS);

  return KH;
}

double calculateAH(double f) {
  List<double> aah = [-0.14318, 0.29591, 0.32177, -5.37610, 16.1721];
  List<double> bah = [1.82442, 0.77564, 0.63773, -0.96230, -3.29980];
  List<double> cah = [-0.55187, 0.19822, 0.13164, 1.47828, 3.43990];

  double mah = 0.67849;
  double cahConst = -1.95537;

  List<double> AHValues = [];

  for (int i = 0; i < 5; i++) {
    double AHi = aah[i] *
        math.exp(-(math.pow((math.log(f) / math.ln10 - bah[i]) / cah[i], 2)));
    AHValues.add(AHi);
  }

  double AH = AHValues.reduce((a, b) => a + b) + mah * math.log(f) / math.ln10 + cahConst;

  return AH;
}


  num calculateGRH(double R, double f) {
    num KH = calculateKH(f);
    double AH = calculateAH(f);
    num GRH = KH * math.pow(R, AH);

    return GRH;
  }
num calculateKV(double f) {
  List<double> akv = [-3.80595, -3.44965, -0.39902, 0.50167];
  List<double> bkv = [0.56934, -0.22911, 0.73042, 1.07319];
  List<double> ckv = [0.81061, 0.51059, 0.11899, 0.27195];

  double mkv = -0.16398;
  double ckvConst = 0.63297;

  List<double> KVValues = [];

  for (int i = 0; i < 4; i++) {
    double KVi = akv[i] *
        math.exp(-(math.pow((math.log(f) / math.ln10 - bkv[i]) / ckv[i], 2)));
    KVValues.add(KVi);
  }

  double sumKV = KVValues.reduce((a, b) => a + b);
  double KVS = sumKV + mkv * math.log(f) / math.ln10 + ckvConst;
  num KV = math.pow(10, KVS);

  return KV;
}

double calculateAV(double f) {
  List<double> aav = [-0.07771, 0.56727, -0.20238, -48.2991, 48.5833];
  List<double> bav = [2.33840, 0.95545, 1.14520, 0.791669, 0.791459];
  List<double> cav = [-0.76284, 0.54039, 0.26809, 0.116226, 0.116479];

  double mav = -0.053739;
  double cavConst = 0.83433;

  List<double> AVValues = [];

  for (int i = 0; i < 5; i++) {
    double AVi = aav[i] *
        math.exp(-(math.pow((math.log(f) / math.ln10 - bav[i]) / cav[i], 2)));
    AVValues.add(AVi);
  }

  double AV = AVValues.reduce((a, b) => a + b) + mav * math.log(f) / math.ln10 + cavConst;

  return AV;
}
  num calculateGRV(double R, double f) {
    num KV = calculateKV(f);
    double AV = calculateAV(f);
    num GRV = KV * math.pow(R, AV);

    return GRV;
  }

double waterAttenuation(double f, double p, double T) {
  List<List<double>> watvaptab = [
    [22.235080, 0.1130, 2.143, 28.11, 0.69, 4.800, 1.00],
    [67.803960, 0.0012, 8.735, 28.58, 0.69, 4.930, 0.82],
    [119.995940, 0.0008, 8.356, 29.48, 0.70, 4.780, 0.79],
    [183.310091, 2.4200, 0.668, 30.50, 0.64, 5.300, 0.85],
    [321.225644, 0.0483, 6.181, 23.03, 0.67, 4.690, 0.54],
    [325.152919, 1.4990, 1.540, 27.83, 0.68, 4.850, 0.74],
    [336.222601, 0.0011, 9.829, 26.93, 0.69, 4.740, 0.61],
    [380.197372, 11.5200, 1.048, 28.73, 0.54, 5.380, 0.89],
    [390.134508, 0.0046, 7.350, 21.52, 0.63, 4.810, 0.55],
    [437.346667, 0.0650, 5.050, 18.45, 0.60, 4.230, 0.48],
    [439.150812, 0.9218, 3.596, 21.00, 0.63, 4.290, 0.52],
    [443.018295, 0.1976, 5.050, 18.60, 0.60, 4.230, 0.50],
    [448.001075, 10.3200, 1.405, 26.32, 0.66, 4.840, 0.67],
    [470.888947, 0.3297, 3.599, 21.52, 0.66, 4.570, 0.65],
    [474.689127, 1.2620, 2.381, 23.55, 0.65, 4.650, 0.64],
    [488.491133, 0.2520, 2.853, 26.02, 0.69, 5.040, 0.72],
    [503.568532, 0.0390, 6.733, 16.12, 0.61, 3.980, 0.43],
    [504.482692, 0.0130, 6.733, 16.12, 0.61, 4.010, 0.45],
    [547.676440, 9.7010, 0.114, 26.00, 0.70, 4.500, 1.00],
    [552.020960, 14.7700, 0.114, 26.00, 0.70, 4.500, 1.00],
    [556.936002, 487.4000, 0.159, 32.10, 0.69, 4.110, 1.00],
    [620.700807, 5.0120, 2.200, 24.38, 0.71, 4.680, 0.68],
    [645.866155, 0.0713, 8.580, 18.00, 0.60, 4.000, 0.50],
    [658.005280, 0.3022, 7.820, 32.10, 0.69, 4.140, 1.00],
    [752.033227, 239.6000, 0.396, 30.60, 0.68, 4.090, 0.84],
    [841.053973, 0.0140, 8.180, 15.90, 0.33, 5.760, 0.45],
    [859.962313, 0.1472, 7.989, 30.60, 0.68, 4.090, 0.84],
    [899.306675, 0.0605, 7.917, 29.85, 0.68, 4.530, 0.90],
    [902.616173, 0.0426, 8.432, 28.65, 0.70, 5.100, 0.95],
    [906.207325, 0.1876, 5.111, 24.08, 0.70, 4.700, 0.53],
    [916.171582, 8.3400, 1.442, 26.70, 0.70, 4.780, 0.78],
    [923.118427, 0.0869, 10.220, 29.00, 0.70, 5.000, 0.80],
    [970.315022, 8.9720, 1.920, 25.50, 0.64, 4.940, 0.67],
    [987.926764, 132.1000, 0.258, 29.85, 0.68, 4.550, 0.90],
    [1780.000000, 22300.0000, 0.952, 176.20, 0.50, 30.500, 5.00]
  ];

  double e = (7.5 * T) / 216.7;
  double theta = 300 / T;
  double pe = p + e;

  List<double> fi = watvaptab.map((row) => row[0]).toList();
  List<double> b1 = watvaptab.map((row) => row[1]).toList();
  List<double> b2 = watvaptab.map((row) => row[2]).toList();
  List<double> b3 = watvaptab.map((row) => row[3]).toList();
  List<double> b4 = watvaptab.map((row) => row[4]).toList();
  List<double> b5 = watvaptab.map((row) => row[5]).toList();
  List<double> b6 = watvaptab.map((row) => row[6]).toList();

  List<double> Si_vapor = List.generate(fi.length, (i) {
    return b1[i] * pow(10, -1) * e * pow(theta, 3.5) * exp(b2[i] * (1 - theta));
  });

  List<double> delta_f = List.generate(fi.length, (i) {
    return b3[i] * pow(10, -4) * (pe * pow(theta, b4[i]) + b5[i] * e * pow(theta, b6[i]));
  });

  delta_f = List.generate(delta_f.length, (i) {
    return 0.535 * delta_f[i] + sqrt(0.217 * pow(delta_f[i], 2) + (2.1316 * pow(10, -12) * pow(fi[i], 2)) / theta);
  });

  List<double> Fi_vapor = List.generate(fi.length, (i) {
    return (f / fi[i]) *
        ((delta_f[i] - 0 * (fi[i] - f)) / (pow((fi[i] - f), 2) + pow(delta_f[i], 2)) +
            (delta_f[i] - 0 * (fi[i] + f)) / (pow((fi[i] + f), 2) + pow(delta_f[i], 2)));
  });

  double Ni_vapor = 0;
  for (int i = 0; i < Si_vapor.length; i++) {
    Ni_vapor += Si_vapor[i] * Fi_vapor[i];
  }

  double Gw = Ni_vapor * 0.1820 * 30;
  return Gw;
}

double calculateOxyAttenuation(double f, double p, double T) {
  List<List<double>> oxytab = [
    [50.474214, 0.975, 9.651, 6.690, 0.0, 2.566, 6.850],
    [50.987745, 2.529, 8.653, 7.170, 0.0, 2.269, 6.800],
    [51.503360, 6.193, 7.709, 7.640, 0.0, 1.920, 6.729],
    [52.021429, 14.320, 6.819, 8.140, 0.0, 1.610, 6.640],
    [52.542418, 31.240, 5.983, 8.610, 0.0, 1.330, 6.526],
    [53.066934, 64.290, 5.201, 9.070, 0.0, 1.080, 6.400],
    [53.595775, 124.600, 4.474, 9.550, 0.0, 0.860, 6.239],
    [54.130025, 227.300, 3.800, 9.960, 0.0, 0.670, 6.069],
    [54.671180, 389.700, 3.182, 10.370, 0.0, 0.510, 5.879],
    [55.221384, 627.100, 2.618, 10.890, 0.0, 0.380, 5.669],
    [55.783824, 945.300, 2.109, 11.320, 0.0, 0.270, 5.449],
    [56.264774, 543.400, 0.014, 17.030, 0.0, 0.300, 3.690],
    [56.363399, 1331.000, 1.654, 0.0, 0.0, 0.160, 0.0],
    [56.968211, 1746.000, 0.001, 0.0, 0.0, 0.140, 0.0],
    [57.612486, 212.700, 0.048, 132.600, 0.0, 0.140, 2.630],
    [58.323877, 244.000, 0.044, 0.0, 0.0, 0.130, 0.0],
    [58.446588, 668.200, 0.038, 0.0, 0.0, 0.130, 0.0],
    [59.164204, 686.800, 0.033, 0.0, 0.0, 0.120, 0.0],
    [59.590977, 461.900, 0.029, 0.0, 0.0, 0.120, 0.0],
    [60.306056, 79.970, 0.008, 165.800, 0.0, 0.150, 4.260],
    [60.434777, 535.000, 0.026, 0.0, 0.0, 0.110, 0.0],
    [61.150562, 963.200, 0.023, 0.0, 0.0, 0.110, 0.0],
    [61.800158, 1246.000, 0.018, 0.0, 0.0, 0.100, 0.0],
    [62.411220, 1413.000, 0.014, 0.0, 0.0, 0.100, 0.0],
    [62.486253, 1015.000, 0.014, 0.0, 0.0, 0.100, 0.0],
    [62.997980, 83.760, 0.013, 178.000, 0.0, 0.150, 4.090],
    [63.568526, 498.400, 0.011, 0.0, 0.0, 0.100, 0.0],
    [64.127775, 1433.000, 0.010, 0.0, 0.0, 0.090, 0.0],
    [64.678910, 2075.000, 0.007, 0.0, 0.0, 0.090, 0.0],
    [65.224078, 2322.000, 0.006, 0.0, 0.0, 0.090, 0.0],
    [65.764779, 2461.000, 0.005, 0.0, 0.0, 0.090, 0.0],
    [66.302096, 2514.000, 0.003, 0.0, 0.0, 0.090, 0.0],
    [66.836834, 2479.000, 0.001, 0.0, 0.0, 0.090, 0.0],
    [67.369601, 0.152, 1.576, 139.200, 0.0, 0.170, 2.780],
    [67.803960, 0.063, 1.506, 141.700, 0.0, 0.170, 2.760]
  ];

  double theta = 300 / T;
  double pe = p + (7.5 * T) / 216.7;

  List<double> fi = oxytab.map((row) => row[0]).toList();
  List<double> b1 = oxytab.map((row) => row[1]).toList();
  List<double> b2 = oxytab.map((row) => row[2]).toList();
  List<double> b3 = oxytab.map((row) => row[3]).toList();
  List<double> b4 = oxytab.map((row) => row[4]).toList();
  List<double> b5 = oxytab.map((row) => row[5]).toList();
  List<double> b6 = oxytab.map((row) => row[6]).toList();

  List<double> Si_oxygen = List.generate(fi.length, (i) {
    return b1[i] * pow(10, -7) * p * pow(theta, 3) * exp(b2[i] * (1 - theta));
  });

  List<double> delta_f = List.generate(fi.length, (i) {
    return b3[i] * pow(10, -4) * (pe * pow(theta, b4[i]) + b5[i] * p * pow(theta, b6[i]));
  });

  delta_f = List.generate(delta_f.length, (i) {
    return 0.535 * delta_f[i] + sqrt(0.217 * pow(delta_f[i], 2) + (2.1316 * pow(10, -12) * pow(fi[i], 2)) / theta);
  });

  List<double> Fi_oxygen = List.generate(fi.length, (i) {
    return (f / fi[i]) *
        ((delta_f[i] - 0 * (fi[i] - f)) / (pow((fi[i] - f), 2) + pow(delta_f[i], 2)) +
            (delta_f[i] - 0 * (fi[i] + f)) / (pow((fi[i] + f), 2) + pow(delta_f[i], 2)));
  });

  double Ni_oxygen = 0;
  for (int i = 0; i < Si_oxygen.length; i++) {
    Ni_oxygen += Si_oxygen[i] * Fi_oxygen[i];
  }

  double Go = Ni_oxygen * 0.1820 * 30;
  return Go;
}
















// import 'package:flutter/material.dart';
// import 'dart:math';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: OxyAttenuationCalculator(),
//     );
//   }
// }

// class OxyAttenuationCalculator extends StatefulWidget {
//   @override
//   _OxyAttenuationCalculatorState createState() => _OxyAttenuationCalculatorState();
// }

// class _OxyAttenuationCalculatorState extends State<OxyAttenuationCalculator> {
//   final TextEditingController _fController = TextEditingController();
//   final TextEditingController _pController = TextEditingController();
//   final TextEditingController _tController = TextEditingController();
//   String _result = '';

// double calculateOxyAttenuation(double f, double p, double T) {
//   List<List<double>> oxytab = [
//     [50.474214, 0.975, 9.651, 6.690, 0.0, 2.566, 6.850],
//     [50.987745, 2.529, 8.653, 7.170, 0.0, 2.246, 6.800],
//     [51.503360, 6.193, 7.709, 7.640, 0.0, 1.947, 6.729],
//     [52.021429, 14.320, 6.819, 8.110, 0.0, 1.667, 6.640],
//     [52.542418, 31.240, 5.983, 8.580, 0.0, 1.388, 6.526],
//     [53.066934, 64.290, 5.201, 9.060, 0.0, 1.349, 6.206],
//     [53.595775, 124.600, 4.474, 9.550, 0.0, 2.227, 5.085],
//     [54.130025, 227.300, 3.800, 9.960, 0.0, 3.170, 3.750],
//     [54.671180, 389.700, 3.182, 10.370, 0.0, 3.558, 2.654],
//     [55.221384, 627.100, 2.618, 10.890, 0.0, 2.560, 2.952],
//     [55.783815, 945.300, 2.109, 11.340, 0.0, -1.172, 6.135],
//     [56.264774, 543.400, 0.014, 17.030, 0.0, 3.525, -0.978],
//     [56.363399, 1331.800, 1.654, 11.890, 0.0, -2.378, 6.547],
//     [56.968211, 1746.600, 1.255, 12.230, 0.0, -3.545, 6.451],
//     [57.612486, 2120.100, 0.910, 12.620, 0.0, -5.416, 6.056],
//     [58.323877, 2363.700, 0.621, 12.950, 0.0, -1.932, 0.436],
//     [58.446588, 1442.100, 0.083, 14.910, 0.0, 6.768, -1.273],
//     [59.164204, 2379.900, 0.387, 13.530, 0.0, -6.561, 2.309],
//     [59.590983, 2090.700, 0.207, 14.080, 0.0, 6.957, -0.776],
//     [60.306056, 2103.400, 0.207, 14.150, 0.0, -6.395, 0.699],
//     [60.434778, 2438.000, 0.386, 13.390, 0.0, 6.342, -2.825],
//     [61.150562, 2479.500, 0.621, 12.920, 0.0, 1.014, -0.584],
//     [61.800158, 2275.900, 0.910, 12.630, 0.0, 5.014, -6.619],
//     [62.411220, 1915.400, 1.255, 12.170, 0.0, 3.029, -6.759],
//     [62.486253, 1503.000, 0.083, 15.130, 0.0, -4.499, 0.844],
//     [62.997984, 1490.200, 1.654, 11.740, 0.0, 1.856, -6.675],
//     [63.568526, 1078.000, 2.108, 11.340, 0.0, 0.658, -6.139],
//     [64.127775, 728.700, 2.617, 10.880, 0.0, -3.036, -2.895],
//     [64.678910, 461.300, 3.181, 10.380, 0.0, -3.968, -2.590],
//     [65.224078, 274.000, 3.800, 9.960, 0.0, -3.528, -3.680],
//     [65.764779, 153.000, 4.473, 9.550, 0.0, -2.548, -5.002],
//     [66.302096, 80.400, 5.200, 9.060, 0.0, -1.660, -6.091],
//     [66.836834, 39.800, 5.982, 8.580, 0.0, -1.680, -6.393],
//     [67.369601, 18.560, 6.818, 8.110, 0.0, -1.956, -6.475],
//     [67.900868, 8.172, 7.708, 7.640, 0.0, -2.216, -6.545],
//     [68.431006, 3.397, 8.652, 7.170, 0.0, -2.492, -6.600],
//     [68.960312, 1.334, 9.650, 6.690, 0.0, -2.773, -6.650],
//     [118.750334, 940.300, 0.010, 16.640, 0.0, -0.439, 0.079],
//     [368.498246, 67.400, 0.048, 16.400, 0.0, 0.000, 0.000],
//     [424.763020, 637.700, 0.044, 16.400, 0.0, 0.000, 0.000],
//     [487.249273, 237.400, 0.049, 16.000, 0.0, 0.000, 0.000],
//     [715.392902, 98.100, 0.145, 16.000, 0.0, 0.000, 0.000],
//     [773.839490, 572.300, 0.141, 16.200, 0.0, 0.000, 0.000],
//     [834.145546, 183.100, 0.145, 14.700, 0.0, 0.000, 0.000]
//   ];

//   List<double> fi = oxytab.map((row) => row[0]).toList();
//   List<double> a1 = oxytab.map((row) => row[1]).toList();
//   List<double> a2 = oxytab.map((row) => row[2]).toList();
//   List<double> a3 = oxytab.map((row) => row[3]).toList();
//   List<double> a4 = oxytab.map((row) => row[4]).toList();
//   List<double> a5 = oxytab.map((row) => row[5]).toList();
//   List<double> a6 = oxytab.map((row) => row[6]).toList();

//   double theta = 300 / T;
//   double rho = 7.5;
//   double e = rho * T / 216.7;
//   double p_tot = p + e;

//   List<double> Si_O2 = List.generate(a1.length, (i) {
//     return a1[i] * pow(10, -7) * p * pow(theta, 3) * exp(a2[i] * (1 - theta));
//   });

//   List<double> delta_f = List.generate(a3.length, (i) {
//     return a3[i] * pow(10, -4) * (p * pow(theta, 0.8 - a4[i]) + 1.1 * e * theta);
//   });

//   delta_f = delta_f.map((df) => sqrt(pow(df, 2) + 2.25 * pow(10, -6))).toList();

//   List<double> delta = List.generate(a5.length, (i) {
//     return (a5[i] + a6[i] * theta) * pow(10, -4) * p_tot * pow(theta, 0.8);
//   });

//   List<double> Fi_O2 = List.generate(fi.length, (i) {
//     double fiVal = fi[i];
//     double df = delta_f[i];
//     double d = delta[i];
//     return (f / fiVal) *
//         ((df - d * (fiVal - f)) / (pow(fiVal - f, 2) + pow(df, 2)) +
//             (df - d * (fiVal + f)) / (pow(fiVal + f, 2) + pow(df, 2)));
//   });

//   double d = 5.6 * pow(10, -4) * p_tot * pow(theta, 0.8);

//   double ND = (f * p * pow(theta, 2)) *
//       ((6.14 * pow(10, -5) / (d * (1 + pow(f / d, 2)))) +
//           (1.4 * pow(10, -12) * p * pow(theta, 1.5)) / (1 + 1.9 * pow(10, -5) * pow(f, 1.5)));

//   double Ni_O2 = List.generate(Si_O2.length, (i) {
//     return Si_O2[i] * Fi_O2[i];
//   }).reduce((a, b) => a + b) + ND;

//   double GO = Ni_O2 * 0.1820 * 30;

//   return GO;
// }
//   void _calculate() {
//     final double f = double.parse(_fController.text);
//     final double p = double.parse(_pController.text);
//     final double t = double.parse(_tController.text);
//     final result = calculateOxyAttenuation(f, p, t);

//     setState(() {
//       _result = result.toString();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Oxygen Attenuation Calculator'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _fController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Frequency (f)'),
//             ),
//             TextField(
//               controller: _pController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Pressure (p)'),
//             ),
//             TextField(
//               controller: _tController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Temperature (T)'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _calculate,
//               child: Text('Calculate'),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Oxygen Attenuation: $_result',
//               style: TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

