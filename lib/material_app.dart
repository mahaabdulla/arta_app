import 'package:arta_app/core/repositoris/online_repo.dart';
import 'package:arta_app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'bloc_providers.dart';
import 'core/notifications/handleLocalNotification.dart';
import 'feature/presentations/cubits/login/login_cubit.dart';
import 'feature/presentations/pages/login/login_screen.dart';
import 'generated/l10n.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    HandleLocalNotification notification = HandleLocalNotification();
    notification.initializeFlutterNotification(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginCubit(OnlineDataRepo()),
        ),
      ],
      child: MaterialApp(
          navigatorKey: navigatorKey,
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
          home: LoginScreen()),
    );
  }
}
