import 'dart:math';

import 'package:uni_mate/model/lecture_model.dart';
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

  static Future<List<Lecture>> getLectures({required UserData userData}) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      List<Lecture> lectures = [];
      Random random = new Random();
      int value = random.nextInt(6);
      print("THIS IS VALUE $value");
      int nowTime = DateTime.now().millisecondsSinceEpoch;
      for (var i = 0; i < value; i++) {
        lectures.add(
          Lecture(
              lectureId: "$i",
              lectureName: "Reinforcement learning",
              lecturerName: "Dr. Harsha Subasinghe",
              lectureTime: nowTime),
        );
      }
      return lectures;
    } catch (e) {
      throw e;
    }
  }
}
