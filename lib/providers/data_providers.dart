class DataProviders {
  static Uri authUrl() {
    return Uri.parse("http://critssl.com/nsbm_attendence/api/auth.php");
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
