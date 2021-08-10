import 'package:doctoworld_doctor/Locale/language_cubit.dart';
import 'package:doctoworld_doctor/cubit/auth_cubit.dart';
import 'package:doctoworld_doctor/cubit/profile_cubit.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';

List<BlocProviderSingleChildWidget> blocProviders = [
  BlocProvider<AuthCubit>(
    create: (context) => AuthCubit(),
  ),
  BlocProvider<LanguageCubit>(
    create: (context) => LanguageCubit(),
  ),
  BlocProvider<ProfileCubit>(
    create: (context) => ProfileCubit(),
  ),
];
