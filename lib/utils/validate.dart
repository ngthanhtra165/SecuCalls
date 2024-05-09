String? validatePassword(String? password) {
  if (password == null || password.trim() == "") {
    return "Vui lòng nhập mật khẩu!";
  }

  if (password.length < 8) {
    return "Mật khẩu phải có nhiều hơn 7 ký tự";
  }

  if (password.length > 16) {
    return "Mật khẩu phải có ít hơn 17 ký tự";
  }

  if (!password.contains(RegExp(r'[A-Z]'))) {
    return "Mật khẩu phải bao gồm kí tự in hoa";
  }

  if (!password.contains(RegExp(r'[0-9]'))) {
    return "Mật khẩu phải bao gồm kí tự số";
  }

  if (!password.contains(RegExp(r'[a-z]'))) {
    return "Mật khẩu phải bao gồm kí tự in thường";
  }

  if (!password.contains(RegExp(r'[#?!@$%^&*-]'))) {
    return "Mật khẩu phải bao gồm kí tự đặc biệt";
  } else {
    return null;
  }
}

String? validatePhoneNumber(String? phone) {
  if (phone == null || phone.trim() == "") {
    return "Vui lòng nhập số điện thoại!";
  }

  RegExp phoneRegExp = RegExp(
    r'^(0|84)(2(0[3-9]|1[0-689]|2[0-25-9]|3[2-9]|4[0-9]|5[124-9]|6[0369]|7[0-7]|8[0-9]|9[012346789])|3[2-9]|5[25689]|7[06-9]|8[0-9]|9[012346789])([0-9]{7})$',
  );

  if (phoneRegExp.hasMatch(phone)) {
    return null;
  } else {
    return "Số điện thoại không hợp lệ!";
  }
}

String? validateName(String? name) {
  if (name == null || name.trim() == "") {
    return "Vui lòng nhập tên!";
  } else {
    return null;
  }
}

String? validateEmail(String? email) {
  if (email == null || email.trim() == "") {
    return "Vui nhập lòng nhập email!";
  }

  String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regExp = RegExp(emailPattern);
  return regExp.hasMatch(email) ? null : "Email không hợp lệ!";
}

String? validateOTP(String? otp) {
  if (otp == null || otp.trim() == "") {
    return "Vui lòng nhập mã OTP!";
  }

  String otpPattern = r'^\d{6}$';
  RegExp regExp = RegExp(otpPattern);
  return regExp.hasMatch(otp) ? null : "OTP không hợp lệ!";
}

String? validateSimilarPassword(String? password, String? inputtedPassword,
    {String? oldPassword}) {
  print('pass: $password, newpass: $inputtedPassword');
  if (validatePassword(oldPassword) != null) {
    return null;
  }
  if (validatePassword(inputtedPassword) != null) {
    return null;
  }
  if (password == null || password.trim() == "") {
    return "Vui lòng nhập lại mật khẩu của bạn";
  }
  if (password != inputtedPassword) {
    return 'Mật khẩu không khớp';
  }
  return null;
}

String? validateChangePassword(String? newPassword, String? oldPassword) {
  if (validatePassword(oldPassword) != null) {
    return null;
  }
  if (oldPassword == newPassword) {
    return "Mật khẩu mới không được trùng với mật khẩu hiện tại";
  }

  return validatePassword(newPassword);
}
