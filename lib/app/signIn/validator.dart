abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidator {
  final emailValidator = NonEmptyStringValidator();
  final passwordValidator = NonEmptyStringValidator();
  final inValidEmailErrorText = 'Email can\'t be empty';
  final inValidPasswordErrorText = 'password can\'t be empty';
}
