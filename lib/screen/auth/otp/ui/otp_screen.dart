import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';


import '../../../../app/router/navigation/nav.dart';
import '../../../../app/router/navigation/routes.dart';
import '../../../../app/theme/color_resource.dart';
import '../../../../widget/motionToastHelper.dart';
import '../../../../widget/primary_button.dart';

import '../bloc/otpBloc.dart';
import '../bloc/otpEvent.dart';
import '../bloc/otpState.dart';

class OtpScreen extends StatefulWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  Timer? _timer;
  int _start = 30;
  bool _canResend = false;
  bool _agreedToTerms = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      _start = 30;
      _canResend = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  void resendOtp() {
    if (_canResend) {
      // TODO: Call your resend OTP API
      print("Resending OTP to ${widget.phone}");
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<OTPBloc, OTPState>(
          listener: (context, state) {

            if (state.successMessage != null) {
              ToastHelper.show(
                context,
                message: state.successMessage!,
                type: ToastType.success,
              );
            }

            // if (state.errorMessage != null) {
            //   ToastHelper.show(
            //     context,
            //     message: state.errorMessage!,
            //     type: ToastType.error,
            //   );
            // }

            if (state.warningMessage != null) {
              ToastHelper.show(
                context,
                message: state.warningMessage!,
                type: ToastType.warning,
              );
            }

            if (state.isSuccess) {
              // Navigation already bloc me hai
            }

            // ❗ IMPORTANT
            context.read<OTPBloc>().add(const ResetVerifyOtpEvent());
          },
        child: BlocBuilder<OTPBloc, OTPState>(
          builder: (context, state) {
            final bloc = context.read<OTPBloc>();
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(

                  children: [
                    SizedBox(height: 50),
                    Container(
                  width: width,
                      //    height: height,
                      clipBehavior: Clip.antiAlias,
                      padding: EdgeInsets.all(12),

                      decoration: BoxDecoration(
                        color: ColorResource.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),

                        ],
                      ),
                      child: Column(

                        children: [
                          SizedBox(height: 15),

                          Image.asset("assets/images/appLogo.png", scale: 7),

                          SizedBox(height: height * 0.015),
                          SizedBox(
                            width: width * 0.6,
                            child: Text(
                              'Empowering India’s Metal Industry',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 1.50,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "4 digit OTP has sent to +91${widget.phone}",
                                    style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          height: 1.43,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: (){
                                      context.pop();
                                    },
                                      child: Image.asset("assets/icon/editIcon.png", scale: 4)),
                                ],
                              ),
                          const SizedBox(height: 25),
                              Pinput(
                                controller: otpController,
                                length: 4,
                                defaultPinTheme: PinTheme(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onCompleted: (value)async {
                                  // SharedPreferences pref = await SharedPreferences.getInstance();
                                  // String? fcmToken = pref.getString("fcmToken");
                                  // context.read<OTPBloc>().add(
                                  //   VerifyOtpEvent(
                                  //     mobileNumber: widget.phone,
                                  //     otp: value.trim(), // ✅ CORRECT
                                  //     context: context,
                                  //       deviceToken:fcmToken!
                                  //   ),
                                  // );

                                  ///Nav.go(context,  Routes.rideSelect);

                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(builder: (_) => const RideTypeScreen()),
                                  // );
                                },
                              ),

                              const SizedBox(height: 20),
                          // White Card Section

                          // OTP Field
                          const SizedBox(height: 25),

                          CommonAppButton(
                          text:  "Verify OTP",
                          isLoading: state.isLoading,
                          onPressed:
                          state.isLoading
                          ? null
                              : ()async {
                            // SharedPreferences pref = await SharedPreferences.getInstance();
                            // String? fcmToken = pref.getString("fcmToken");
                            context.read<OTPBloc>().add(
                              VerifyOtpEvent(
                                  mobileNumber: widget.phone,
                                  otp: otpController.text, // ✅ CORRECT
                                  context: context,

                              ),
                            );

                          },
                          ),
                          const SizedBox(height: 15),



                        ],
                      ),
                    ),
                  ],
                ),
              ),

            );
          },
        ),
      ),
    );
  }
}
