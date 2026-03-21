import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/router/navigation/nav.dart';
import '../../../../app/router/navigation/routes.dart';
import '../../../../app/theme/color_resource.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../widget/motionToastHelper.dart';
import '../../../../widget/primary_button.dart';

import '../../../settings/appSettings/appSettings.dart';
import '../bloc/loginBloc.dart';
import '../bloc/loginEvent.dart';
import '../bloc/loginState.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? phoneNumber = '';
  String? countryCode = '+91';
  bool isOtpSent = false;
  bool isLoading = false;
  String otp = '';
  bool _agreedToTerms = false;
  final TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<SignInBloc>().add(const ResetSendOtpEvent());
  }

  @override
  void dispose() {
    mobileController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //final loginVM = Provider.of<LogInViewModel>(context);

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {

          if (state.successMessage != null) {
            ToastHelper.show(
              context,
              message: state.successMessage!,
              type: ToastType.success,
            );
          }

          if (state.errorMessage != null) {
            ToastHelper.show(
              context,
              message: state.errorMessage!,
              type: ToastType.error,
            );
          }

          if (state.warningMessage != null) {
            ToastHelper.show(
              context,
              message: state.warningMessage!,
              type: ToastType.warning,
            );
          }

          if (state.isSuccess) {
            Nav.push(context, Routes.otp, extra: mobileController.text);
          }

          // Reset after showing
          context.read<SignInBloc>().emit(SignInState());
        },
        child: BlocBuilder<SignInBloc, SignInState>(
          builder: (context, state) {
            final bloc = context.read<SignInBloc>();
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Container(
                      //width: width*0.9,
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
                          // BoxShadow(
                          //   color: Colors.black.withOpacity(0.1),
                          //   blurRadius: 6,
                          //   spreadRadius: 1,
                          //   offset: const Offset(0, 3),
                          // ),
                        ],
                      ),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 15),
                          // Skip button (top-right)
                          // Image.asset("assets/images/appLogo.png",scale: 4,),
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
                          SizedBox(
                            width: width * 0.7,
                            child: Text(
                              'Access a unified platform for trade associations and industrial excellence.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(
                                  0xFF404040,
                                ) /* Labels---Vibrant---Controls-Primary */,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1.43,
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),

                          // White Card Section
                          Card(
                            elevation: 2,
                            shadowColor: ColorResource.darkText.withOpacity(
                              0.5,
                            ),
                            child: IntlPhoneField(
                              controller: mobileController,

                              initialCountryCode: 'IN',
                              showDropdownIcon: true,
                              dropdownIcon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Enter your Mobile Number',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color(0xFFF7F7F7),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                counterText: '',
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              onChanged: (phone) {
                                phoneNumber = phone.number;
                                countryCode = phone.countryCode;
                              },
                            ),
                          ),

                          // OTP Field
                          const SizedBox(height: 25),
                          CommonAppButton(
                            text: "Send OTP",
                            isLoading: state.isLoading,
                            onPressed:
                                state.isLoading
                                    ? null
                                    : () {
                              // if(mobileController.text.isEmpty||mobileController.text.length!=10){
                              //   ToastHelper.show(
                              //     context,
                              //     message:
                              //     "Please Enter 10 Digit Mobile Number",
                              //     type: ToastType.warning,
                              //   );
                              // }
                                      if (!_agreedToTerms) {
                                        //
                                        ToastHelper.show(
                                          context,
                                          message:
                                              "Please accept Terms & Conditions",
                                          type: ToastType.warning,
                                        );
                                        // ScaffoldMessenger.of(context).showSnackBar(
                                        //   const SnackBar(
                                        //     content: Text("Please accept Terms & Conditions"),
                                        //   ),
                                        // );
                                        return;
                                      }

                                      bloc.add(
                                        SendOtpEvent(
                                          mobileNumber:
                                              mobileController.text.trim(),
                                          context: context,
                                        ),
                                      );
                                    },
                            // onPressed:
                            //     state.isLoading
                            //         ? null
                            //         : () {
                            //           bloc.add(
                            //             SendOtpEvent(
                            //               mobileNumber:
                            //                   mobileController.text.trim(),
                            //               context: context,
                            //             ),
                            //           );
                            //         },
                          ),

                          const SizedBox(height: 20),

                          Container(
                            width: width * 0.8,
                            height: 28,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 24,
                                  top: 0,
                                  child: SizedBox(
                                    width: 278,
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                'I have read and agree to the ',
                                            style: TextStyle(
                                              color: const Color(0xFF252525),
                                              fontSize: 10,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              height: 1.40,
                                              letterSpacing: -0.24,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Terms & Conditions',
                                            recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap = () async {
                                                    await AppSettings.initUserType();
                                                    Nav.push(
                                                      context,
                                                      Routes.terms2,
                                                    );
                                                    print("Terms clicked");

                                                    /// 👉 Navigate karo
                                                    // Navigator.push(context, MaterialPageRoute(builder: (_) => TermsScreen()));

                                                    /// ya
                                                    // navPush(context: context, action: TermsScreen());
                                                  },
                                            style: TextStyle(
                                              color: const Color(0xFF1135A4),
                                              fontSize: 10,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w700,
                                              //     textDecoration: TextDecoration.underline,
                                              height: 1.40,
                                              letterSpacing: -0.24,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '  ',
                                            style: TextStyle(
                                              color: const Color(0xFF1135A4),
                                              fontSize: 10,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w700,
                                              height: 1.40,
                                              letterSpacing: -0.24,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'and',
                                            style: TextStyle(
                                              color: const Color(0xFF252525),
                                              fontSize: 10,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              height: 1.40,
                                              letterSpacing: -0.24,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '  ',
                                            style: TextStyle(
                                              color: const Color(0xFF1135A4),
                                              fontSize: 10,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w700,
                                              height: 1.40,
                                              letterSpacing: -0.24,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Privacy Policy',
                                            recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap = () async {
                                                    await AppSettings.initUserType();
                                                    Nav.push(
                                                      context,
                                                      Routes.privacy2,
                                                    );

                                                    print('Privacy Policy');

                                                    /// 👉 Navigate karo
                                                    // Navigator.push(context, MaterialPageRoute(builder: (_) => TermsScreen()));

                                                    /// ya
                                                    // navPush(context: context, action: TermsScreen());
                                                  },
                                            style: TextStyle(
                                              color: const Color(0xFF1135A4),
                                              fontSize: 10,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w700,
                                              //  textDecoration: TextDecoration.underline,
                                              height: 1.40,
                                              letterSpacing: -0.24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _agreedToTerms = !_agreedToTerms;
                                      });
                                    },

                                    child: Container(
                                      width: 18,
                                      height: 18,
                                      margin: const EdgeInsets.only(top: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(
                                          color:
                                              _agreedToTerms
                                                  ? ColorResource.primaryColor
                                                  : Color(0xFFA4A4A4),
                                          width: 1,
                                        ),
                                        color: Colors.transparent,
                                      ),
                                      child:
                                          _agreedToTerms
                                              ? Icon(
                                                Icons.check_rounded,
                                                size: 15,
                                                color:
                                                    ColorResource.primaryColor,
                                              )
                                              : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
