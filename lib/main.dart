import 'package:architect/services/ApiClient.dart';
import 'package:architect/utils/media_query_helper.dart';
import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_routes/StateInjector.dart';
import 'app_routes/router.dart';
import 'package:provider/provider.dart';

void main() {
  ApiClient.setupInterceptors();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MultiRepositoryProvider(
      providers: StateInjector.repositoryProviders,
      child: MultiProvider(
        providers: StateInjector.blocProviders,
        child: MaterialApp.router(
          title: 'Arkitek',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            scaffoldBackgroundColor: Colors.white,
            dialogBackgroundColor: Colors.white,
            cardColor: Colors.white,
            searchBarTheme: const SearchBarThemeData(),
            tabBarTheme: const TabBarThemeData(),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: const TextStyle(
                color: hintColor,
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
              ),
              labelStyle: const TextStyle(
                color: hintColor,
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: formfieldColor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              errorStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.red,
              ),
            ),
            dialogTheme: const DialogThemeData(
              shadowColor: Colors.white,
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            buttonTheme: const ButtonThemeData(),
            popupMenuTheme: const PopupMenuThemeData(
              color: Colors.white,
              shadowColor: Colors.white,
            ),
            appBarTheme: AppBarTheme(
              surfaceTintColor: primarycolor,
              backgroundColor: primarycolor,
              shadowColor: primarycolor,
              foregroundColor: primarycolor,
            ),
            cardTheme: CardThemeData(
              shadowColor: Colors.white,
              surfaceTintColor: Colors.white,
              color: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(style: ButtonStyle()),
            elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle()),
            outlinedButtonTheme: OutlinedButtonThemeData(style: ButtonStyle()),
            bottomSheetTheme: const BottomSheetThemeData(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
            ),
            colorScheme: const ColorScheme.light(
              primary: Colors.white, // 🔴 Add this
              background: Colors.white,
            ).copyWith(background: Colors.white),
            // Optionally, set directly as fallback
            primaryColor: Colors.white,
            fontFamily: 'Inter',
            textTheme: TextTheme(
              displayLarge: TextStyle(color: textPrimaryColor, fontFamily: 'Inter',),
              displayMedium: TextStyle(color: textPrimaryColor, fontFamily: 'Inter',),
              displaySmall: TextStyle(color: textPrimaryColor, fontFamily: 'Inter',),
              headlineLarge: TextStyle(color: textPrimaryColor, fontFamily: 'Inter',),
              headlineMedium: TextStyle(color: textPrimaryColor, fontFamily: 'Inter',),
              headlineSmall: TextStyle(color: textPrimaryColor, fontFamily: 'Inter',),
              titleLarge: TextStyle(color: textPrimaryColor, fontFamily: 'Inter',),
              titleMedium: TextStyle(color: textPrimaryColor, fontFamily: 'Inter',),
              titleSmall: TextStyle(color: textPrimaryColor, fontFamily: 'Inter',),
              bodyLarge: TextStyle(color: textPrimaryColor, fontFamily: 'Inter',),
              bodyMedium: TextStyle(color: textPrimaryColor, fontFamily: 'Inter',),
              bodySmall: TextStyle(color: textPrimaryColor, fontFamily: 'Inter',),
              labelLarge: TextStyle(color: textPrimaryColor, fontFamily: 'Inter',),
              labelMedium: TextStyle(color: textPrimaryColor, fontFamily: 'Inter',),
              labelSmall: TextStyle(color: textPrimaryColor, fontFamily: 'Inter',),
            ),
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,

        ),
      ),
    );
  }
}
