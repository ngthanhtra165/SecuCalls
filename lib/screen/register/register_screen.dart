import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/common/appbar.dart';
import 'package:secucalls/common/button.dart';
import 'package:secucalls/common/text_field.dart';
import 'package:secucalls/constant/design_size.dart';
import 'package:secucalls/screen/register/register_screen_def.dart';
import 'package:secucalls/utils/validate.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void tapOnBackButton() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }

  void tapOnRegisterButton() {
    print('move to register');
    //Navigator.of(context).pushNamed('/Register');
    final isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      _formKey.currentState?.save();
      ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')));
      // wait server response
      return;
    }
  }

  void tapOnForgetPasswordButton() {
    print('move to forget password');
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
          appBar: CustomAppBar(
            icon: Icons.arrow_back_ios_rounded,
            title: title_appbar,
            onPressed: tapOnBackButton,
          ),
          body: SizedBox(
            height: screenHeight - keyboardHeight,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomForm(
                    onPressed: tapOnRegisterButton,
                    form: _formKey,
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
        ),
      ),
    );
  }
}

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    required this.onPressed,
    required this.form,
  });
  final GlobalKey<FormState> form;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: left_margin_form.w, right: left_margin_form.w),
      child: Form(
        key: form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: top_margin_form.h,
            ),
            CustomTextField(
                icon: Icons.account_box_outlined,
                hintText: hint_text_last_name,
                validator: (text) => validateName(text)),
            SizedBox(
              height: space_between_text_fields.h,
            ),
            CustomTextField(
              icon: Icons.account_box_outlined,
              hintText: hint_text_first_name,
              validator: (text) => validateName(text),
            ),
            SizedBox(
              height: space_between_text_fields.h,
            ),
            CustomTextField(
              icon: Icons.phone,
              hintText: hint_text_phone,
              validator: (text) => validatePhoneNumber(text),
            ),
            SizedBox(
              height: space_between_text_fields.h,
            ),
            CustomTextField(
              icon: Icons.lock_outline,
              hintText: hint_text_password,
              validator: (text) => validatePassword(text),
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
      ),
    );
  }
}
