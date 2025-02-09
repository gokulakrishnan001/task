
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/components/CustomTextField.dart';
import 'package:flutter_map/router/AppRouteConstant.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
const waitingSeconds = 20;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key, required this.mail});

  final String mail;

  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController pin = TextEditingController();
  bool isWaitingUserInput = true;
  DateTime? futureTime;
  Duration? waitingDelta;
  Timer? timer;

  Duration? getTimeDelta() {
    if (futureTime == null) {
      return null;
    }
    DateTime now = DateTime.now();
    return futureTime?.difference(now);
  }

  bool isElapsed(Duration d) {
    return d.inMinutes < 1 && d.inSeconds < 1;
  }

  String getCurrentDeltaBeautified() {
    if (waitingDelta == null) {
      return "00:00";
    }
    return "${waitingDelta?.inMinutes.remainder(60).toString().padLeft(2, "0")}:${waitingDelta?.inSeconds.remainder(60).toString().padLeft(2, "0")}";
  }

  stopWaiting() {
    futureTime = null;
    setState(() {
      waitingDelta = null;
      isWaitingUserInput = false;
    });
  }

  startWaiting() {
    futureTime = DateTime.now().add(const Duration(seconds: waitingSeconds));
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      Duration? delta = getTimeDelta();
      if (delta == null || isElapsed(delta)) {
        timer.cancel();
        stopWaiting();
        return;
      }
      setState(() {
        waitingDelta = delta;
        isWaitingUserInput = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startWaiting();
  }

  Widget getTimerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.timer_outlined,
          color: Color.fromARGB(255, 47, 142, 194),
          size: 15,
        ),
        Text(
          getCurrentDeltaBeautified(),
          style: const TextStyle(
              fontSize: 12, color: Color.fromARGB(255, 47, 142, 194)),
        )
      ],
    );
  }

  Widget getTimerRestartButtonWidget() {
    return InkWell(
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.repeat_sharp,
            color: Color.fromARGB(255, 47, 142, 194),
            size: 12,
          ),
          Text(
            "Resend verification code",
            style: TextStyle(
                fontSize: 15, color: Color.fromARGB(255, 47, 142, 194)),
          )
        ],
      ),
      onTap: () {
        startWaiting();
      },
    );
  }

  Widget getChangeButton() {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: const Text(
          "Change",
          style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 47, 142, 194),
              decoration: TextDecoration.underline),
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SetPhone()),
        );
      },
    );
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
    pin.dispose();
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
                padding: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Otp Verification',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Enter the 5 digit verification code sent to',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 117, 117, 117)),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      widget.mail,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                    if (!isWaitingUserInput) getChangeButton()
                  ],
                ),
              ),
              PinInput(pinController: pin),
              Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 20),
                  child: CustomButton(
                    text: 'Submit',
                    onPressed: () {
                      if (pin.text == "12456") {
                        GoRouter.of(context).pushNamed(
                            AppRouteConstant.ClientLanding,
                            );
                      } else {
                        SnackBar snackBar = snackBarField("InValid OTP");
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  )),
              isWaitingUserInput
                  ? getTimerWidget()
                  : getTimerRestartButtonWidget()
            ],
          ),
        )),
      ),
    );
  }
}

class PinInput extends StatelessWidget {
  final TextEditingController pinController;
  const PinInput({super.key, required this.pinController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      width: 200,
      child: PinInputTextField(
        controller: pinController,
        pinLength: 5,
        decoration: UnderlineDecoration(
          colorBuilder: PinListenColorBuilder(
              const Color.fromARGB(255, 229, 229, 234),
              const Color.fromARGB(255, 229, 229, 234)),
          bgColorBuilder: PinListenColorBuilder(
              const Color.fromARGB(0, 229, 229, 234),
              Color.fromARGB(0, 229, 229, 234)),
        ),
      ),
    );
  }
}

class SetPhone extends StatelessWidget {
  const SetPhone({super.key});

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
                  'Forgot Password',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ),
              //CustomTextField(
              //label: 'Enter your phone number',
              // required: false,
              //),
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: CustomButton(
                    text: 'Next',
                    onPressed: () {},
                  )),
            ],
          ),
        )),
      ),
    );
  }
}
