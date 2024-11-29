class ValidatorClass {
  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Please Enter an Email";
    } else if (!RegExp('^[a-zA-Z0-9_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value)) {
      return "Please Enter Valid Email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please Enter a Password";
    } else if (value.length < 6) {
      return "Please too short";
    }
    return null;
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Name";
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]').hasMatch(value)) {
      return "Only alphabets and numbers are allowed";
    }
    return null;
  }

  /*
  String? validateName(String? value) {
    if (value!.isEmpty) {
      return "Please Enter a User Name";
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return "Only alphabets allowed";
    }
    return null;
  }
   */

  String? validateUserName(String? value) {
    if (value!.isEmpty) {
      return "Please Enter a User Name";
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]').hasMatch(value)) {
      return "Only alphabets allowed";
    }
    return null;
  }

  // String? validateCN(String? value) {
  //   if (value!.isEmpty) {
  //     return "Field cannot be empty";
  //   } else if (value.length != 19) {
  //     return "Invalid length ";
  //   } else if (!RegExp(r'[eE][cC][rR][0-9]+').hasMatch(value)) {
  //     return "Invalid CN";
  //   }
  //   return null;
  // }

  String? validateContact(String? value) {
    if (value!.isEmpty) {
      return "Please Enter something";
    }
    // else if (!RegExp("^(?:[+260]9)?[0-9]{10}\$").hasMatch(value)) {
    //   return "Invalid Number";
    // }
    return null;
  }

  String? validateNotEmpty(String? value) {
    if (value!.isEmpty) {
      return "Please Enter something";
    }
    // else if (!RegExp("^(?:[+260]9)?[0-9]{10}\$").hasMatch(value)) {
    //   return "Invalid Number";
    // }
    return null;
  }



  String? validateAddress(String? value) {
    if (value!.isEmpty) {
      return "Please enter an address";
    }
    return null;
  }

  String? validateDateTime(String? value) {
    if (value!.isEmpty) {
      return "Please select a date";
    }
    return null;
  }

  String? validateNumber(String? value) {
    if (value!.isEmpty) {
      return "Please Enter a Number";
    } else if (!RegExp(r'^-?(\d+(\.\d{0,3})?|\.?\d{1,3})$').hasMatch(value)) {
      return "Please Enter Only Number";
    }
    return null;
  }
  /*
  String? validateNumber(String? value) {
    if (value!.isEmpty) {
      return "Please Enter a Number";
    } else if (!RegExp(r'^(\d+(\.\d{0,3})?|\.?\d{1,3})$').hasMatch(value)) {
      return "Please Enter Only Number";
    }
    return null;
  }
   */

  String? noValidationRequired(String? value) {
    return null;
  }
}