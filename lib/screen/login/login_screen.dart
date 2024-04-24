import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/common/button.dart';
import 'package:secucalls/common/text_field.dart';
import 'package:secucalls/constant/constants.dart';
import 'package:secucalls/constant/design_size.dart';
import 'package:secucalls/constant/style.dart';
import 'package:secucalls/screen/login/login_screen_def.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    // Close the keyboard when the widget is disposed
    FocusScope.of(context).unfocus();
    super.dispose();
  }

  void tapOnLoginButton() async {
    var name = phoneController.text;
    var email = passwordController.text;

    // Do something with the entered data
    print('Name: $name, Email: $email');
    Navigator.of(context).pushNamed('/Dashboard');
  }

  void tapOnRegisterButton() async {
    print('move to register');
    Navigator.of(context).pushNamed('/Register');
  }

  void tapOnForgetPasswordButton() async {
    print('move to register');
    Navigator.of(context).pushNamed('/ForgetPassword');
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return ScreenUtilInit(
      designSize: fullScreenPortraitSize,
      child: SafeArea(
        child: Scaffold(
          // You can design your splash screen UI here
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: screenHeight - keyboardHeight,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: top_margin_logo.h,
                  ),
                  const LogoAndCompanyName(),
                  SizedBox(
                    height: top_margin_form.h,
                  ),
                  CustomForm(
                    onTapButton: tapOnLoginButton,
                  ),
                  RegisterAndForgetPasswordButtons(
                    tapOnRegisterButton: tapOnRegisterButton,
                    tapOnForgetPasswordButton: tapOnForgetPasswordButton,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterAndForgetPasswordButtons extends StatelessWidget {
  const RegisterAndForgetPasswordButtons({
    super.key,
    required this.tapOnRegisterButton,
    required this.tapOnForgetPasswordButton,
  });

  final VoidCallback tapOnRegisterButton;
  final VoidCallback tapOnForgetPasswordButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: left_margin_form.w,
        top: top_margin_two_buttons.h,
        right: left_margin_form.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextButton(
            text: text_register_button,
            onPressed: tapOnRegisterButton,
            textAlign: TextAlign.left,
          ),
          CustomTextButton(
              text: text_forget_password,
              onPressed: tapOnForgetPasswordButton,
              textAlign: TextAlign.right)
        ],
      ),
    );
  }
}

class LogoAndCompanyName extends StatelessWidget {
  const LogoAndCompanyName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size_logo.height.h,
      padding: EdgeInsets.only(
        left: left_margin_logo.w,
        right: left_margin_logo.w,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              "lib/assets/logo.png",
              width: size_logo.width.w,
              height: size_logo.height.h,
            ),
          ),
          Positioned(
            top: 415.h,
            left: 124.w,
            right: 124.w,
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                name_company,
                textAlign: TextAlign.center,
                style: textBlack22Italic,
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Custom form widget containing multiple CustomTextField widgets
class CustomForm extends StatelessWidget {
  const CustomForm({super.key, required this.onTapButton});

  final VoidCallback onTapButton;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: left_margin_form.w,
        right: left_margin_form.w,
      ),
      child: Column(
        children: [
          CustomTextField(
            icon: Icons.alternate_email,
            hintText: text_mail,
            validator: (text) {
              return null;
            },
          ),
          SizedBox(
            height: space_between_text_field.h,
          ),
          CustomTextField(
            icon: Icons.lock_outline,
            hintText: text_password,
            validator: (Text) {
              return null;
            },
            isPassword: true,
          ),
          SizedBox(
            height: space_between_text_field.h,
          ),
          CustomButton(
            text: text_button,
            onPressed: onTapButton,
          ),
        ],
      ),
    );
  }
}
