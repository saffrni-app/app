

import 'package:safari/Registerall/Data%20Layer/Register_Model.dart';
import 'package:safari/Registerall/Data%20Layer/WebServices(API).dart';

class RegisterRepository{

  final AuthAPI RegisterAPI;

  RegisterRepository(this.RegisterAPI);


  // Future<List<Character>> GetAllCharacters() async{
  //   final Characters = await charactersAPI.GetAllCharacters();
  //   return Characters.map((SingleCharcter) =>Character.fromJson(SingleCharcter)).toList();
  // }


  Future Register(RegisterModel Model)async
  {
    Map<String,dynamic>Json= Model.RegisterToJson();
     await RegisterAPI.Register(Json);
     return 200;
  }


}