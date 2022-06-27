
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safari/Forums/Business%20Logic/Forums_Cubit.dart';
import 'package:safari/Forums/Data%20Layer/CommentsAPI.dart';
import 'package:safari/Forums/Replies.dart';
import 'package:safari/LoginAll/Presentation/hello.dart';



import '../LoginAll/Business Logic/Cubit_Login.dart';
import '../color.dart';
import 'Business Logic/Forums_States.dart';
import 'Data Layer/Comment_Model.dart';
import 'Data Layer/Comment_Repository.dart';

class Forums extends StatefulWidget {
  const Forums({Key? key}) : super(key: key);

  @override
  State<Forums> createState() => _ForumsState();
}

class _ForumsState extends State<Forums> {

  List<Comment>Comments =[];
  TextEditingController commentcontroler = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<ForumsCubit>(context).GetAllCharacters() as List<Comment>;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true,appBar: AppBar(centerTitle: true,title: Text("Forums"),backgroundColor: LightColors.bb,),
    body:Container(color: LightColors.cc
      ,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 16, left: 16, right: 16),
            child: Container(child:
            Row(children:[
              CircleAvatar(
                radius: 30,
                backgroundColor: LightColors.cc,
                backgroundImage: AssetImage("images/Default Picture .jpg"),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.go,
                    controller:commentcontroler ,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderRadius:BorderRadius.circular(20)),
                      hintText: "Add A Question ...",hintStyle: TextStyle(fontSize:19 ),

                    ),onFieldSubmitted: (value){ BlocProvider.of<ForumsCubit>(context).SendQuestion(value);
                  commentcontroler.clear();
                  },
                  ),
                ),
              ) ,
            ],
            ) ,
            ),
          ),
          Expanded(
            child: BlocBuilder<ForumsCubit,ForumsStates>(
              builder: (context, state) {
                if(state is CommentsLoaded)
                {
                  Comments=state.Comments;
                  print(Comments.length);
                  return ListView.separated(itemBuilder:
                      (context, index)=>MaterialButton(onPressed: () {
                    print('Item clicked');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (BuildContext context)=>ForumsCubit(ForumsInitialState(),CommentsRepository(CommentsAPI())),child: QuestionReplies(comment: Comments[index]))));
                  },
                      child:QuestionItem(Comments[index]))
                      ,separatorBuilder: (context,index)=>SizedBox(height: 10), itemCount:Comments.length);
                }
                else
                  return Center(child: CircularProgressIndicator(color: LightColors.bb,));

              }),
          ),
        ],
      ),
    ),
    );
  }

  Widget QuestionItem(Comment comment){
    return Container(constraints: BoxConstraints(minHeight: 200, minWidth: 500),
      decoration: BoxDecoration(color: LightColors.white,borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor:LightColors.aa,radius: 27,
                child: CircleAvatar(backgroundImage: NetworkImage(comment.ImageURL),radius: 25)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text("@"+comment.Username, style: TextStyle(color: LightColors.bb,fontSize: 12),),
                  Text("26/10/2021", style: TextStyle(color: Colors.grey,fontSize: 12),),
                ],
              ),
            ),

              ],
                ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20 ,right: 20),
          child: Text(comment.message,style: TextStyle(color: LightColors.bb),textAlign: TextAlign.center,),

        )),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.mode_comment_rounded,color: LightColors.bb,size: 18,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${BlocProvider.of<ForumsCubit>(context).Comments.length}",style: TextStyle(color: LightColors.bb,fontSize: 16),),
          ),
              ],
            ),
          ]
        ),
      )
    );

  }
}


