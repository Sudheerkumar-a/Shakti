class FieldValidator {
  static RegExp emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  //  RegExp(
  //     "[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
  RegExp passwordRegex =
      RegExp('^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*\W*?)[a-zA-Z\d\W]{8,}\$');
  RegExp postcodeRegExp = RegExp(
      '^(([gG][iI][rR] {0,}0[aA]{2})|((([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y]?[0-9][0-9]?)|(([a-pr-uwyzA-PR-UWYZ][0-9][a-hjkstuwA-HJKSTUW])|([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y][0-9][abehmnprv-yABEHMNPRV-Y]))) {0,}[0-9][abd-hjlnp-uw-zABD-HJLNP-UW-Z]{2}))\$'); // tslint:disable-line
  RegExp containsNumberRegExp = RegExp('\\d');
  RegExp containsCapitalLetterRegExp = RegExp('(?=.*[A-Z])');
  RegExp containsLowercaseLetterRegExp = RegExp('(?=.*[a-z])');
  RegExp atLeast6CharactersRegExp = RegExp('^.{6,}\$');
  RegExp atLeast4CharactersRegExp = RegExp('^.{4,}\$');
  RegExp noMoreThan15CharactersRegExp = RegExp('^.{0,15}\$');
  RegExp hasSpacesRegExp = RegExp('\\s');
  static RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$@!%&*?])[A-Za-z\d#$@!%&*?]{6,16}$');

  RegExp containsOnlyNumbersLowerCaseLettersAndUnderScores =
      RegExp('^[\s\da-z_]*\$');
  RegExp onlyContainsLettersAndNumbers = RegExp('^[a-zA-Z0-9_]*\$');
  RegExp passwordContains8charsNumbersLettersSpecialChars =
      RegExp('^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!-\/:-@\[-`{-~]).{8,}\$');
  RegExp containsSpecialCharacter = RegExp('[!@#\$%£^&*(),.?":{}|<>]');
  static RegExp alphabetRegExp = RegExp(r'^[a-zA-Z]+$');
  static RegExp numberRegExp = RegExp(r'^[0-9]+$');
  static RegExp zipCodeRegExp = RegExp(r'^[a-zA-Z0-9]+$');
  RegExp urlRegExp = RegExp(
      '^((www.)([a-zA-Z0-9])+(.([a-zA-Z0-9]+))*\$)|^((https?:\/\/)+([a-zA-Z0-9]+(.([a-zA-Z0-9]+))*\$))|^((https?:\/\/)+((www.)[a-zA-Z0-9]+(.([a-zA-Z0-9]+))*\$))');
  static email(String email) {
    bool validEmailFormat = emailRegExp.hasMatch(email);
    late var afterAt;
    var dotAfterAt;
    if (email.contains("@")) {
      afterAt = email.split("@")[1];
      dotAfterAt = afterAt.lastIndexOf(".");
    }
    return (validEmailFormat)
        ? ((dotAfterAt > 0) && (afterAt.length - 1 > dotAfterAt))
        : false;
  }

}
