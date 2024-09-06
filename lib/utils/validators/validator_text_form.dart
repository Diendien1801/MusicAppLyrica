class ValidatorTextForm {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    return null;
  }

  static String? validateUsername(String value) {
    if (value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  static String? validateInput(String value)
  {
    if (value.isEmpty) {
      return 'This field is required';
    }
    return null;
    
  }

  
}
