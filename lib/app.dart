import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_eating/blocs/dai_diet_bloc.dart';
import 'package:healthy_eating/blocs/remote_config_bloc.dart';
import 'package:healthy_eating/config/app_colors.dart';
import 'package:healthy_eating/ui/pages/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DayDietBloc()),
        BlocProvider(create: (_) => RemoteConfigBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.greenDark,
            centerTitle: true,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            isDense: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greenDark),
            ),
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
