import 'package:arta_app/core/routes/routes_name.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/region_view.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/views/add_advsrtismint.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/views/my_ads.dart';
import 'package:arta_app/feature/presentations/pages/categorys/presintion/categury_details.dart';
import 'package:arta_app/feature/presentations/pages/categorys/presintion/views/cars.dart';
import 'package:arta_app/feature/presentations/pages/categorys/presintion/views/electronuc.dart';
import 'package:arta_app/feature/presentations/pages/categorys/presintion/views/home_catg.dart';
import 'package:arta_app/feature/presentations/pages/categorys/presintion/views/morev_view.dart';
import 'package:arta_app/feature/presentations/pages/categorys/presintion/views/motors.dart';
import 'package:arta_app/feature/presentations/pages/categorys/presintion/views/real_state.dart';
import 'package:arta_app/feature/presentations/pages/categorys/presintion/views/sport.dart';
import 'package:arta_app/feature/presentations/pages/categorys/presintion/views/women.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/view/home_view.dart';
import 'package:arta_app/feature/presentations/pages/login/login_screen.dart';
import 'package:arta_app/feature/presentations/pages/login/sginup_screen.dart';
import 'package:arta_app/feature/presentations/pages/on_boreding/presintion/views/onbording.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/widgets/product_details_view.dart';
import 'package:arta_app/feature/presentations/pages/splash/presention/splash_view.dart';
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
      final productId = route.arguments as int;
        return MaterialPageRoute(builder: (ctx) => ProductDetailsView(id: productId));
      case '/add_advr':
        return MaterialPageRoute(builder: (ctx) => AddAdvertisementView());
      case '/my_ads':
        return MaterialPageRoute(builder: (ctx) => MyAds());
        case SIGNUP:
        return MaterialPageRoute(builder: (ctx) => SginupScreen());
        case LOGIN:
        return MaterialPageRoute(builder: (ctx) => LoginScreen());
        case '/region':
         return MaterialPageRoute(builder: (ctx) => RegionView());
    
   case '/categoryDetails':
        final categoryId = route.arguments as int; 
        return MaterialPageRoute(
          builder: (ctx) => CategoryDetailPage(categoryId: categoryId),
        );

        
      default:
        return MaterialPageRoute(
          builder: (ctx) => Scaffold(
            body: Center(child: Text('الصفحة غير موجودة')),
          ),
        );
    }
  }
}
