import 'package:carpooling_app/models/vehicle.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isStudent = false.obs;
  var isEmployee = false.obs;

  var isBusiness = false.obs;

  void isStatus({required int typeID}) {
    // student : 1
    // empliyee: 2
    // business: 3
    if (typeID == 1) {
      isStudent.value = true;
      isEmployee.value = false;
      isBusiness.value = false;
    } else if (typeID == 2) {
      isStudent.value = false;
      isEmployee.value = true;
      isBusiness.value = false;
    } else {
      isStudent.value = false;
      isEmployee.value = false;
      isBusiness.value = true;
    }
  }
}
