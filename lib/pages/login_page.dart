import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uni_mate/routes/app_router.dart';
import 'package:uni_mate/services/api_services.dart';
import 'package:uni_mate/widgets/my_button.dart';
import 'package:uni_mate/widgets/my_loading_dialog.dart';
import 'package:uni_mate/widgets/my_text_feild.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password = "";

  Future<void> loginWithEmailPassword() async {
    try {
      MyLoadingDialog.showLoadingDialog(context: context, message: "Loging...");
      await APIServices.logInWithEmailPassword(
          email: _email, password: _password);
      MyLoadingDialog.closeLoading(context: context);
      Navigator.popAndPushNamed(
        context,
        AppRouter.home,
      );
    } catch (e) {
      MyLoadingDialog.closeLoading(context: context);
      final SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 30.h),
                MyTextField(
                  onChanged: (email) => _email = email,
                  onSubmitted: (email) {},
                  textInputAction: TextInputAction.next,
                  isPassword: false,
                  hintText: "email..",
                ),
                SizedBox(height: 3.h),
                MyTextField(
                  onChanged: (password) => _password = password,
                  onSubmitted: (password) {},
                  textInputAction: TextInputAction.next,
                  isPassword: true,
                  hintText: "password..",
                ),
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: MyButton(
                    btnText: "Login",
                    onPressed: () => loginWithEmailPassword(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
