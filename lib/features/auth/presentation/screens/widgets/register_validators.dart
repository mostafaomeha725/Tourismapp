class RegisterValidators {
  RegisterValidators._();

  static String? firstName(String? value, dynamic loc) {
    final firstName = (value ?? '').trim();
    if (firstName.isEmpty) {
      return loc.firstNameRequired;
    }
    return null;
  }

  static String? lastName(String? value, dynamic loc) {
    final lastName = (value ?? '').trim();
    if (lastName.isEmpty) {
      return loc.lastNameRequired;
    }
    if (lastName.length < 2) {
      return loc.lastNameMinLength;
    }
    return null;
  }

  static String? phone(String? value, dynamic loc) {
    final phone = (value ?? '').trim();
    if (phone.isEmpty) {
      return loc.phoneNumberRequired;
    }
    return null;
  }

  static String? email(String? value, dynamic loc) {
    final email = (value ?? '').trim();
    if (email.isEmpty) {
      return loc.emailIsRequired;
    }
    if (!email.contains('@')) {
      return loc.pleaseEnterValidEmail;
    }
    return null;
  }

  static String? password(String? value, dynamic loc) {
    final password = value ?? '';
    if (password.isEmpty) {
      return loc.passwordIsRequired;
    }
    if (password.length < 6) {
      return loc.passwordMinLengthSix;
    }
    return null;
  }

  static String? confirmPassword(String? value, String password, dynamic loc) {
    final confirm = value ?? '';
    if (confirm.isEmpty) {
      return loc.passwordConfirmationRequired;
    }
    if (confirm != password) {
      return loc.passwordsDoNotMatch;
    }
    return null;
  }
}
