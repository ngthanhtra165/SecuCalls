String? validatePassword(String? password) {
  if (password == null || password.trim() == "") {
    return "Empty password!";
  }

  if (password.length < 8) {
    return "Password must contain more than 8 characters";
  }

  if (password.length > 16) {
    return "Password must contain less than 16 characters";
  }

  if (!password.contains(RegExp(r'[A-Z]'))) {
    return "Password must has uppercase";
  }

  if (!password.contains(RegExp(r'[0-9]'))) {
    return "Password must has digits";
  }

  if (!password.contains(RegExp(r'[a-z]'))) {
    return "Password must has lowercase";
  }

  if (!password.contains(RegExp(r'[#?!@$%^&*-]'))) {
    return "Password must has special characters";
  } else {
    return null;
  }
}

String? validatePhoneNumber(String? phone) {
  if (phone == null || phone.trim() == "") {
    return "Empty phone!";
  }

  RegExp phoneRegExp = RegExp(
    r'^(0|84)(2(0[3-9]|1[0-689]|2[0-25-9]|3[2-9]|4[0-9]|5[124-9]|6[0369]|7[0-7]|8[0-9]|9[012346789])|3[2-9]|5[25689]|7[06-9]|8[0-9]|9[012346789])([0-9]{7})$',
  );

  if (phoneRegExp.hasMatch(phone)) {
    return null;
  } else {
    return "Invalid phone!";
  }
}

String? validateName(String? name) {
  if (name == null || name.trim() == "") {
    return "Empty name!";
  } else {
    return null;
  }
}

String? validateEmail(String? email) {
  if (email == null || email.trim() == "") {
    return "Empty email!";
  }

  String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regExp = RegExp(emailPattern);
  return regExp.hasMatch(email) ? null : "Invalid email!";
}

String? validateOTP(String? otp) {
  if (otp == null || otp.trim() == "") {
    return "Empty OTP!";
  }

  String otpPattern = r'^\d{6}$';
  RegExp regExp = RegExp(otpPattern);
  return regExp.hasMatch(otp) ? null : "Invalid OTP!";
}

String? validateSimilarPassword(String? password, String? inputtedPassword) {
  if (password == null || password.trim() == "") {
    return "Please re-enter your password";
  }
  if (password != inputtedPassword) {
    return 'Passwords do not match';
    print('pass: $password, newpass: $inputtedPassword');
  }
  return null;
}
