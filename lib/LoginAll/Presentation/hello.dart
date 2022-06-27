import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safari/Registerall/Business%20Logic/Cubit_Register.dart';
import 'package:safari/Registerall/Business%20Logic/States_Register.dart';
import 'package:safari/Registerall/Data%20Layer/Regitser_Repository.dart';
import 'package:safari/Registerall/Data%20Layer/WebServices(API).dart';
import 'package:safari/Registerall/Presentation/Register_Screen.dart';
import 'package:safari/Registerall/Presentation/Widgets/Loading_State.dart';




import '../../homelayout/homelayout.dart';

import '../Business Logic/Cubit_Login.dart';
import '../Business Logic/States_Login.dart';
import '../Data Layer/Login_Model.dart';
import '../Data Layer/Login_Repository.dart';


class myLogin extends StatefulWidget {
  @override
  State<myLogin> createState() => _myLoginState();
}

class _myLoginState extends State<myLogin> {
  final formKey = GlobalKey<FormState>();

  var passoredcontroller = TextEditingController();

  var emailcontroller = TextEditingController();



  bool obscureText = true;
  bool obscureText2 = true;
  bool isPassword = true;

  LoginModel loginModel = LoginModel();

  LoginRepository loginRepository= LoginRepository(AuthAPI());

  RegisterRepository registerRepository=RegisterRepository(AuthAPI());


  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context){
return Scaffold(
body: SafeArea(
child: SingleChildScrollView(
  child:   Form(
    key: formKey,
    child: Column(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90),),
               color:  Color(0xffef5422),
              image: DecorationImage(fit: BoxFit.cover,
                  image: AssetImage('images/airplane - Copy.gif'))
          ),

        ),
        Container(
          child: BlocProvider(
            create: (BuildContext context)=> LoginCubit(LoginInitState(),loginRepository),
            child: BlocConsumer<LoginCubit,LoginState>(listener:(context, state) {

              if(state is AdminLoadingSucceccState)
                Navigator.pushAndRemoveUntil(context , MaterialPageRoute(builder: (context) => HomeLayout()),(route) => false);

               if (state is LoadingErrorState)
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(state.message)));


            },builder: (context,state){
        if(state is LoginLoading)
        return LoadingWidget();

        // if (state is LoadingErrorState)
        //    return Center(child: Text(state.message));

        else
        return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            SizedBox(
              height: 5.0,
            ),
        Text(
        'Login',
        style: TextStyle(
        color: Colors.orange,
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
        ),
        ),

        SizedBox(
        height: 5.0,
        ),

            Email(),
        SizedBox(
        height: 10,
        ),
            password(),

        SizedBox(
        height: 30,
        ),
        Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            padding: EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.center,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [(new  Color(0xffF5591F)), new Color(0xffF2861E)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight
        ),borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: Color(0xffEEEEEE)
              ),
            ],
        ),
        //width: double.infinity,

        child: MaterialButton(
        onPressed: (){
        if (formKey.currentState!.validate()) {

        print("Button Clicked");

        this.loginModel.Email=emailcontroller.text;
        this.loginModel.Password=passoredcontroller.text;
        BlocProvider.of<LoginCubit>(context).SendRequest(loginModel);

        }
        },
        child: Text(
        'Login',
        style: TextStyle(color: Colors.white),
        ),
        ),
        ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center
              ,children: [
              Text("don't have an account ?"),
                TextButton(onPressed: (){Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(create: (BuildContext context)=>RegisterCubit(initialState(),registerRepository),child: Register()),
                    ));}
              ,child: Text("Register Now")),

            ],)

        ],
        );

        }),
          ),

        )


      ],
    ),
  ),
),
),


);

  }
  _outlineBorder({Color? borderColor}) {
    if (borderColor == null)
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
      );
    else
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: borderColor),
      );
  }
  Widget Email(){

      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xffEEEEEE)
            ),
          ],
        ),
        child: TextFormField(
          controller: emailcontroller,
          keyboardType: TextInputType.emailAddress,

          cursorColor: Color(0xffF5591F),

          onFieldSubmitted: (value){
            print(value);
          },

          validator: (value){
            if(value!.isEmpty||!value.contains('@')||!value.contains('.com')){
              return 'email address required';
            }
            return null;
          },


          decoration: InputDecoration(
            icon: Icon(
              Icons.email,
              color: Color(0xffF5591F),
            ),

            hintText: "Enter Email",
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      );

  }
  Widget password(){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(0xffEEEEEE),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 20),
              blurRadius: 100,
              color: Color(0xffEEEEEE)          ),
        ],
      ),
      child: TextFormField(
        controller: passoredcontroller,
        obscureText: obscureText,
        keyboardType: TextInputType.visiblePassword,

        cursorColor: Color(0xffF5591F),
        decoration: InputDecoration(
          focusColor: Color(0xffF5591F),
          icon: Icon(
            Icons.vpn_key,
            color: Color(0xffF5591F),
          ),
          hintText: "Enter Password",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: (){
              setState(() {
                isPassword = ! isPassword;
              });
            },
            icon: Icon(
              isPassword ? Icons.visibility : Icons.visibility_off,
              color: Color(0xffF5591F),
            ),
          ),
        ),
        onFieldSubmitted: (value){
          print(value);
        },
        validator: (value){
          if(value!.isEmpty){
            return 'password must not be empty';

          }
          return null;
        },
      ),
      // enabledBorder: InputBorder.none,
      //   focusedBorder: InputBorder.none,
    );

  }
  }

