import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'presentation/providers/language/language_provider.dart';
import 'presentation/providers/repositories/language_repository/language_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'firebase_options.dart';
import 'presentation/misc/constant.dart';
import 'presentation/providers/router/router_provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final container = ProviderContainer();
  final language =
      await container.read(languageRepositoryProvider).getLanguage();
  runApp(ProviderScope(
      overrides: [languageProvider.overrideWith((ref) => language)],
      child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);
    log(language.toString());
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: saffron,
          background: backgroundColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        splashFactory: InkRipple.splashFactory,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 3, splashFactory: InkRipple.splashFactory)),
        textButtonTheme: TextButtonThemeData(
            style: ElevatedButton.styleFrom(
                splashFactory: InkRipple.splashFactory)),
        textTheme: TextTheme(
            bodyMedium: GoogleFonts.poppins(color: ghostWhite),
            bodyLarge: GoogleFonts.poppins(color: ghostWhite),
            labelLarge: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      debugShowCheckedModeBanner: false,
      routeInformationProvider:
          ref.watch(routerProvider).routeInformationProvider,
      routeInformationParser: ref.watch(routerProvider).routeInformationParser,
      routerDelegate: ref.watch(routerProvider).routerDelegate,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: Locale(language.code),
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
