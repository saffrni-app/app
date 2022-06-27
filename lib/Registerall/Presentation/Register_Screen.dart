import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safari/LoginAll/Presentation/hello.dart';
import 'package:safari/Registerall/Business%20Logic/Cubit_Register.dart';
import 'package:safari/Registerall/Business%20Logic/States_Register.dart';
import 'package:safari/Registerall/Data%20Layer/Register_Model.dart';
import 'package:safari/Registerall/Data%20Layer/Regitser_Repository.dart';
import 'package:safari/Registerall/Data%20Layer/WebServices(API).dart';
import 'package:safari/Registerall/Presentation/Widgets/DisplayPicture.dart';
import 'package:safari/Registerall/Presentation/Widgets/Loading_State.dart';



class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  var passoredcontroler = TextEditingController();

  var emailcontroler = TextEditingController();

  var ImageControler = TextEditingController();

  var namecontroler = TextEditingController();

  var phonecontroler = TextEditingController();

  bool obscureText = true;

  late File UserImage;

  final Picker =ImagePicker();

  RegisterModel registerModel = RegisterModel();




  Future getImage(ImageSource src) async{
    final PickedFile = await Picker.pickImage(source: src);
    setState(() {
      if (PickedFile!=null)
      {
        UserImage = File(PickedFile.path);
        BlocProvider.of<RegisterCubit>(context).UpdateImage(UserImage);
        this.registerModel.Image=UserImage;
        print("image loaded");
      }
      else
        print("Could not get photo");

    });
  }

  @override
  void initState() {
    //BlocProvider.of<RegisterCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(

                      /// اللون للخلفية الببضاء مع شفافية 10%
                      color: Colors.white.withOpacity(0.10),

                      /// تدوير الحواف
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: BlocBuilder<RegisterCubit,RegisterState>(builder: (context,state){

                      if(state is LoadingState)
                        return LoadingWidget();

                      if(state is SuccessState)
                        return DisplayPicture(DisplayPhoto: state.profileImage);

                      else
                         return Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text(
                               'Register',
                               style: TextStyle(
                                 color: Colors.orange,
                                 fontSize: 35.0,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             SizedBox(
                               height: 20.0,
                             ),
                             InkWell(child: ClipOval(
                                 child: Container(width:100, height:100,
                                   child: BlocBuilder<RegisterCubit,RegisterState>(builder:(context,state){
                                     if(state is ImageLoaded)
                                       return Image.file(state.ProfileImage,fit: BoxFit.fill,);

                                     return Image.asset("images/Default Picture .jpg",fit :BoxFit.fill);
                                   }),
                                 )) ,onTap: (){
                               showDialog(context: context, builder: (BuildContext context){  return new AlertDialog(title: Text("Choose Picture From"),
                                 content: Container(height :150,color: Colors.white,child:
                                 Column(children: [
                                   Container(color: Colors.orange,child: ListTile(leading: Icon(Icons.image),title: Text('Gallery'),onTap: ()
                                   {
                                     getImage(ImageSource.gallery);
                                     Navigator.of(context).pop();
                                   },),),
                                   SizedBox(height: 30,),
                                   Container(color: Colors.orange,child: ListTile(leading: Icon(Icons.add_a_photo),title: Text('Camera'),onTap: (){
                                     getImage(ImageSource.camera);
                                     Navigator.of(context).pop();
                                   },),),
                                 ],)),);});
                             },),
                             SizedBox(
                               height: 20.0,
                             ),
                             TextFormField(
                               controller: namecontroler,
                               keyboardType: TextInputType.name,
                               onFieldSubmitted: (String value) {
                                 print(value);
                               },
                               onChanged: (String value) {
                                 print(value);
                               },
                               decoration: InputDecoration(
                                 focusColor: Colors.purple,
                                 labelText: 'Name',
                                 prefixIcon:
                                 Icon(Icons.drive_file_rename_outline_rounded),
                                 border: _outlineBorder(),

                                 /// دالة الborder يلي بتخلي مدور بس استدعيا
                                 /// في حال بدي الborder بغير لون بس  جواتا borderColor
                                 /// الError لونو أحمر مثلا
                                 enabledBorder: _outlineBorder(),
                                 focusedBorder: _outlineBorder(
                                   // borderColor: AppColors.darkBlue,
                                 ),
                                 disabledBorder: _outlineBorder(),
                               ),

                               /// تحت مشان ايمت نطلع الرسالة الحمرا
                               /// وشو الرسالة لبدنا نطلعا
                               validator: (value) {
                                 /// اذا فاضية بترجع رسالة عبي الداتا
                                 if ((value ?? '').isEmpty) return "Fill the value";
                                 return null;
                               },
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             TextFormField(
                               keyboardType: TextInputType.phone,
                               controller: phonecontroler,
                               decoration: InputDecoration(
                                 labelText: ' Phone ',
                                 prefixIcon: Icon(Icons.phone),
                                 border: _outlineBorder(),
                                 enabledBorder: _outlineBorder(),
                                 focusedBorder: _outlineBorder(
                                   // borderColor: AppColors.darkBlue,
                                 ),
                                 disabledBorder: _outlineBorder(),
                               ),
                               validator: (value) {
                                 /// اذا فاضية بترجع رسالة عبي الداتا
                                 if ((value ?? '').isEmpty) return "Fill the value";
                                 return null;
                               },
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             TextFormField(
                               keyboardType: TextInputType.emailAddress,
                               controller: emailcontroler,
                               decoration: InputDecoration(
                                 labelText: 'Email',
                                 prefixIcon: Icon(Icons.email),
                                 border: _outlineBorder(),
                                 enabledBorder: _outlineBorder(),
                                 focusedBorder: _outlineBorder(
                                   // borderColor: AppColors.darkBlue,
                                 ),
                                 disabledBorder: _outlineBorder(),
                               ),
                               validator: (value) {
                                 /// اذا فاضية بترجع رسالة عبي الداتا
                                 if ((value ?? '').isEmpty) return "Fill the value";
                                 return null;
                               },
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             TextFormField(
                               controller: passoredcontroler,
                               obscureText: obscureText,
                               keyboardType: TextInputType.visiblePassword,
                               decoration: InputDecoration(
                                 labelText: 'Password',
                                 prefixIcon: Icon(Icons.lock),
                                 suffixIcon: IconButton(
                                     onPressed: () {
                                       setState(() {
                                         obscureText = !obscureText;
                                       });
                                     },
                                     icon: Icon(obscureText
                                         ? Icons.visibility
                                         : Icons.visibility_off)),
                                 border: _outlineBorder(),

                                 /// دالة الborder يلي بتخلي مدور بس استدعيا
                                 /// في حال بدك الborder بغير لون بس  جواتا borderColor
                                 /// الError لونو أحمر مثلا
                                 enabledBorder: _outlineBorder(),
                                 focusedBorder: _outlineBorder(
                                   // borderColor: AppColors.darkBlue,
                                 ),
                                 disabledBorder: _outlineBorder(),
                               ),
                               validator: (value) {
                                 /// اذا فاضية بترجع رسالة عبي الداتا
                                 if ((value ?? '').isEmpty) return "Fill the value";
                                 return null;
                               },
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             TextFormField(
                               obscureText: obscureText,
                               keyboardType: TextInputType.visiblePassword,
                               decoration: InputDecoration(
                                 labelText: 'Confirm Password',
                                 prefixIcon: Icon(Icons.lock),
                                 suffixIcon: IconButton(
                                     onPressed: () {
                                       setState(() {
                                         obscureText = !obscureText;
                                       });
                                     },
                                     icon: Icon(obscureText
                                         ? Icons.visibility
                                         : Icons.visibility_off)),
                                 border: _outlineBorder(),

                                 /// دالة الborder يلي بتخلي مدور بس استدعيا
                                 /// في حال بدك الborder بغير لون بس  جواتا borderColor
                                 /// الError لونو أحمر مثلا
                                 enabledBorder: _outlineBorder(),
                                 focusedBorder: _outlineBorder(
                                   // borderColor: AppColors.darkBlue,
                                 ),
                                 disabledBorder: _outlineBorder(),
                               ),
                               validator: (value) {
                                 /// اذا فاضية بترجع رسالة عبي الداتا
                                 if ((value ?? '').isEmpty) return "Fill the value";

                                 if (value == passoredcontroler.text) return null;
                                 return "Password and confirm password do not match";
                               },
                             ),
                             SizedBox(
                               height: 30,
                             ),
                             Container(
                               decoration: BoxDecoration(color:Colors.orange,borderRadius: BorderRadius.circular(10)
                               ),
                               width: double.infinity,
                               child: MaterialButton(
                                 onPressed: (){
                                   if (formKey.currentState!.validate()) {

                                     print("Button Clicked");
                                     this.registerModel.Name=namecontroler.text;
                                     this.registerModel.Phone= phonecontroler.text;
                                     this.registerModel.Email=emailcontroler.text;
                                     this.registerModel.Password=phonecontroler.text;
                                     BlocProvider.of<RegisterCubit>(context).SendRequest(registerModel);

                                   }
                                 },
                                 child: Text(
                                   'Register',
                                   style: TextStyle(color: Colors.white),
                                 ),
                               ),
                             ),
                             Row(mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center
                               ,children: [
                                 Text("Already have an account ?"),
                                 TextButton(onPressed: (){Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                       builder: (context) => myLogin(),
                                     ));}
                                     ,child: Text("Login")),

                               ],)
                           ],
                         );

                    }),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// هاد التابع يلي بخلي الحواف مدورة
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
}