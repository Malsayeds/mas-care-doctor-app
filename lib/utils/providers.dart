import 'package:doctoworld_doctor/Locale/language_cubit.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';

List<BlocProviderSingleChildWidget> blocProviders = [
  BlocProvider<LanguageCubit>(
    create: (context) => LanguageCubit(),
  ),
];
