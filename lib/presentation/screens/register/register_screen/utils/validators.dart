class RegisterValidators {
  RegisterValidators._();

  // Validations
  static String? validateUsername(String value) {
    // Define your validation logic here.
    if (value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 4) {
      return 'Name must be at least 4 characters long';
    }
    // if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(value)) {
    //   return 'Enter a valid name Ex: jennifer95';
    // }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Enter a valid name without spaces Ex: Jennifer';
    }
    return null; // Return null if the input is valid.
  }

  static String? validatePhoneNumber(String value) {
    // Define your phone number validation logic here.
    if (value.isEmpty) {
      return 'Phone number is required';
    }
    // You can use regular expressions or other methods to validate phone numbers.
    // Here, we're checking if the input consists of 10 digits.
    if (!RegExp(r'^\d+(?:[-\s]?\d+)*$').hasMatch(value)) {
      return 'Invalid phone number.';
    }
    return null; // Return null if the input is valid.
  }

  static String? validateEmail(String value) {
    // Define your email validation logic here.
    if (value.isEmpty) {
      return 'Email is required';
    }
    // Use a regular expression to validate the email format.
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Invalid email address';
    }
    return null; // Return null if the input is valid.
  }

  static String? validatePassword(String value) {
    // Define your password validation logic here.
    if (value.isEmpty) {
      return 'Password is required';
    }
    // Check if the password length is at least 8 characters.
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Use regular expressions to enforce additional rules.
    if (!RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*()_+{}\[\]:;<>,.?~\\-]).{8,}$')
        .hasMatch(value)) {
      return 'Please insert a valid password';
    }
    return null; // Return null if the input is valid.
  }
}
