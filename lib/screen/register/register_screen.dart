import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/common/appbar.dart';
import 'package:secucalls/common/button.dart';
import 'package:secucalls/common/text_field.dart';
import 'package:secucalls/constant/design_size.dart';
import 'package:secucalls/screen/register/register_screen_def.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
  }

  void tapOnBackButton() {
    Navigator.of(context).pop();
  }

  void tapOnRegisterButton() {
    print('move to register');
    //Navigator.of(context).pushNamed('/Register');
  }

  void tapOnForgetPasswordButton() {
    print('move to forget password');
    Navigator.of(context).pushNamed('/ForgetPassword');
  }

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: fullScreenPortraitSize,
      child: SafeArea(
        child: Scaffold(
          // You can design your splash screen UI here
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            icon: Icons.arrow_back_ios_rounded,
            title: title_appbar,
            onPressed: tapOnBackButton,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomForm(
                lastNameController: lastNameController,
                firstNameController: firstNameController,
                phoneController: phoneController,
                passwordController: passwordController,
                onPressed: tapOnRegisterButton,
              ),
              SizedBox(
                height: top_margin_forget_password_button.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: left_margin_forget_password_button.w,
                  right: left_margin_forget_password_button.w,
                ),
                child: CustomTextButton(
                    text: text_button_forget_password,
                    onPressed: tapOnForgetPasswordButton,
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    required this.lastNameController,
    required this.firstNameController,
    required this.phoneController,
    required this.passwordController,
    required this.onPressed,
  });

  final TextEditingController lastNameController;
  final TextEditingController firstNameController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: left_margin_form.w, right: left_margin_form.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: top_margin_form.h,
          ),
          CustomTextField(
            icon: Icons.account_box_outlined,
            hintText: hint_text_last_name,
            controller: lastNameController,
          ),
          SizedBox(
            height: space_between_text_fields.h,
          ),
          CustomTextField(
            icon: Icons.account_box_outlined,
            hintText: hint_text_first_name,
            controller: firstNameController,
          ),
          SizedBox(
            height: space_between_text_fields.h,
          ),
          CustomTextField(
            icon: Icons.phone,
            hintText: hint_text_phone,
            controller: phoneController,
          ),
          SizedBox(
            height: space_between_text_fields.h,
          ),
          CustomTextField(
            icon: Icons.lock_outline,
            hintText: hint_text_password,
            controller: passwordController,
          ),
          SizedBox(
            height: space_between_text_fields.h,
          ),
          CustomButton(
            text: text_button,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
