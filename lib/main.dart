import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uni_mate/routes/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Uni Mate',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      );
    });
  }
}
