import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/ArchitechProfile.dart';
import '../presentation/ArchitectProfileSetup.dart';
import '../presentation/Components/NoInternet.dart';
import '../presentation/PostYourRequirement.dart';
import '../presentation/PostYourRequirementSuccessfully.dart';
import '../presentation/SplashScreen.dart';
import '../presentation/UserPosted.dart';
import '../presentation/UserPostedDetails.dart';
import '../presentation/authentication/LoginScreen.dart';
import '../presentation/authentication/Register/AddProject.dart';
import '../presentation/authentication/Register/Otp.dart';
import '../presentation/authentication/Register/Payment.dart';
import '../presentation/authentication/Register/ProfileCreated.dart';
import '../presentation/authentication/Register/SubScription.dart';
import '../presentation/authentication/Register/createProfile.dart';
import '../presentation/onboarding.dart';
import '../presentation/selectState.dart';
import '../presentation/ArchitectureDetails.dart';
import '../presentation/ArchitectureList.dart';
import '../presentation/selectCity.dart';
import '../presentation/selectType.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
      path: '/no_internet',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(Nointernet(), state),
    ),
    GoRoute(
      path: '/user_posted_details',
      pageBuilder: (context, state) {
        final idString = state.uri.queryParameters['id'];
        final id = int.tryParse(idString ?? '') ?? 0;
        return buildSlideTransitionPage(UserPostedDetails(id: id), state);
      },
    ),
    GoRoute(
      path: '/enter_state',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(EnterState(), state),
    ),
    GoRoute(
      path: '/select_city',
      pageBuilder: (context, state) {
        final states = state.uri.queryParameters['state'] ?? "";
        return buildSlideTransitionPage(SelectCity(state: states), state);
      },
    ),
    GoRoute(
      path: '/select_type',
      pageBuilder: (context, state) {
        final states = state.uri.queryParameters['state'] ?? "";
        final city = state.uri.queryParameters['city'] ?? "";
        return buildSlideTransitionPage(
          SelectType(state: states, city: city),
          state,
        );
      },
    ),
    GoRoute(
      path: '/select_architecture',
      pageBuilder: (context, state) {
        final industryType = state.uri.queryParameters['industryType'] ?? "";
        final location = state.uri.queryParameters['location'] ?? "";
        return buildSlideTransitionPage(
          SelectArchitecture(industryType: industryType, location: location),
          state,
        );
      },
    ),
    GoRoute(
      path: '/architecture_details',
      pageBuilder: (context, state) {
        final idString = state.uri.queryParameters['id'];
        final id = int.tryParse(idString ?? '') ?? 0;
        final type = state.uri.queryParameters['type'] ?? "";
        return buildSlideTransitionPage(
          ArchitectureDetails(id: id, type: type),
          state,
        );
      },
    ),
    GoRoute(
      path: '/company_details',
      pageBuilder: (context, state) {
        final idString = state.uri.queryParameters['id'];
        final id = int.tryParse(idString ?? '') ?? 0;
        return buildSlideTransitionPage(CompanyDetails(id: id), state);
      },
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) {
        final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
        return Payment(data: data);
      },
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
      pageBuilder: (context, state) {
        final idParam = state.uri.queryParameters['id'];
        final int id = int.tryParse(idParam ?? '') ?? 0;
        final type = state.uri.queryParameters['type'] ?? "";
        return buildSlideTransitionPage(
          Subscription(id: id, type: type),
          state,
        );
      },
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
    GoRoute(
      path: '/architect_profile_setup',
      pageBuilder: (context, state) {
        final idString = state.uri.queryParameters['id'];
        final id = int.tryParse(idString ?? '') ?? 0;
        final type = state.uri.queryParameters['type'] ?? "";
        return buildSlideTransitionPage(
          ArchitectProfileSetup(id: id, type: type),
          state,
        );
      },
    ),
    GoRoute(
      path: '/otp',
      pageBuilder: (context, state) {
        final mailId = state.uri.queryParameters['mailId'] ?? "";
        final type = state.uri.queryParameters['type'] ?? "";
        return buildSlideTransitionPage(Otp(mailId: mailId, type: type), state);
      },
    ),

    GoRoute(
      path: '/user_posts',
      pageBuilder: (context, state) =>
          buildSlideTransitionPage(UserPosted(), state),
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
