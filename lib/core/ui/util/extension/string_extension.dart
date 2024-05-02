extension StringExtension on String {
  
  bool isValidEmail() {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this);
  }
  
  bool hasSpecialChar() {
    final specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return specialCharRegex.hasMatch(this);
  }
  
  bool hasUppercase() {
    return contains(RegExp(r'[A-Z]'));
  }

  bool hasNumeric() {
    return contains(RegExp(r'[0-9]'));
  }

  bool isStrongForPassword() {
    return hasUppercase() && hasSpecialChar() && hasNumeric() && length > 6;
  }

  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

}
