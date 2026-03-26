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
        backgroundColor: Colors.white,
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

              final list = state.membershipAssignmentModel?.data ?? [];

              if (list.isEmpty) {
                return const Center(
                  child: Text("No Membership Assigned"),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final membership = list[index];

                  return GestureDetector(
                    onTap: () {

                      /// ✅ Create Order
                      context.read<PostBloc>().add(
                        CreateOrderEvent(
                          context: context,
                          membershipPlanID:
                          membership.membershipPlan?.sId ?? "",
                        ),
                      );

                      /// ✅ Razorpay Open
                      if (membership.membershipPlan?.amount != null) {
                        _razorpayService.openCheckout(
                          amount: membership.membershipPlan!.amount!.toString(),
                          name: "Bharat Metal Grid",
                          description:
                          membership.membershipPlan!.type ?? "Membership Plan",
                          email: "test@gmail.com",
                          contact: "9999999999",
                        );
                      }
                    },

                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8FAFC),        // ← Changed: Soft elegant background
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),      // ← Changed: Cleaner border
                          width: 1.2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0A000000),           // ← Softer shadow
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// 🔷 Type
                          Text(
                            capitalizeFirst(membership.membershipPlan?.type),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          /// 🔷 Description
                          Text(
                            membership.membershipPlan?.description ?? "No Description",
                            style: const TextStyle(fontSize: 13),
                          ),

                          const SizedBox(height: 12),

                          /// 🔷 Amount
                          _row(
                            "Amount",
                            "₹ ${membership.membershipPlan?.amount ?? 0}",
                            valueColor: Colors.green,
                          ),

                          /// 🔷 Expiry
                          _row(
                            "Expiry",
                            "${membership.membershipPlan?.expiryInDays ?? 0} Days",
                          ),

                          /// 🔷 Payment Status
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Payment Status"),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
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
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          /// 🔷 Assigned By
                          _row(
                            "Assigned By",
                            membership.assignedBy?.email ?? "N/A",
                          ),

                          const SizedBox(height: 10),

                          /// 🔷 Date
                          Text(
                            "Posted on: ${formatDate(membership.createdAt)}",
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
        ),
      ),
    );
  }
  Widget _row(String title, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {

    final list = context.read<PostBloc>()
        .state
        .membershipAssignmentModel
        ?.data;

    if (list != null && list.isNotEmpty) {
      context.read<PostBloc>().add(
        CreateOrderEvent(
          context: context,
          membershipPlanID:
          list.first.membershipPlan?.sId ?? "",
        ),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Successful")),
    );
  }
  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   print("Payment Success: ${response.paymentId}");
  //
  //   context.read<PostBloc>().add(
  //     CreateOrderEvent(
  //       context: context,
  //       membershipPlanID:
  //       context.read<PostBloc>().state.membershipAssignmentModel!.data!.sId!,
  //     ),
  //   );
  //
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text("Payment Successful")),
  //   );
  // }

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