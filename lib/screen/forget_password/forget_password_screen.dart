import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/common/appbar.dart';
import 'package:secucalls/common/button.dart';
import 'package:secucalls/common/text_field.dart';
import 'package:secucalls/constant/design_size.dart';
import 'package:secucalls/constant/style.dart';
import 'package:secucalls/screen/forget_password/forget_password_def.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  void initState() {
    super.initState();
  }

  void tapOnBackButton() {
    Navigator.of(context).pop();
  }

  void tapOnRegisterButton() {
    print('move to register');
    Navigator.of(context).pushNamed('/Register');
  }

  void tapOnForgetPasswordButton() {
    print('move to forget password');
    //Navigator.of(context).pushNamed('/ForgetPassword');
  }

  final TextEditingController phoneController = TextEditingController();

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
              SizedBox(
                height: top_margin_title_text.h,
              ),
              const TextTitle(),
              SizedBox(
                height: top_margin_form.h,
              ),
              CustomForm(
                phoneController: phoneController,
                onPressed: tapOnForgetPasswordButton,
              ),
              SizedBox(
                height: top_margin_register_button.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: left_margin_register_button.w,
                  right: left_margin_register_button.w,
                ),
                child: CustomTextButton(
                  text: text_register_button,
                  onPressed: tapOnRegisterButton,
                  textAlign: TextAlign.center,
                ),
              )
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
    required this.phoneController,
    required this.onPressed,
  });

  final TextEditingController phoneController;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: left_margin_form.w,
        right: left_margin_form.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextField(
            icon: Icons.phone,
            hintText: hint_text_phone,
            controller: phoneController,
          ),
          SizedBox(
            height: space_between_form_button.h,
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

class TextTitle extends StatelessWidget {
  const TextTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: left_margin_title_text.w,
        right: left_margin_title_text.w,
      ),
      child: const FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text_title,
          style: textGray21Italic,
        ),
      ),
    );
  }
}
