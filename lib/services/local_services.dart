import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_mate/constants/shared_pref_keys.dart';
import 'package:uni_mate/model/user_data_model.dart';

class LocalServices {
  static Future<void> addUserDataSharedPref(
      {required UserData userData}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(SharedPrefKeys.userId, userData.userId);
    preferences.setString(SharedPrefKeys.userName, userData.userName);
    preferences.setString(SharedPrefKeys.batchId, userData.batchId);
    preferences.setString(SharedPrefKeys.degreeId, userData.degreeId);
  }

  static Future<UserData> getUserDataSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserData userData = UserData(
        userId: preferences.getString(SharedPrefKeys.userId) ?? "",
        userName: preferences.getString(SharedPrefKeys.userName) ?? "",
        batchId: preferences.getString(SharedPrefKeys.batchId) ?? "",
        degreeId: preferences.getString(SharedPrefKeys.degreeId) ?? "");
    return userData;
  }

  static Future<void> removeUserDataSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(SharedPrefKeys.userId);
    preferences.remove(SharedPrefKeys.userName);
    preferences.remove(SharedPrefKeys.batchId);
    preferences.remove(SharedPrefKeys.degreeId);
  }
}
