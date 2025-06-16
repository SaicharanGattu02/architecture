import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../authentication/ArchitechProfile.dart';
import '../authentication/LoginScreen.dart';
import '../authentication/Register/AddProject.dart';
import '../authentication/Register/Payment.dart';
import '../authentication/Register/ProfileCreated.dart';
import '../authentication/Register/SubScription.dart';
import '../presentation/PostYourRequirement.dart';
import '../presentation/PostYourRequirementSuccessfully.dart';
import '../presentation/SplashScreen.dart';
import '../presentation/onboarding.dart';
import '../presentation/selectState.dart';
import '../presentation/architectureDetails.dart';
import '../authentication/Register/companyDetails.dart';
import '../presentation/selectArchitecture.dart';
import '../presentation/selectCity.dart';
import '../presentation/selectType.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(Splash(), state),
    ),

    GoRoute(
      path: '/login',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(const LoginScreen(), state),
    ),
    GoRoute(
      path: '/onboarding',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(Onboarding(), state),
    ),
    GoRoute(
      path: '/enter_state',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(EnterState(), state),
    ),
    GoRoute(
      path: '/select_city',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(SelectCity(), state),
    ),
    GoRoute(
      path: '/select_type',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(SelectType(), state),
    ),
    GoRoute(
      path: '/select_architecture',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(SelectArchitecture(), state),
    ),
    GoRoute(
      path: '/architecture_details',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(ArchitectureDetails(), state),
    ),
    GoRoute(
      path: '/company_details',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(CompanyDetails(), state),
    ),
    GoRoute(
      path: '/payment',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(Payment(), state),
    ),
    GoRoute(
      path: '/add_project',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(AddProject(), state),
    ),
    GoRoute(
      path: '/profile_created',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(ProfileCreated(), state),
    ),
    GoRoute(
      path: '/subscription',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(Subscription(), state),
    ),
    GoRoute(
      path: '/post_your_requirement',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(PostRequirement(), state),
    ),
    GoRoute(
      path: '/post_your_requirement_success',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(PostYourRequiremntSuccessfully(), state),
    ),
    GoRoute(
      path: '/architech_profile',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(ArchitechProfile(), state),
    ),
  ],
);

Page<dynamic> buildSlideTransitionPage(Widget child, GoRouterState state) {
  // if (Platform.isIOS) {
  //   // Use default Cupertino transition on iOS
  //   return CupertinoPage(key: state.pageKey, child: child);
  // }

  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
