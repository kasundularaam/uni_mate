import 'dart:io';
import 'dart:math';

import 'package:location/location.dart';
import 'package:uni_mate/model/lecture_model.dart';
import 'package:uni_mate/model/post_mrk_atndnc.dart';
import 'package:uni_mate/model/post_user.dart';
import 'package:uni_mate/model/response_mrk_atndnc.dart';
import 'package:uni_mate/model/user_data_model.dart';
import 'package:uni_mate/model/response_user.dart';
import 'package:uni_mate/providers/data_providers.dart';
import 'package:uni_mate/services/local_services.dart';
import 'package:http/http.dart' as http;
import 'package:uni_mate/services/my_location_service.dart';

class APIServices {
  static Future logInWithEmailPassword(
      {required String email, required String password}) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      PostUser postUser = PostUser(userName: email, password: password);
      try {
        final http.Response response = await http.post(DataProviders.authUrl(),
            headers: {HttpHeaders.contentTypeHeader: 'application/json'},
            body: postUserToJson(postUser));
        if (response.statusCode == 201) {
          ResponseUser responseUser = responseUserFromJson(response.body);
          UserData userData = UserData(
            userId: responseUser.id,
            userName: responseUser.name,
            batch: responseUser.batch,
            degree: responseUser.degree,
          );
          await LocalServices.addUserDataSharedPref(userData: userData);
        } else {
          throw "${response.statusCode} error";
        }
      } catch (e) {
        throw e;
      }
    } else {
      throw "some feilds are empty";
    }
  }

  static Future<List<Lecture>> getSchedules(
      {required UserData userData}) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      List<Lecture> lectures = [];
      Random random = new Random();
      int value = random.nextInt(6);
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

  static Future<bool> markAttendance({required String scheduleId}) async {
    try {
      LocationData locationData = await MyLocationService.getCurrentLocation();
      String longitude = "${locationData.longitude}";
      String latitude = "${locationData.latitude}";
      UserData userData = await LocalServices.getUserDataSharedPref();
      String userId = userData.userId;
      final http.Response response = await http.post(
        DataProviders.markAttendenceUrl(),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: postMrkAtndncToJson(
          PostMrkAtndnc(
            longitude: longitude,
            latitude: latitude,
            user: userId,
            schedule: scheduleId,
          ),
        ),
      );
      ResponseMrkAtndnc responseMrkAtndnc =
          responseMrkAtndncFromJson(response.body);
      bool succeed = responseMrkAtndnc.success;
      return succeed;
    } catch (e) {
      throw e;
    }
  }
}
