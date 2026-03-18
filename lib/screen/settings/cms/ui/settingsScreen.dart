import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../widget/customAppbar.dart';
import '../../appSettings/appSettings.dart';
import '../bloc/settingsBloc.dart';
import '../bloc/settingsState.dart';



class SettingsPageScreens extends StatefulWidget {
  final String title;
  final String type;

  const SettingsPageScreens({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  State<SettingsPageScreens> createState() => _SettingsPageScreensState();
}

class _SettingsPageScreensState extends State<SettingsPageScreens> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: widget.title),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.error != null) {
                  return Center(child: Text(state.error!));
                }

                if (state.settingResponseModel != null) {
                  String htmlData = "";

                  switch (widget.type) {
                    case "privacyPolicy":
                      htmlData = AppSettings.privacyPolicy ?? "";
                      break;
                    case "refundPolicy":
                      htmlData = AppSettings.refundPolicy ?? "";
                      break;
                    case "termAndConditions":
                      htmlData = AppSettings.termsAndConditions ?? "";
                      break;
                    default:
                      htmlData = "Content not available.";
                  }

                  return SingleChildScrollView(
                 //   padding: const EdgeInsets.all(14.0),
                    child: Html(data: htmlData),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
