import 'package:arta_app/core/repositoris/online_repo.dart';
import 'package:arta_app/core/routes/routes.dart';
import 'package:arta_app/feature/presentations/cubits/change_password/change_password_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/commint/commints_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/region/region_cubit.dart';
import 'package:arta_app/feature/presentations/pages/user/widgets/change_pass_screan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/notifications/handleLocalNotification.dart';
import 'feature/presentations/cubits/ads/listing_cubit.dart';
import 'feature/presentations/cubits/categories/categories_cubit.dart';
import 'feature/presentations/cubits/login/login_cubit.dart';
import 'feature/presentations/cubits/regetion/regetion_cubit.dart';
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
        BlocProvider(
          create: (_) => ListingCubit(OnlineDataRepo()),
        ),
        BlocProvider(
          create: (_) => CategoryCubit(OnlineDataRepo()),
        ),
        BlocProvider(
          create: (_) => ChangePasswordCubit(OnlineDataRepo()),
        ),
        BlocProvider(
          create: (_) => CommintsCubit(OnlineDataRepo()),
        ),
//         BlocProvider(create: (_) => RegionCubit(OnlineDataRepo())),

        BlocProvider(
          create: (_) => RegetionCubit(OnlineDataRepo()),
        ),

      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        onGenerateRoute: AppRoute.generatedRoute,
        initialRoute: '/home',
        locale: Locale('ar'),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,

// <<<<<<< maha/sub_catg
//         // home: ChangePasswordScreen(),
// =======
//         // home: FilterPage(),
// >>>>>>> develop
      ),
    );
  }
}
