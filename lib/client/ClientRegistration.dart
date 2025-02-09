import 'package:flutter/material.dart';
import 'package:flutter_map/components/CustomTextField.dart';
import 'package:flutter_map/router/AppRouteConstant.dart';
import 'package:go_router/go_router.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<StatefulWidget> createState() => SigninState();
}

class SigninState extends State<SignIn> {
  TextEditingController loginUserMail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    super.dispose();
    loginUserMail.dispose();
    loginPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
        child: Center(
            child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Welcome ,',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 117, 117, 117)),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Sign In to Continue',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                  key: formKey,
                  child: Column(children: <Widget>[
                    CustomFormTextField(
                      controller: loginUserMail,
                      hint: "Mobile No",
                      obsecureText: false,
                      label: "Enter a Mobile no",
                      validator: (value) =>
                          Validator.validatePhone(mobile: value),
                      action: TextInputAction.next,
                      type: TextInputType.emailAddress,
                      pIcon: Icons.phone_android,
                    ),
                  ])),
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: CustomButton(
                    text: 'Submit',
                    onPressed: () {
                      if (isVaild()) {
                        // fetchData(loginUserMail.text);
                        Future.delayed(const Duration(seconds: 1), () {
                          GoRouter.of(context).pushNamed(
                              AppRouteConstant.ClientOtp,
                              pathParameters: {'phone': loginUserMail.text});
                        });
                      } else {
                        SnackBar snackBar =
                            snackBarField("Invaild Credientals");

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  )),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    'New user?',
                    style: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 79, 79, 79)),
                  ),
                  InkWell(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(
                            255,
                            47,
                            142,
                            194,
                          )),
                    ),
                    onTap: () {
                      GoRouter.of(context)
                          .pushNamed(AppRouteConstant.VechileRegister);
                    },
                  )
                ]),
              )
            ],
          ),
        )),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  bool isVaild() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }
}
