import 'package:arta_app/core/repositoris/online_repo.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_state.dart';
import 'package:arta_app/feature/presentations/cubits/change_password/change_password_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/commint/commints_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/presentations/cubits/login/login_cubit.dart';

List<BlocProvider> blocProviders = [
  BlocProvider(
    create: (_) => LoginCubit(OnlineDataRepo()),
  ),
  BlocProvider(
    create: (_) => ListingCubit(OnlineDataRepo()),
  ),
  BlocProvider(
    create: (_) => ChangePasswordCubit(OnlineDataRepo()),
  ),
  BlocProvider(
    create: (_) => CommintsCubit(OnlineDataRepo()),
  ),
];
