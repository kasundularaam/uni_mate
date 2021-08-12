import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_mate/model/lecture_model.dart';
import 'package:uni_mate/pages/home_page.dart';
import 'package:uni_mate/pages/login_page.dart';
import 'package:uni_mate/pages/mark_attendance_page.dart';

import '../exceptions/rout_exceptions.dart';

class AppRouter {
  static const String home = "/";
  static const String login = "/login";
  static const String markAttendancePage = "/markAttendancePage";
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case markAttendancePage:
        Lecture lecture = settings.arguments as Lecture;
        return MaterialPageRoute(
          builder: (_) => MarkAttendancePage(
            lecture: lecture,
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
