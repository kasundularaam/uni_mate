import 'dart:math';

import 'package:uni_mate/model/user_data_model.dart';
import 'package:uni_mate/services/local_services.dart';

class APIServices {
  static Future logInWithEmailPassword(
      {required String email, required String password}) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await Future.delayed(Duration(seconds: 3));
        Random random = new Random();
        int value = random.nextInt(3);
        if (value != 2) {
          UserData userData = UserData(
              userId: "200129001050",
              userName: "Kasun Dulara",
              batchId: "2025B",
              degreeId: "01");
          await LocalServices.addUserDataSharedPref(userData: userData);
        } else {
          throw "Something went wrong!";
        }
      } catch (e) {
        throw e;
      }
    } else {
      throw "some feilds are empty";
    }
  }
}
