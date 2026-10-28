class Validators {
  Validators._();

  static String? required(String? value, String field) => 
      (value == null || value.isEmpty) ? '$field is required' : null;

  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Invalid email format';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}