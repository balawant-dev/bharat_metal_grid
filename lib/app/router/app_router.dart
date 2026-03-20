import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';






import '../../core/uiSection/screen/login_screen.dart';
import '../../screen/auth/login/ui/loginScreen.dart';
import '../../screen/auth/otp/ui/otp_screen.dart';

import '../../screen/auth/register/ui/associationRegistrationScreen.dart';
import '../../screen/auth/register/ui/memberRegisterScreen.dart';
import '../../screen/auth/register/ui/registerSuccessScreen.dart';
import '../../screen/auth/role/ui/role_select_screen.dart';
import '../../screen/bottomNavigationBar/bottomNavigationBar.dart';
import '../../screen/cms/ui/cMSHtmlScreen.dart';
import '../../screen/complaintSupport/ui/complaintSupportScreen.dart';
import '../../screen/gridAI/ui/chatScreen.dart';
import '../../screen/homeScreen/model/galleryListModel.dart';
import '../../screen/homeScreen/ui/gallery_grid_screen.dart';
import '../../screen/homeScreen/ui/homeScreen.dart';
import '../../screen/homeScreen/ui/industry/industryDetailSCreen.dart';
import '../../screen/homeScreen/ui/industry/industryListScreen.dart';
import '../../screen/homeScreen/ui/latestNews/latestNoticeDetailScreen.dart';
import '../../screen/homeScreen/ui/latestNews/latestNoticeListScreen.dart';
import '../../screen/leadership/ui/postLeaderShipScreen.dart';
import '../../screen/myMembership/ui/myMemberShipScreen.dart';
import '../../screen/notification/ui/notificationScreen.dart';
import '../../screen/post/ui/membershipAssignmentScreen.dart';
import '../../screen/post/ui/postDetailScreen.dart';
import '../../screen/post/ui/postScreen.dart';
import '../../screen/profile/ui/associationProfileScreen.dart';
import '../../screen/profile/ui/memberProfileScreen.dart';
import '../../screen/splash/screen/splash_screen.dart';
import '../../test.dart';
import 'navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/uiSection/screen/login_screen.dart';
import '../../screen/auth/login/ui/loginScreen.dart';
import '../../screen/auth/otp/ui/otp_screen.dart';
import '../../screen/auth/register/ui/associationRegistrationScreen.dart';
import '../../screen/auth/register/ui/memberRegisterScreen.dart';
import '../../screen/auth/role/ui/role_select_screen.dart';
import '../../screen/bottomNavigationBar/bottomNavigationBar.dart';
import '../../screen/gridAI/ui/chatScreen.dart';
import '../../screen/homeScreen/ui/homeScreen.dart';
import '../../screen/homeScreen/ui/industry/industryDetailSCreen.dart';
import '../../screen/homeScreen/ui/industry/industryListScreen.dart';
import '../../screen/homeScreen/ui/latestNews/latestNoticeDetailScreen.dart';
import '../../screen/homeScreen/ui/latestNews/latestNoticeListScreen.dart';
import '../../screen/notification/ui/notificationScreen.dart';
import '../../screen/profile/ui/associationProfileScreen.dart';
import '../../screen/profile/ui/memberProfileScreen.dart';
import '../../screen/splash/screen/splash_screen.dart';
import '../../test.dart';
import 'navigation/routes.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.splash,
    routes: [

      /// SPLASH (NO ANIMATION)
      GoRoute(
        path: Routes.splash,
        pageBuilder: (_, __) => const NoTransitionPage(
          child: SplashScreen(),
        ),
      ),

      /// LOGIN – FADE + SCALE
      GoRoute(
        path: Routes.login,
        pageBuilder: (_, __) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: fadeScaleTransition,
          child: LoginScreen(),
        ),
      ),

      /// ROLE SELECT – SLIDE + FADE
      GoRoute(
        path: Routes.rideSelect,
        pageBuilder: (_, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 550),
          transitionsBuilder: slideFadeTransition,
          child: SelectYourRoleScreen(
            phone: state.extra as String? ?? "111111111",
          ),
        ),
      ),

      /// MEMBER REGISTER
      GoRoute(
        path: Routes.memberRegister,
        pageBuilder: (_, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 550),
          transitionsBuilder: slideFadeTransition,
          child: MemberRegisterScreen(
            phone: state.extra as String? ?? "1111111111",
          ),
        ),
      ),

      /// ASSOCIATION REGISTER
      GoRoute(
        path: Routes.associationRegister,
        pageBuilder: (_, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 550),
          transitionsBuilder: slideFadeTransition,
          child: AssociationRegistrationScreen(
            phone: state.extra as String? ?? "1111111111",
          ),
        ),
      ),

      /// PRIVACY / TERMS / REFUND
      GoRoute(
        path: Routes.privacy,
        pageBuilder: (_, __) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 450),
          transitionsBuilder: fadeScaleTransition,
          child: const SettingsPageScreens(
            title: "Privacy Policy",
            type: "privacyPolicy",
          ),
        ),
      ),
      GoRoute(
        path: Routes.terms,
        pageBuilder: (_, __) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 450),
          transitionsBuilder: fadeScaleTransition,
          child: const SettingsPageScreens(
            title: "Terms & Condition",
            type: "termAndConditions",
          ),
        ),
      ),
      GoRoute(
        path: Routes.refundPolicy,
        pageBuilder: (_, __) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 450),
          transitionsBuilder: fadeScaleTransition,
          child: const SettingsPageScreens(
            title: "Refund Policy",
            type: "refundPolicy",
          ),
        ),
      ),

      /// OTP
      GoRoute(
        path: Routes.otp,
        pageBuilder: (_, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: slideFadeTransition,
          child: OtpScreen(
            phone: state.extra as String? ?? "111111111",
          ),
        ),
      ),

      /// INDUSTRY DETAIL – BOTTOM TO TOP
      GoRoute(
        path: Routes.industryDetail,
        pageBuilder: (_, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: bottomToTopPremium,
          child: IndustryDetailScreen(
            id: state.extra as String? ?? "111111111",
          ),
        ),
      ),

      /// LATEST NOTICE DETAIL – ULTRA
      GoRoute(
        path: Routes.latestNoticeDetail,
        pageBuilder: (_, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 650),
          transitionsBuilder: ultraTransition,
          child: LatestNoticeDetailScreen(
            id: state.extra as String? ?? "111111111",
          ),
        ),
      ),

      /// MAIN SCREENS (NO TRANSITION)
      GoRoute(
        path: Routes.home,
        builder: (_, __) => MainBottomNavScreen(),
      ),    GoRoute(
        path: Routes.success,
        builder: (_, __) => RegisterSuccessScreen(),
      ),
      GoRoute(
        path: Routes.profileAssociation,
        builder: (_, __) => ProfileAssociationScreen(),
      ),GoRoute(
        path: Routes.postLeaderShip,
        builder: (_, __) => PostLeaderShipScreen(),
      ),
      GoRoute(
        path: Routes.profileMember,
        builder: (_, __) => ProfileMemberScreen(),
      ),
      GoRoute(
        path: Routes.support,
        builder: (_, __) => SupportScreen(),
      ),
      GoRoute(
        path: Routes.notification,
        builder: (_, __) => NotificationScreen(),
      ),
      GoRoute(
        path: Routes.privacy2,
        builder: (_, __) => CMSHtmlScreen(type: "privacy",title: "Privacy Policy",),
      ),

      GoRoute(
        path: Routes.terms2,
        builder: (_, __) => CMSHtmlScreen(type: "terms",title: "Terms & Conditions",),
      ),
 GoRoute(
        path: Routes.complaintSupport,
        builder: (_, __) => ComplaintSupportScreen(),
      ),

      GoRoute(
        path: Routes.refund2,
        builder: (_, __) => CMSHtmlScreen(type: "refund",title:"Refund Policy" ,),
      ),
      GoRoute(
        path: Routes.gemini,
        builder: (_, __) => GeminiAiScreen(),
      ),
      GoRoute(
        path: Routes.post,
        builder: (_, __) => PostListScreen(),
      ),  GoRoute(
        path: Routes.membershipAssignment,
        builder: (_, __) => MembershipAssignmentScreen(),
      ),
      GoRoute(
        path: Routes.postDetail,
        builder: (context, state) {
          final id = state.extra as String;
          return PostDetailScreen(id: id);
        },
      ),
      GoRoute(
        path: Routes.memberShip,
        builder: (_, __) => MemberShipScreen(),
      ),
      GoRoute(
        path: Routes.galleryGrid,
        builder: (context, state) {
          final galleryList = state.extra as List<GalleryData>;
          return GalleryGridScreen(galleryList: galleryList);
        },
      ),
      GoRoute(
        path: Routes.fullGallery,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?; // safe cast

          final galleryList = extra?['list'] as List<GalleryData>? ?? [];
          final initialIndex = extra?['index'] as int? ?? 0;

          return FullGalleryView(
            galleryList: galleryList,
            initialIndex: initialIndex,
          );
        },
      ),
      GoRoute(
        path: Routes.latestNotices,
        builder: (_, __) => LatestNoticeListScreen(),
      ),
      GoRoute(
        path: Routes.industryNews,
        builder: (_, __) => IndustryNewScreen(),
      ),
    ],
  );

  // ================= TAGDA ANIMATIONS =================

  static Widget slideFadeTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    return SlideTransition(
      position: Tween(
        begin: const Offset(1.1, 0),
        end: Offset.zero,
      ).animate(curved),
      child: FadeTransition(
        opacity: curved,
        child: child,
      ),
    );
  }

  static Widget fadeScaleTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    final curved =
    CurvedAnimation(parent: animation, curve: Curves.easeOutExpo);

    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween(begin: 0.95, end: 1.0).animate(curved),
        child: child,
      ),
    );
  }

  static Widget bottomToTopPremium(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeIn,
    );

    return SlideTransition(
      position: Tween(
        begin: const Offset(0, 1.1),
        end: Offset.zero,
      ).animate(curved),
      child: child,
    );
  }

  static Widget ultraTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    final curved =
    CurvedAnimation(parent: animation, curve: Curves.easeOutQuart);

    return SlideTransition(
      position: Tween(
        begin: const Offset(0.15, 0),
        end: Offset.zero,
      ).animate(curved),
      child: FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween(begin: 0.96, end: 1.0).animate(curved),
          child: child,
        ),
      ),
    );
  }
}
