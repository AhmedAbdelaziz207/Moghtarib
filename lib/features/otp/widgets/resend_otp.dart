import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../logic/otp_cubit.dart';
import '../logic/otp_state.dart';

class ResendOtp extends StatefulWidget {
  const ResendOtp({
    super.key,
    this.phoneNumberOrEmail,
    this.token,
  });

  final String? phoneNumberOrEmail;

  final String? token;


  @override
  State<ResendOtp> createState() => _ResendOtpState();
}

class _ResendOtpState extends State<ResendOtp> {
  int _start = 30;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    const onSec = Duration(seconds: 1);
    Timer.periodic(onSec, (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double timer = _start / 100;

    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {

      },
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "0${timer.toStringAsFixed(2)}",
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: _start != 0
                  ? null
                  : () {

                      setState(() {
                        _start = 30;
                        startTimer();
                      });
                    },
              child: Text(
              "اعادة ارسال الكود",
              ),
            ),
          ),
        ],
      ),
    );
  }

}
