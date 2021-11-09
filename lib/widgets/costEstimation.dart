double fuel = 146;
double estimateCost(double distance, double milage, bool ac) {
  if (ac) {
    return (distance * fuel) / (milage - 2);
  } else {
    return (distance * fuel) / milage;
  }
}

double modelAdjustment(int milage, int year) {
  if (year >= 2017) {
    return milage.toDouble();
  } else if (year >= 2012 && year < 2017) {
    return milage.toDouble() - 1;
  } else if (year >= 2007 && year < 2012) {
    return milage.toDouble() - 1.5;
  } else if (year >= 2003 && year < 2007) {
    return milage.toDouble() - 2;
  } else {
    return milage.toDouble() - 2.5;
  }
}

// engineType = 1 non-hybrid
// engineType = 2 hybrid
// engineType = 3 Bike
int getMilage(int engineType, int cc) {
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
  } else if (engineType == 2) {
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

double verifyMilage(int milage, int engineType, int cc, int year) {
  double expected = modelAdjustment(getMilage(engineType, cc), year);

  if ((milage - expected).abs() > 2) {
    return expected;
  } else {
    return milage.toDouble();
  }
}
