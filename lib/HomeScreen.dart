import 'package:flutter/material.dart';
import 'package:flutter_map/components/CustomTextField.dart';
import 'package:flutter_map/router/AppRouteConstant.dart';
import 'package:go_router/go_router.dart';

class Login extends StatelessWidget {
  const Login({super.key});


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Stack(children: [
          
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    
                    const Text(
                      'Vechile Portal',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 300, bottom: 20),
                      child: CustomButton(
                          text: 'Client Login',
                          onPressed: () {
                            GoRouter.of(context)
                                .goNamed(AppRouteConstant.ClientRegi);
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: OutlinedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color.fromARGB(0, 11, 88, 131)),
                              foregroundColor: WidgetStateProperty.all<Color>(
                                  Colors.white),
                              minimumSize: WidgetStateProperty.all(
                                  const Size.fromHeight(45)),
                              side: WidgetStateProperty.all(const BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  width: 1.0,
                                  style: BorderStyle.solid))),
                          onPressed: () {
                            GoRouter.of(context)
                                .pushNamed(AppRouteConstant.VechileRegister);
                          },
                          child: const Text('Vechile Sign Up')),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            InkWell(
                              child: Text(
                                'Continue with Google',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
