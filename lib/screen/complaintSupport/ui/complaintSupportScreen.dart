import 'package:flutter/material.dart';

import '../../../widget/customAppbar.dart';
import '../../../widget/motionToastHelper.dart';
import '../../../widget/primary_button.dart';

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
      body: SingleChildScrollView(
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
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// Mobile
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                labelText: "Mobile Number",   counterText: "",

                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),

                ),
              ),
            ),

            const SizedBox(height: 15),

            /// Remark
            TextField(
              controller: remarkController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Remark / Message",
                alignLabelWithHint: true,
            //    prefixIcon: const Icon(Icons.message),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 20),
            CommonAppButton(
              text: 'Submit Complaint',
              onPressed: () {

                final email = emailController.text.trim();
                final mobile = mobileController.text.trim();
                final remark = remarkController.text.trim();

                // 🔴 Empty check
                if (email.isEmpty || mobile.isEmpty || remark.isEmpty) {
                  ToastHelper.show(
                    context,
                    message: "Please fill all fields",
                    type: ToastType.warning,
                  );
                  return;
                }

                // 🔴 Email validation
                final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
                if (!emailRegex.hasMatch(email)) {
                  ToastHelper.show(
                    context,
                    message: "Enter valid email address",
                    type: ToastType.warning,
                  );
                  return;
                }

                // 🔴 Mobile validation
                if (mobile.length != 10) {
                  ToastHelper.show(
                    context,
                    message: "Enter valid 10 digit mobile number",
                    type: ToastType.warning,
                  );
                  return;
                }

                // ✅ Success
                ToastHelper.show(
                  context,
                  message: "Complaint submitted successfully",
                  type: ToastType.success,
                );

                // 👉 Optional: clear fields
                emailController.clear();
                mobileController.clear();
                remarkController.clear();
              },
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
      ),
    );
  }
}