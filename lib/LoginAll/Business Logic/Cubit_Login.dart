import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safari/LoginAll/Business%20Logic/States_Login.dart';
import '../Data Layer/Login_Model.dart';
import '../Data Layer/Login_Repository.dart';

class LoginCubit extends Cubit<LoginState>
{
  LoginModel loginModel = LoginModel();
  final LoginRepository loginRepository;
  LoginCubit(LoginState initialState, this.loginRepository) : super(initialState);

  SendRequest(LoginModel info)async{

    int status =loginRepository.Login(info);

    if(status==200) {
      print("inside bloc status 200");
      emit(AdminLoadingSucceccState());
    }

    else
      {
        print("inside bloc status 400");
        emit(LoadingErrorState(message: "An Error Occured"));
      }

  }

}