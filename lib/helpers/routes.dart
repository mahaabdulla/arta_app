import 'package:arta_app/feature/ads/presition/views/add_advsrtismint.dart';
import 'package:arta_app/feature/ads/presition/views/my_ads.dart';
import 'package:arta_app/core/views/screen/catg_views/cars.dart';
import 'package:arta_app/core/views/screen/catg_views/electronuc.dart';
import 'package:arta_app/core/views/screen/catg_views/home_catg.dart';
import 'package:arta_app/core/views/screen/catg_views/morev_view.dart';
import 'package:arta_app/core/views/screen/catg_views/motors.dart';
import 'package:arta_app/core/views/screen/catg_views/real_state.dart';
import 'package:arta_app/core/views/screen/catg_views/sport.dart';
import 'package:arta_app/core/views/screen/catg_views/women.dart';
import 'package:arta_app/feature/home/presention/view/home_view.dart';
import 'package:arta_app/feature/on_boreding/presintion/views/onbording.dart';
import 'package:arta_app/core/views/screen/products_view/product_details_view.dart';
import 'package:arta_app/feature/splash/presention/splash_view.dart';
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
      case '/real_estate':
        return MaterialPageRoute(builder: (ctx) => RealStateView());
      case '/more':
        return MaterialPageRoute(builder: (ctx) => MorevView());
      case '/product':
        return MaterialPageRoute(builder: (ctx) => ProductDetailsView());
      case '/add_advr':
        return MaterialPageRoute(builder: (ctx) => AddAdvertisementView());
      case '/my_ads':
        return MaterialPageRoute(builder: (ctx) => MyAds());
    }
  }
}
