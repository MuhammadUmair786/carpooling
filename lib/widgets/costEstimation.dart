import 'package:carpooling_app/views/vehicle/vehicle.dart';

estimateCost(double distance, double milage, bool ac, double fuel, Vehicle vc) {
  if (ac) {
    return (distance * fuel) / (milage - 2);
  } else {
    return (distance * fuel) / milage;
  }
}

double modelAdjustment(double milage, double model) {
  if (model >= 2017) {
    return milage;
  } else if (model >= 2012 && model < 2017) {
    return milage - 1;
  } else if (model >= 2007 && model < 2012) {
    return milage - 1.5;
  } else if (model >= 2003 && model < 2007) {
    return milage - 2;
  } else {
    return milage - 2.5;
  }
}

// engineType = 1 non-hybrid
// engineType = 2 hybrid
// engineType = 3 Bike
double getMilage(double engineType, double cc) {
  if (engineType == 1) {
    if (cc == 800) {
      return 20;
    } else if (cc == 1000) {
      return 15;
    } else if (cc == 1300 || cc == 1500) {
      return 14;
    } else if (cc == 1600) {
      return 12;
    } else if (cc == 1800 || cc == 2000) {
      return 10;
    } else {
      return 7;
    }
  } else if (engineType == 1) {
    if (cc == 1500) {
      return 21;
    } else {
      return 19;
    }
  } else {
    if (cc > 100) {
      return 28;
    } else {
      return 35;
    }
  }
}

double verifyMilage(double milage, double engineType, double cc, double model) {
  double expected = modelAdjustment(getMilage(engineType, cc), model);

  if ((milage - expected).abs() > 2) {
    return expected;
  } else {
    return milage;
  }
}
