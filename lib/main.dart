import 'package:bharat_metal_grid/screen/auth/login/bloc/loginBloc.dart';
import 'package:bharat_metal_grid/screen/auth/otp/bloc/otpBloc.dart';
import 'package:bharat_metal_grid/screen/auth/register/bloc/registerBloc.dart';
import 'package:bharat_metal_grid/screen/auth/role/bloc/roleBloc.dart';
import 'package:bharat_metal_grid/screen/cms/bloc/cmsBloc.dart';
import 'package:bharat_metal_grid/screen/events/bloc/eventsBloc.dart';

import 'package:bharat_metal_grid/screen/gridAI/bloc/gemini_bloc.dart';

import 'package:bharat_metal_grid/screen/homeScreen/bloc/homeBloc.dart';
import 'package:bharat_metal_grid/screen/leadership/bloc/leaderShipBloc.dart';
import 'package:bharat_metal_grid/screen/post/bloc/postBloc.dart';
import 'package:bharat_metal_grid/screen/post/repo/postRepo.dart';
import 'package:bharat_metal_grid/screen/profile/bloc/profileBloc.dart';
import 'package:bharat_metal_grid/screen/settings/appSettings/appSettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app/router/app_router.dart';
import '../app/theme/app_theme.dart';
import '../screen/splash/bloc/splash_bloc.dart';
import '../screen/splash/repo/splash_repo.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await AppSettings.initUserType(); // 🔥 MOST IMPORTANT
  //WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc(SplashRepo())),
        BlocProvider<RegisterBloc>(create: (context) => RegisterBloc(),),
        BlocProvider<ProfileBloc>(create: (context) => ProfileBloc(),),

        BlocProvider<SignInBloc>(create: (context) => SignInBloc(),),
        BlocProvider<SelectRoleBloc>(create: (context) => SelectRoleBloc(),),
        BlocProvider<OTPBloc>(create: (context) => OTPBloc(),),
        BlocProvider(create: (_) => SplashBloc(SplashRepo())),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc(),),
    BlocProvider<GeminiBloc>(create: (context) => GeminiBloc()),
    BlocProvider<LeaderShipBloc>(create: (context) => LeaderShipBloc()),
    BlocProvider<EventsBloc>(create: (context) => EventsBloc()),
    BlocProvider<CMSBloc>(create: (context) => CMSBloc()),
    BlocProvider<PostBloc>(create: (context) => PostBloc(repo: PostRepo())),


      ],
      child: MaterialApp.router(

        // navigatorKey: navigatorKey,
        title: "Bharat Metal Grid.",

        // 🔥 System theme detect automatically
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,

        // Light Theme
        // theme: AppTheme.lightTheme,
        //
        // // Dark Theme
        // darkTheme: AppTheme.darkTheme,

        // Navigation
        routerConfig: AppRouter.router,


        debugShowCheckedModeBanner: false,
      ),
    );
  }
}



//
// class Test extends StatefulWidget {
//   const Test({super.key});
//
//   @override
//   State<Test> createState() => _TestState();
//
// }
//
// class _TestState extends State<Test> {
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (_) => SplashBloc(SplashRepo())),
//         BlocProvider<RegisterBloc>(create: (context) => RegisterBloc(),),
//
//         BlocProvider<ProfileBloc>(create: (context) => ProfileBloc(),),
//         // BlocProvider(create: (_) => OnboardingBloc(OnboardingRepo())),
//         // BlocProvider(create: (_) => NavigationBloc()),
//         BlocProvider<SignInBloc>(create: (context) => SignInBloc(),),
//         BlocProvider<OTPBloc>(create: (context) => OTPBloc(),),
//         BlocProvider<HomeBloc>(create: (context) => HomeBloc(),),
//         BlocProvider<GeminiBloc>(create: (context) => GeminiBloc(),
//
//
//         )
//
//
//
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: MainBottomNavScreen(),
//         //  home: HomeScreen(),
//         //  home: MemberShipScreen(),
//         //home: NotificationScreen(),
//         // home: GridAiScreen(),
// //home: MemberRegisterScreen(isAgent: true,),
//         // home: SelectYourRoleScreen(),
//       ),
//     );
//   }
// }