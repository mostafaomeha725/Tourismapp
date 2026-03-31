class RegisterValidators {
  RegisterValidators._();

  static String? firstName(String? value) {
    final firstName = (value ?? '').trim();
    if (firstName.isEmpty) {
      return 'First name is required';
    }
    return null;
  }

  static String? lastName(String? value) {
    final lastName = (value ?? '').trim();
    if (lastName.isEmpty) {
      return 'Last name is required';
    }
    if (lastName.length < 2) {
      return 'Last name must be at least 2 characters';
    }
    return null;
  }

  static String? phone(String? value) {
    final phone = (value ?? '').trim();
    if (phone.isEmpty) {
      return 'Phone number is required';
    }
    return null;
  }

  static String? email(String? value) {
    final email = (value ?? '').trim();
    if (email.isEmpty) {
      return 'Email is required';
    }
    if (!email.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? password(String? value) {
    final password = value ?? '';
    if (password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    final confirm = value ?? '';
    if (confirm.isEmpty) {
      return 'Password confirmation is required';
    }
    if (confirm != password) {
      return 'Please make sure your passwords match';
    }
    return null;
  }
}
