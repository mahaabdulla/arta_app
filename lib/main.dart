import 'package:arta_app/core/utils/myblocobserver.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/helper/shared_preference_helper.dart';
import 'material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}
