class DataProviders {
  static Uri authUrl({required String email, required String password}) {
    return Uri.parse(
        "http://critssl.com/nsbm_attendence/api/auth.php?userName=$email&password=$password");
  }

  static Uri markAttendenceUrl() {
    return Uri.parse(
        "http://critssl.com/nsbm_attendence/api/markAttendence.php");
  }

  static Uri schedulesUrl({required String batch, required String time}) {
    return Uri.parse(
        "http://critssl.com/nsbm_attendence/api/schedules.php?batch=$batch&time=$time");
  }
}
