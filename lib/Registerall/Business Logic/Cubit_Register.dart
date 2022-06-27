import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:safari/Registerall/Business%20Logic/States_Register.dart';
import 'package:safari/Registerall/Data%20Layer/Register_Model.dart';
import 'package:safari/Registerall/Data%20Layer/Regitser_Repository.dart';


class RegisterCubit extends Cubit<RegisterState>{

  RegisterModel data= RegisterModel();
  final RegisterRepository registerRepository;

  RegisterCubit(RegisterState initialState, this.registerRepository) :super(initialState);


  UpdateImage(File NewImage){
    this.data.Image= NewImage;
    print("Inside Cubit");
    emit(ImageLoaded(data.Image));
  }


  SendRequest(RegisterModel info)async{
    emit(LoadingState());
    // if(info.Image==null) {
    //   File f = await getImageFileFromAssets('images/default picture.jpg');
    //   info.Image= f;
    //   Future response = registerRepository.Register(info);
    //   response==200?emit(SuccessState(f)):emit(ErrorState());
    // }
    // else {
    //   Future response = registerRepository.Register(info);
    //   response == 200 ? emit(SuccessState(info.Image)) : emit(ErrorState());
    // }


  }


  // Future<File> getImageFileFromAssets(String path) async {
  //   final byteData = await rootBundle.load('assets/$path');
  //   final file = File('${(await getTemporaryDirectory()).path}/$path');
  //   await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //   return file;
  // }


}