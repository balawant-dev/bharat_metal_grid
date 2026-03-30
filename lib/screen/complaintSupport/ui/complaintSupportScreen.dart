import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget/customAppbar.dart';
import '../../../widget/motionToastHelper.dart';
import '../../../widget/primary_button.dart';
import '../bloc/complaint_bloc.dart';
import '../bloc/complaint_event.dart';
import '../bloc/complaint_state.dart';

class ComplaintSupportScreen extends StatelessWidget {
  ComplaintSupportScreen({super.key});

  final Color primaryColor = const Color(0xFF001E5A);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
    title: "Complaint & Support",
      ),
      body: BlocConsumer<ComplaintBloc, ComplaintState>(
          listener: (context, state) {
            if (state.isSuccess) {
              ToastHelper.show(context,
                  message: "Complaint submitted successfully",
                  type: ToastType.success);

              emailController.clear();
              mobileController.clear();
              remarkController.clear();
            }

            if (state.errorMessage != null) {
              ToastHelper.show(context,
                  message: state.errorMessage!,
                  type: ToastType.error);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Header
                Text(
                  "Need Help?",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Submit your complaint or query and our support team will contact you.",
                  style: TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 20),

                /// Email
                _field(
                  controller: emailController,
                  label: "Email",
                  icon: Icons.email,
                  error: state.emailError,
                ),

                const SizedBox(height: 15),

                /// Mobile
                _field(
                  controller: mobileController,
                  label: "Mobile Number",
                  icon: Icons.phone,
                  keyboard: TextInputType.phone,
                  maxLength: 10,
                  error: state.mobileError,
                ),


                const SizedBox(height: 15),

                /// Remark
                _field(
                  controller: remarkController,
                  label: "Remark",
                  maxLines: 4,
                  error: state.remarkError,
                ),

                const SizedBox(height: 20),
                CommonAppButton(
                  text: 'Submit Complaint',
                  onPressed: (){
                    context.read<ComplaintBloc>().add(
                      SubmitComplaintEvent(
                        context: context,
                        email: emailController.text.trim(),
                        mobile: mobileController.text.trim(),
                        remark: remarkController.text.trim(),
                      ),
                    );
                  }
                ),

                /// Submit Button


                const SizedBox(height: 30),

                /// FAQ Section
                Text(
                  "FAQs",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 10),

                ExpansionTile(
                  title: const Text("How can I track my complaint?"),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "You will receive a confirmation message after submitting your complaint.",
                      ),
                    )
                  ],
                ),

                ExpansionTile(
                  title: const Text("How long does support take to reply?"),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Our support team usually responds within 24 hours.",
                      ),
                    )
                  ],
                ),

                ExpansionTile(
                  title: const Text("Can I update my complaint later?"),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Yes, you can contact support again with your complaint ID.",
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
  Widget _field({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    String? error,
    int maxLines = 1,
    int? maxLength,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(color: Colors.black),
            children: const [
              TextSpan(
                text: " *",
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: keyboard,
          maxLines: maxLines,
          maxLength: maxLength,
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            errorText: error,
            counterText: ""
          ),
        ),
      ],
    );
  }
}