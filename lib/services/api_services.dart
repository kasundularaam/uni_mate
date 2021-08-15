import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:uni_mate/model/post_mrk_atndnc.dart';
import 'package:uni_mate/model/response_auth_s.dart';
import 'package:uni_mate/model/response_mrk_atndnc.dart';
import 'package:uni_mate/model/response_schedule.dart';
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
      print(email);
      print(password);
      try {
        final http.Response response = await http
            .get(DataProviders.authUrl(email: email, password: password));
        if (response.statusCode == 200) {
          print(response.body);
          ResponseAuthS responseAuthS = responseAuthSFromJson(response.body);
          ResponseUser responseUser = responseUserFromJson(response.body);
          if (responseAuthS.success || responseUser.success) {
            UserData userData = UserData(
              userId: responseUser.id,
              userName: responseUser.name,
              batch: responseUser.batch,
              degree: responseUser.degree,
            );
            await LocalServices.addUserDataSharedPref(userData: userData);
          } else {
            throw "Wrong user name or password!";
          }
        } else {
          throw "${response.statusCode} error";
        }
      } catch (e) {
        throw "Wrong user name or password!";
      }
    } else {
      throw "some feilds are empty";
    }
  }

  static List<ResponseSchedule> parseSchedules(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ResponseSchedule>(
          (json) => ResponseSchedule.fromJson(json),
        )
        .toList();
  }

  static Future<List<ResponseSchedule>> getSchedules(
      {required String batch}) async {
    try {
      DateTime now = DateTime.now();
      DateFormat format = DateFormat("HH:mm:ss");
      String formattedTime = format.format(now);
      http.Response response = await http
          .get(DataProviders.schedulesUrl(batch: batch, time: formattedTime));
      if (response.statusCode == 200) {
        List<ResponseSchedule> responseSchedules =
            parseSchedules(response.body);
        return responseSchedules;
      } else {
        throw "${response.statusCode} error";
      }
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
      final http.Response response = await http.get(
          DataProviders.markAttendenceUrl(
              longitude: longitude,
              latitude: latitude,
              userId: userId,
              scheduleId: scheduleId));
      if (response.statusCode == 200) {
        ResponseMrkAtndnc responseMrkAtndnc =
            responseMrkAtndncFromJson(response.body);
        bool succeed = responseMrkAtndnc.success;
        return succeed;
      } else {
        throw "${response.statusCode} error";
      }
    } catch (e) {
      throw e;
    }
  }
}
