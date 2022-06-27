import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safari/Forums/Business%20Logic/Forums_Cubit.dart';
import 'package:safari/Forums/Business%20Logic/Forums_States.dart';
import 'package:safari/Forums/Data%20Layer/Comment_Repository.dart';
import 'package:safari/Forums/Data%20Layer/CommentsAPI.dart';
import 'package:safari/Forums/Forums.dart';
import 'package:safari/bottomnavigationbar/MyTrip.dart';
import 'package:safari/bottomnavigationbar/coins.dart';
import 'package:safari/bottomnavigationbar/favorite.dart';
import 'package:safari/main_screen/main_screen.dart';
import 'package:safari/bottomnavigationbar/question.dart';
import 'package:safari/homelayout/bloc/home_state.dart';
import 'package:safari/mytrip/MyTrip.dart';

class AppCubit extends Cubit<AppState>{




  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);



  List<Widget> screens = [
    Favorite(),
    Coins(),
    Main(),
    BlocProvider(create:(BuildContext context)=>ForumsCubit(ForumsInitialState(),CommentsRepository(CommentsAPI())),child: Forums()),
    MyTrip(),
  ];
  //
  // final items = <Widget> [
  //   Center(child:Icon(Icons.favorite )),
  //   Center(child:Icon(Icons.attach_money , )),
  //   Center(child:Icon(Icons.home_rounded ,)),
  //   Center(child:Icon(Icons.edit ,)),
  //   Center(child:Icon(Icons.home_repair_service_rounded , )),
  // ];


  int currentIndex = 2;

  void changeIndex(int index){
    currentIndex = index;
    print(currentIndex);
    emit(AppChangeBottomNabBarState());
  }


}



