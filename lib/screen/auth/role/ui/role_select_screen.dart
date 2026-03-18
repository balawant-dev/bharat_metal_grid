import 'package:bharat_metal_grid/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../app/router/navigation/nav.dart';
import '../../../../../app/router/navigation/routes.dart';
import '../../../../../app/theme/color_resource.dart';
import '../bloc/roleBloc.dart';
import '../bloc/roleEvent.dart';
import '../bloc/roleState.dart';

class SelectYourRoleScreen extends StatefulWidget {
  final String phone;

  const SelectYourRoleScreen({super.key,required this.phone});

  @override
  State<SelectYourRoleScreen> createState() => _SelectYourRoleScreenState();
}

class _SelectYourRoleScreenState extends State<SelectYourRoleScreen> {
  int selectedIndex = -1; // 🔥 no default selection
  String userType = "";
  final TextEditingController otpController = TextEditingController();


  final List<Map<String, dynamic>> rideTypes = [
    {
      "title": "Member",
      "des": "Join as an individual to explore insights and consult with experts.",
      "icon": "assets/icon/member.png",
    },
    {
      "title": "Association",
      "des":
      "Join as an organization to manage multiple practitioners and sessions.",
      "icon": "assets/icon/assosiation.png",
    },
  ];

  void _onSelect({required int index,required String userTypee}) {
    setState(() {
      selectedIndex = index;
      userType=userTypee;
    });
  }




  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<SelectRoleBloc, SelectRoleState>(
          builder: (context, state) {
            final bloc = context.read<SelectRoleBloc>();
            return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  SizedBox(height: height * 0.1),

                  /// MAIN CARD
                  Container(
                    width: width,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ColorResource.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset("assets/images/appLogo.png", scale: 7),
                        const SizedBox(height: 20),

                        const Text(
                          'Select Your Role',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// ROLE LIST
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: rideTypes.length,
                          itemBuilder: (context, index) {
                            final item = rideTypes[index];
                            final selected = index == selectedIndex;

                            return GestureDetector(
                              onTap: () => _onSelect(index:index,userTypee: item["title"]),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.only(bottom: 15),
                                padding: const EdgeInsets.only(
                                    left: 12, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: selected
                                        ? ColorResource.primaryColor
                                        : Colors.grey.shade300,
                                    width: selected ? 2 : 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 6,
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(item["icon"], scale: 3.5),
                                    const SizedBox(width: 10),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item["title"],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            item["des"],
                                            style: TextStyle(
                                              fontSize: 11,
                                              color:
                                              Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /// RADIO
                                    Radio<int>(
                                      value: index,
                                      groupValue: selectedIndex,
                                      activeColor:
                                      ColorResource.primaryColor,
                                      onChanged: (value) {
                                        if (value != null) {
                                          _onSelect(index:value,userTypee: item["title"]);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 40),


                        /// CONTINUE BUTTON
                        CommonAppButton(
                          text: "Continue",
                          isLoading: state.isLoading,
                          onPressed: () {
                            if (selectedIndex == -1) {
                              Fluttertoast.showToast(
                                msg: "Please select your role",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                              );
                              return;
                            }

                            context.read<SelectRoleBloc>().add(
                              VerifyRoleEvent(
                                mobileNumber: widget.phone,
                                userType: userType,
                                context: context,
                              ),
                            );
                          },
                        ),

                        // CommonAppButton(
                        //   text: "Continue",
                        //   isLoading: state.isLoading,
                        //   onPressed:
                        //   selectedIndex == -1 ? null : (){
                        //     if (selectedIndex == -1) {
                        //       Fluttertoast.showToast(
                        //         msg: "Please select your role",
                        //         toastLength: Toast.LENGTH_SHORT,
                        //         gravity: ToastGravity.CENTER,
                        //       );
                        //       return;
                        //     }
                        //     context.read<SelectRoleBloc>().add(
                        //       VerifyRoleEvent(
                        //     mobileNumber: widget.phone,
                        //     userType: userType,
                        //     context: context,
                        //
                        //     ),
                        //     );
                        //
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
