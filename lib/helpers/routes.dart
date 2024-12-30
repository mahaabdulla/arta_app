import 'package:arta_app/core/views/screen/add_advsrtismint.dart';
import 'package:arta_app/core/views/screen/catg_views/cars.dart';
import 'package:arta_app/core/views/screen/catg_views/electronuc.dart';
import 'package:arta_app/core/views/screen/catg_views/home_catg.dart';
import 'package:arta_app/core/views/screen/catg_views/motors.dart';
import 'package:arta_app/core/views/screen/catg_views/sport.dart';
import 'package:arta_app/core/views/screen/catg_views/women.dart';
import 'package:arta_app/core/views/screen/home_view.dart';
import 'package:arta_app/core/views/screen/onbording.dart';
import 'package:arta_app/core/views/screen/products_view/product_view.dart';
import 'package:arta_app/core/views/screen/splash_view.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route<dynamic>? generatedRoute(RouteSettings route) {
    switch (route.name) {
      case '/home':
        return MaterialPageRoute(builder: (ctx) => HomeView());

      case '/onboarding':
        return MaterialPageRoute(builder: (ctx) => OnBordingView());

      case '/splash':
        return MaterialPageRoute(builder: (ctx) => SplashView());
      case '/cars':
        return MaterialPageRoute(builder: (ctx) => CarsView());
      case '/women':
        return MaterialPageRoute(builder: (ctx) => WomenView());
      case '/motors':
        return MaterialPageRoute(builder: (ctx) => MotorsView());
      case '/sport':
        return MaterialPageRoute(builder: (ctx) => SportView());
      case '/electronic':
        return MaterialPageRoute(builder: (ctx) => ElectronicView());
      case '/homeCatg':
        return MaterialPageRoute(builder: (ctx) => HomeCatgView());
      case '/product':
        return MaterialPageRoute(builder: (ctx) => ProductView());
      case '/add_advr':
        return MaterialPageRoute(builder: (ctx) => AddAdvsrtismintView());
    }
  }
}
