// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/common/button.dart';
import 'package:secucalls/common/drawer.dart';
import 'package:secucalls/common/text_field.dart';
import 'package:secucalls/constant/design_size.dart';
import 'package:secucalls/constant/style.dart';
import 'package:secucalls/screen/change_password/change_password_def.dart';
import 'package:secucalls/service/api_service.dart';
import 'package:secucalls/service/hive.dart';
import 'package:secucalls/utils/drawer.dart';
import 'package:secucalls/utils/overlay_manager.dart';
import 'package:secucalls/utils/common_function.dart';
import 'package:secucalls/utils/validate.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void tapOnSubmitButton() async {
    log('move to forget password');
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      _formKey.currentState?.save();

      // wait server response
      try {
        final oldPassword = oldPasswordController.text;
        final newPassword = newPasswordController.text;

        OverlayIndicatorManager.show(context);
        await Future.delayed(const Duration(seconds: 1), () async {
          await APIService.shared.changePassword(
            oldPassword,
            newPassword,
          );
          await clearBox("token");
          OverlayIndicatorManager.hide();
          Navigator.pushNamedAndRemoveUntil(
              context, '/Login', (route) => false);
          showSnackBar(context, text_change_password_success, 2);
        });
      } catch (e) {
        OverlayIndicatorManager.hide();
        showSnackBar(context, e.toString(), 4);
      }
      return;
    }
  }

  void tapOnChangePasswordButton() async {
    DrawerUtils.tapOnSameButton(_scaffoldKey);
  }

  void tapOnLogOutButton() async {
    DrawerUtils.tapOnLogOutButton(context);
  }

  void tapOnHomeButton() {
    DrawerUtils.tapOnHomeButton(context, _scaffoldKey);
  }

  void tapOnCallLogButton() {
    DrawerUtils.tapOnCallLogButton(context, _scaffoldKey);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: fullScreenPortraitSize,
      child: SafeArea(
        child: Scaffold(
          // You can design your splash screen UI here
          resizeToAvoidBottomInset: false,
          drawer: CustomDrawer(
            tapOnChangePasswordButton: tapOnChangePasswordButton,
            tapOnHomeButton: tapOnHomeButton,
            tapOnLogOutButton: tapOnLogOutButton,
            tapOnCallLogButton: tapOnCallLogButton,
          ),
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              title_appbar,
              textAlign: TextAlign.center,
              style: textBlack21Italic,
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: top_margin_title_text.h,
              ),
              const TextTitle(),
              SizedBox(
                height: top_margin_form_new_password.h,
              ),
              CustomForm(
                onPressed: tapOnSubmitButton,
                formKey: _formKey,
                oldPasswordController: oldPasswordController,
                newPasswordController: newPasswordController,
                confirmPasswordController: confirmPasswordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomForm extends StatefulWidget {
  const CustomForm({
    super.key,
    required this.onPressed,
    required this.formKey,
    required this.oldPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  final VoidCallback onPressed;
  final GlobalKey<FormState> formKey;
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: EdgeInsets.only(
          left: left_margin_form.w,
          right: left_margin_form.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextField(
              icon: null,
              hintText: hint_text_old_password,
              controller: widget.oldPasswordController,
              validator: (text) => validatePassword(text),
              isPassword: true,
            ),
            SizedBox(
              height: space_between_form_button.h,
            ),
            CustomTextField(
              icon: null,
              hintText: hint_text_new_password,
              controller: widget.newPasswordController,
              validator: (text) => validateChangePassword(
                  text, widget.oldPasswordController.text),
              isPassword: true,
            ),
            SizedBox(
              height: space_between_form_button.h,
            ),
            CustomTextField(
              icon: null,
              hintText: hint_text_confirm_password,
              controller: widget.confirmPasswordController,
              validator: (text) => validateSimilarPassword(
                  text, widget.newPasswordController.text,
                  oldPassword: widget.oldPasswordController.text),
              isPassword: true,
            ),
            SizedBox(
              height: space_between_form_button.h,
            ),
            CustomButton(
              text: text_button,
              onPressed: widget.onPressed,
            ),
          ],
        ),
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
