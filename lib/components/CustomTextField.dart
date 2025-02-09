import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  String label;
  String? hint;
  bool? required;
  int? maxLength;
  int? maxLines;
  IconButton? sIcon;
  IconData? pIcon;
  bool? enable;
  bool? obsecureText;
  TextEditingController controller;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  TextInputAction? action;
  TextInputType? type;
  int? minLines;

  CustomFormTextField(
      {super.key,
      this.enable,
      required this.controller,
      required this.label,
       this.validator,
      this.obsecureText,
      this.hint,
      this.maxLength,
      this.onChanged,
      this.maxLines,
      this.required,
      this.pIcon,
      this.action,
      this.type,
      this.minLines,
      this.sIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      //key for form
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            validator: validator,
            textInputAction: action,
            obscureText: obsecureText!,
            keyboardType: type,
            decoration: InputDecoration(
                hintText: hint,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.black)),
                errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 105, 54, 244),
                  ),
                ),
                prefixIcon: Icon(pIcon),
                suffixIcon: sIcon),
            onChanged: onChanged,
            maxLength: maxLength,
            maxLines: maxLines,
            minLines: minLines,
            enabled: enable,
          )
        ],
      ),
    );
  }
}

SnackBar snackBarField(String content) {
  return SnackBar(
    content: Text(content),
    backgroundColor: const Color.fromARGB(255, 11, 88, 131),
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(5),
  );
}


class CustomButton extends StatelessWidget {
  Function()? onPressed;
  String text;

  CustomButton({super.key, this.onPressed, required this.text});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 11, 88, 131)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(45))),
        onPressed: onPressed,
        child: Text(text));
  }
}

class Validator {
  static String? validateName({required String? name}) {
    if (name == null) {
      return null;
    }
    RegExp nameRegExp = RegExp(r'^[a-z A-Z]+$');

    if (name.isEmpty) {
      return 'Name can\'t be empty';
    } else if (!nameRegExp.hasMatch(name)) {
      return 'Enter a Vaild Name';
    }

    return null;
  }

  static String? validatePhone({required String? mobile}) {
    if (mobile == null) {
      return null;
    }
    RegExp phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

    if (mobile.isEmpty) {
      return 'Phone Number can\'t be empty';
    } else if (!phoneRegExp.hasMatch(mobile)) {
      return 'Enter a correct number';
    }
    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }
    RegExp passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (!passwordRegExp.hasMatch(password)) {
      return 'Password Must Contain Upeercase ,Special Character and LowerCase';
    }

    return null;
  }

  static String? validateConfirmPassword(
      {required String? password, required String? confirmPassword}) {
    if (confirmPassword == null && password == null) {
      return null;
    }

    if (confirmPassword!.isEmpty) {
      return 'Confirm Password Can\'t be empty';
    } else if (password != confirmPassword) {
      return 'Password Same as Confirm Password';
    }
    return null;
  }
}
