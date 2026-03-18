import 'package:bharat_metal_grid/screen/post/ui/postDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/router/navigation/routes.dart';
import '../../../app/theme/color_resource.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/payment/paymentService.dart';
import '../../../widget/customAppbar.dart';
import '../bloc/postBloc.dart';
import '../bloc/postEvent.dart';
import '../bloc/postState.dart';
import '../repo/postRepo.dart';
import 'createPostBottomSheet.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MembershipAssignmentScreen extends StatefulWidget {
  const MembershipAssignmentScreen({super.key});

  @override
  State<MembershipAssignmentScreen> createState() => _MembershipAssignmentScreenState();
}

class _MembershipAssignmentScreenState extends State<MembershipAssignmentScreen> {
  late RazorpayService _razorpayService;
  @override
  void initState() {
    super.initState();

    _razorpayService = RazorpayService();

    _razorpayService.init(
      onSuccess: _handlePaymentSuccess,
      onError: _handlePaymentError,
      onExternalWallet: _handleExternalWallet,
    );
  }
  String capitalizeFirst(String? text) {
    if (text == null || text.isEmpty) return "No Type";
    return text[0].toUpperCase() + text.substring(1);
  }
  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "N/A";

    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
    } catch (e) {
      return date;
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      PostBloc(repo: PostRepo())..add(MembershipAssignmentEvent(context: context)),
      child: Scaffold(
        appBar: CustomAppBar(title: "Membership"),

        body: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            // if (state.createSuccess) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(content: Text("Post created successfully!")),
            //   );
            // }
            //
            // if (state.errorMessage != null &&
            //     state.errorMessage!.isNotEmpty) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text(state.errorMessage!)),
            //   );
            // }
          },
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final membership = state.membershipAssignmentModel?.data;

              if (membership == null) {
                return const Center(
                  child: Text(
                    "No Membership Assigned",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  // onTap: (){
                  //   print("OOOOOOOOOOOOOOOOOO");
                  //   context.read<PostBloc>().add(
                  //     CreateOrderEvent(
                  //       context: context,
                  //       membershipPlanID: membership.sId!,
                  //     ),
                  //   );
                  // },
                  onTap: () {
                      print("OOOOOOOOOOOOOOOOOO");

                      context.read<PostBloc>().add(
                        CreateOrderEvent(
                          context: context,
                          membershipPlanID: state.membershipAssignmentModel!.data!.membershipPlan!.sId??"No DDDD",
                        ),
                    );
                    final membership = context
                        .read<PostBloc>()
                        .state
                        .membershipAssignmentModel
                        ?.data;

                    if (membership?.membershipPlan?.amount != null) {
                      _razorpayService.openCheckout(
                        amount: membership!.membershipPlan!.amount!,
                        name: "Bharat Metal Grid",
                        description: membership.membershipPlan!.type ?? "Membership Plan",
                        email: "test@gmail.com",
                        contact: "9999999999",
                      );
                    }
                  },
                  //CreateOrderEvent
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(vertical: 5),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// 🔹 Membership Type
                        Text(
                          capitalizeFirst(membership.membershipPlan?.type),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// 🔹 Description
                        Text(
                          membership.membershipPlan?.description ?? "No Description",
                          style: const TextStyle(fontSize: 14),
                        ),

                        const SizedBox(height: 20),

                        /// 🔹 Amount
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Amount",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "₹ ${membership.membershipPlan?.amount ?? "0"}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),

                        const Divider(height: 30),

                        /// 🔹 Expiry
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Expiry (Days)"),
                            Text(
                              "${membership.membershipPlan?.expiryInDays ?? 0} Days",
                            ),
                          ],
                        ),

                        const Divider(height: 30),

                        /// 🔹 Payment Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Payment Status"),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: membership.paymentStatus == "Paid"
                                    ? Colors.green.shade100
                                    : Colors.red.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                membership.paymentStatus ?? "Unknown",
                                style: TextStyle(
                                  color: membership.paymentStatus == "Paid"
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Divider(height: 30),

                        /// 🔹 Assigned By
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Assigned By"),
                            Text(
                              membership.assignedBy?.email ?? "N/A",
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        Text(
                          "Posted on: ${formatDate(membership.createdAt ?? "")}",
                          style: const TextStyle(color: Colors.grey,   fontSize: 12),
                        ),


                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Success: ${response.paymentId}");

    context.read<PostBloc>().add(
      CreateOrderEvent(
        context: context,
        membershipPlanID:
        context.read<PostBloc>().state.membershipAssignmentModel!.data!.sId!,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Successful")),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed: ${response.message}");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
  }
  @override
  void dispose() {
    _razorpayService.dispose();
    super.dispose();
  }
}