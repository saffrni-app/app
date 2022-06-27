import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safari/localization/l10n.dart';

import 'package:safari/splashscreen.dart';
import 'package:safari/theme/colors/color.dart';
import 'package:safari/drawer/drawer.dart';
import 'package:safari/homelayout/bloc/home_bloc.dart';
import 'package:safari/homelayout/bloc/home_state.dart';
import 'package:safari/theme/colors/color_bloc.dart';
import 'package:safari/theme/theme.dart';

import 'homelayout/homelayout.dart';
import 'theme/colors/color_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ColorCubit(),
        child: BlocConsumer<ColorCubit,ColorState>(
          listener:(context,state){},
          builder: (context,state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ColorCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
             // supportedLocales: L10n.all,

              home: SplashScreen(),//const MyHomePage(title: 'Flutter Demo Home Page'),
            );
         },
        ),
    );
  }
}






