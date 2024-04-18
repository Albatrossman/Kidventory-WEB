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

}
