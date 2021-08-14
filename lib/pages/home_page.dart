import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_mate/model/lecture_model.dart';
import 'package:uni_mate/routes/app_router.dart';
import 'package:uni_mate/constants/shared_pref_keys.dart';
import 'package:uni_mate/model/user_data_model.dart';
import 'package:sizer/sizer.dart';
import 'package:uni_mate/services/api_services.dart';
import 'package:uni_mate/services/local_services.dart';
import 'package:uni_mate/widgets/lecture_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserData? currentUserData;
  static const String noUser = "noUser";
  Future<UserData> getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userIdAuthCheck = preferences.getString(SharedPrefKeys.userId);
    if (userIdAuthCheck != null) {
      UserData userData = await LocalServices.getUserDataSharedPref();
      return userData;
    } else {
      Navigator.popAndPushNamed(context, AppRouter.login);
      throw noUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.grey.withOpacity(0.1),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Home",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (bottomSheetContext) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: new Icon(Icons.person_rounded),
                                title: new Text(currentUserData != null
                                    ? currentUserData!.userName
                                    : ""),
                                onTap: () {
                                  Navigator.pop(bottomSheetContext);
                                },
                              ),
                              ListTile(
                                leading: new Icon(Icons.group_rounded),
                                title: new Text(currentUserData != null
                                    ? currentUserData!.batch
                                    : ""),
                                onTap: () {
                                  Navigator.pop(bottomSheetContext);
                                },
                              ),
                              ListTile(
                                leading: new Icon(Icons.school_rounded),
                                title: new Text(currentUserData != null
                                    ? currentUserData!.degree
                                    : ""),
                                onTap: () {
                                  Navigator.pop(bottomSheetContext);
                                },
                              ),
                              ListTile(
                                leading: new Icon(
                                  Icons.logout_rounded,
                                  color: Colors.orange,
                                ),
                                title: new Text(
                                  'Log out',
                                  style: TextStyle(
                                    color: Colors.orange,
                                  ),
                                ),
                                onTap: () async {
                                  await LocalServices
                                      .removeUserDataSharedPref();
                                  Navigator.pop(bottomSheetContext);
                                  Navigator.popAndPushNamed(
                                      context, AppRouter.login);
                                },
                              ),
                            ],
                          );
                        }),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/boy.jpg",
                        width: 10.w,
                        height: 10.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              FutureBuilder(
                future: getUserData(),
                builder: (BuildContext futureBuildercontext,
                    AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      if (snapshot.error.toString() != noUser) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                    } else if (snapshot.hasData) {
                      final UserData userData = snapshot.data;
                      currentUserData = userData;
                      return FutureBuilder(
                        future: APIServices.getSchedules(userData: userData),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text(snapshot.error.toString()));
                            } else if (snapshot.hasData) {
                              List<Lecture> lectures = snapshot.data;
                              return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.all(0),
                                shrinkWrap: true,
                                itemCount: lectures.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Lecture lecture = lectures[index];
                                  return LectureCard(
                                    lecture: lecture,
                                  );
                                },
                              );
                            }
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          );
                        },
                      );
                    }
                  }
                  return CircularProgressIndicator(
                    color: Colors.orange,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
