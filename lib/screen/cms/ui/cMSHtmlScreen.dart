import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../widget/customAppbar.dart';
import '../bloc/cmsBloc.dart';
import '../bloc/cmsState.dart';

class CMSHtmlScreen extends StatelessWidget {
  final String type;
  final String title;

  const CMSHtmlScreen({super.key, required this.type,required this.title});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: title),
      // appBar: CustomAppBar(title: type.toUpperCase()),
      // appBar: AppBar(
      //   title: Text(type.toUpperCase()),
      // ),
      body: BlocBuilder<CMSBloc, CMSState>(
        builder: (context, state) {

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final payload = state.cmsModel?.data?.payload;

          String htmlData = "";

          if (type == "privacy") {
            htmlData = payload?.privacyPolicy ?? "";
          }
          else if (type == "terms") {
            htmlData = payload?.termAndConditions ?? "";
          }
          else if (type == "refund") {
            htmlData = payload?.refundPolicy ?? "";
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