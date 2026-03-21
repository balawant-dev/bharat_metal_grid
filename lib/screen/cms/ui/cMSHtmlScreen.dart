// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_html/flutter_html.dart';
//
// import '../../../widget/customAppbar.dart';
// import '../bloc/cmsBloc.dart';
// import '../bloc/cmsState.dart';
//
// class CMSHtmlScreen extends StatelessWidget {
//   final String type;
//   final String title;
//
//   const CMSHtmlScreen({super.key, required this.type,required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: CustomAppBar(title: title),
//       // appBar: CustomAppBar(title: type.toUpperCase()),
//       // appBar: AppBar(
//       //   title: Text(type.toUpperCase()),
//       // ),
//       body: BlocBuilder<CMSBloc, CMSState>(
//         builder: (context, state) {
//
//           if (state.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           final payload = state.cmsModel?.data?.payload;
//
//           String htmlData = "";
//
//           if (type == "privacy") {
//             htmlData = payload?.privacyPolicy ?? "";
//           }
//           else if (type == "terms") {
//             htmlData = payload?.termAndConditions ?? "";
//           }
//           else if (type == "refund") {
//             htmlData = payload?.refundPolicy ?? "";
//           }
//
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Html(
//               data: htmlData,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../widget/customAppbar.dart';
import '../bloc/cmsBloc.dart';
import '../bloc/cmsState.dart';

class CMSHtmlScreen extends StatelessWidget {
  final String type;
  final String title;

  const CMSHtmlScreen({
    super.key,
    required this.type,
    required this.title,
  });

  // ✅ Dummy HTML Data
  String getDummyData(String type) {
    switch (type) {
      case "privacy":
        return """
      <h2>Bharat Metal Grid - Privacy Policy</h2>

      <p>At Bharat Metal Grid, we are committed to protecting your privacy and ensuring secure industrial communication.</p>

      <h3>1. Information We Collect</h3>
      <ul>
        <li>Basic details like name, phone number, email</li>
        <li>Business and industrial information</li>
        <li>Location data for better service experience</li>
      </ul>

      <h3>2. How We Use Your Information</h3>
      <ul>
        <li>To connect buyers and sellers in the metal industry</li>
        <li>To improve platform services and recommendations</li>
        <li>To provide membership and premium features</li>
      </ul>

      <h3>3. Data Protection</h3>
      <p>Your data is securely stored and protected using advanced security systems. We do not sell or share your personal information with third parties without consent.</p>

      <h3>4. Cookies</h3>
      <p>We use cookies to enhance user experience and track usage analytics.</p>

      <h3>5. Third-Party Services</h3>
      <p>We may use trusted third-party tools for analytics and payment processing.</p>

      <h3>6. User Rights</h3>
      <ul>
        <li>Access your data anytime</li>
        <li>Request correction or deletion</li>
      </ul>

      <h3>7. Updates</h3>
      <p>This policy may be updated from time to time to reflect improvements.</p>
      """;

      case "terms":
        return """
      <h2>Terms & Conditions</h2>

      <p>Welcome to Bharat Metal Grid. By using our platform, you agree to the following terms:</p>

      <h3>1. User Responsibilities</h3>
      <ul>
        <li>Provide accurate and genuine business information</li>
        <li>Do not post misleading or fake industrial listings</li>
      </ul>

      <h3>2. Platform Usage</h3>
      <ul>
        <li>The platform is designed for industrial and business use only</li>
        <li>Any misuse may result in account suspension</li>
      </ul>

      <h3>3. Membership</h3>
      <ul>
        <li>Premium features are available via paid membership</li>
        <li>Membership benefits may vary over time</li>
      </ul>

      <h3>4. Content Policy</h3>
      <ul>
        <li>No illegal, harmful, or abusive content allowed</li>
        <li>Users are responsible for their own posts</li>
      </ul>

      <h3>5. Limitation of Liability</h3>
      <p>Bharat Metal Grid is not responsible for any business losses or disputes between users.</p>

      <h3>6. Termination</h3>
      <p>We reserve the right to suspend or terminate accounts violating policies.</p>

      <h3>7. Changes</h3>
      <p>Terms may be updated anytime without prior notice.</p>
      """;

      case "refund":
        return """
      <h2>Refund Policy</h2>

      <p>This refund policy applies to all payments made on Bharat Metal Grid.</p>

      <h3>1. Membership Payments</h3>
      <ul>
        <li>All membership fees are non-refundable</li>
        <li>Users are advised to review features before purchase</li>
      </ul>

      <h3>2. Eligible Refund Cases</h3>
      <ul>
        <li>Duplicate payment</li>
        <li>Technical failure during transaction</li>
      </ul>

      <h3>3. Refund Process</h3>
      <ul>
        <li>Submit request within 7 days</li>
        <li>Include payment proof and details</li>
      </ul>

      <h3>4. Processing Time</h3>
      <p>Refunds (if approved) will be processed within 5-10 working days.</p>

      <h3>5. Contact Support</h3>
      <p>For refund queries, contact our support team through the app.</p>
      """;

      default:
        return """
      <h2>No Data Available</h2>
      <p>Content is currently unavailable. Please try again later.</p>
      """;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: BlocBuilder<CMSBloc, CMSState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final payload = state.cmsModel?.data?.payload;

          String htmlData = "";

          if (type == "privacy") {
            htmlData = payload?.privacyPolicy ?? "";
          } else if (type == "terms") {
            htmlData = payload?.termAndConditions ?? "";
          } else if (type == "refund") {
            htmlData = payload?.refundPolicy ?? "";
          }

          // ✅ Fallback if null or empty
          if (htmlData.trim().isEmpty) {
            htmlData = getDummyData(type);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Html(
              data: htmlData,
            ),
          );
        },
      ),
    );
  }
}