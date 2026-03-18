

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/router/navigation/nav.dart';
import '../../../app/router/navigation/routes.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../cms/bloc/cmsBloc.dart';
import '../../cms/bloc/cmsEvent.dart';
import '../../homeScreen/bloc/homeBloc.dart';
import '../../homeScreen/bloc/homeEvent.dart';
import '../../profile/bloc/profileBloc.dart';
import '../../profile/bloc/profileEvent.dart';
import '../../settings/appSettings/appSettings.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Splash delay
    Future.delayed(const Duration(seconds: 2), () {
      context.read<SplashBloc>().add(InitAppEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ White background
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state)async {
          final token = await SecureStorageService.getToken();
          final userType = await SecureStorageService.getUserType();

          print("App token is >>>>>>>>$token");

          if (token != null && token.isNotEmpty) {
            if (userType == "Association") {
              debugPrint("UserType >>>>>>>> $userType");
          context.read<ProfileBloc>().add(
                FetchProfileAssociationEvent(context: context),
              );
            } else if (userType == "Member") {
             context.read<ProfileBloc>().add(
                FetchProfileMemberEvent(context: context),
              );
            }
            context.read<HomeBloc>().add(FetchIndustryNewsEvent(context: context,limit: 10,page: 1));
            context.read<HomeBloc>().add(FetchLatestNoticesEvent(context: context,page: 1,limit: 10));
            context.read<HomeBloc>().add(GallerListEvent(context: context,page: 1,limit: 10));
            context.read<CMSBloc>().add(
              FetchCMSEvent(context: context),
            );

            print("UserType >>>>>>>>$userType");
            Nav.go(context, Routes.home);



            return;
          }else{
            Nav.go(context, Routes.login);

          }

        },
        child: Center(
          child: Image.asset(
            'assets/images/appLogo.png', // ✅ Only image
            width: 180,
            height: 180,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

