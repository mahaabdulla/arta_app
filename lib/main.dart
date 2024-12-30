import 'package:arta_app/core/views/screen/intro_views/introdoction1.dart';
import 'package:arta_app/core/views/screen/onbording.dart';
import 'package:arta_app/core/views/screen/splash_view.dart';
import 'package:arta_app/generated/l10n.dart';
import 'package:arta_app/helpers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/product',
      onGenerateRoute:AppRoute.generatedRoute,
       localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false, home: OnBordingView());
  }
}
