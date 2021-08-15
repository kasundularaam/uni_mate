class DataProviders {
  static Uri authUrl({required String email, required String password}) {
    return Uri.parse(
        "http://critssl.com/nsbm_attendence/api/auth.php?userName=$email&password=$password");
  }

  static Uri markAttendenceUrl(
      {required String longitude,
      required String latitude,
      required String userId,
      required String scheduleId}) {
    return Uri.parse(
        "http://critssl.com/nsbm_attendence/api/markAttendence.php?longitude=$longitude&latitude=$latitude&user=$userId&schedule=$scheduleId");
  }

  static Uri schedulesUrl({required String batch, required String time}) {
    return Uri.parse(
        "http://critssl.com/nsbm_attendence/api/schedules.php?batch=$batch&time=$time");
  }
}
