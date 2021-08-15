import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_mate/constants/shared_pref_keys.dart';
import 'package:uni_mate/model/user_data_model.dart';

class LocalServices {
  static Future<void> addUserDataSharedPref(
      {required UserData userData}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(SharedPrefKeys.userId, userData.userId);
    preferences.setString(SharedPrefKeys.userName, userData.userName);
    preferences.setString(SharedPrefKeys.batchId, userData.batch);
    preferences.setString(SharedPrefKeys.degreeId, userData.degree);
  }

  static Future<UserData> getUserDataSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserData userData = UserData(
        userId: preferences.getString(SharedPrefKeys.userId) ?? "",
        userName: preferences.getString(SharedPrefKeys.userName) ?? "",
        batch: preferences.getString(SharedPrefKeys.batchId) ?? "",
        degree: preferences.getString(SharedPrefKeys.degreeId) ?? "");
    return userData;
  }

  static Future<void> removeUserDataSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(SharedPrefKeys.userId);
    preferences.remove(SharedPrefKeys.userName);
    preferences.remove(SharedPrefKeys.batchId);
    preferences.remove(SharedPrefKeys.degreeId);
  }

  static Future<void> markAttendance({required String scheduleId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(scheduleId, true);
  }

  static Future<bool> attendanceStatus({required String scheduleId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool attended = preferences.getBool(scheduleId) ?? false;
    return attended;
  }
}
