
import 'package:arta_app/feature/presentations/pages/ads/presition/views/add_advsrtismint.dart';
import 'package:arta_app/generated/l10n.dart';
import 'package:arta_app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/helper/shared_preference_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRoute.generatedRoute,
    // initialRoute: '/region',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false, 
      home: AddAdvertisementView()
    );
  }
}
