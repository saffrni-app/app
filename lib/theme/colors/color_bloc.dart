import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safari/theme/colors/color_state.dart';


class ColorCubit extends Cubit<ColorState>{
  ColorCubit() : super(ColorInitialState());

  static ColorCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode(){
      isDark = !isDark;
      emit(ColorChangeState());
  }

}

