import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_mate/pages/home_page.dart';
import 'package:uni_mate/pages/login_page.dart';

import '../exceptions/rout_exceptions.dart';

class AppRouter {
  static const String home = "/";
  static const String login = "/login";
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      default:
        throw const RouteException('Route not found!');
    }
  }
}
