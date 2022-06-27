import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:safari/Forums/Data%20Layer/Comment_Model.dart';
import 'package:safari/bottomnavigationbar/question.dart';
import 'package:safari/Forums/Forums.dart';
import 'package:safari/color.dart';
import 'package:safari/expanded/expandedfour.dart';



import 'Business Logic/Forums_Cubit.dart';
import 'Business Logic/Forums_States.dart';

class QuestionReplies extends StatefulWidget {
  final Comment comment;
  const QuestionReplies({Key? key, required this.comment}) : super(key: key);

  @override
  State<QuestionReplies> createState() => _QuestionRepliesState(this.comment);
}

class _QuestionRepliesState extends State<QuestionReplies> {
  bool isloved=false;


  @override
  void initState() {
    BlocProvider.of<ForumsCubit>(context).GetAllCharacters() as List<Comment>;
  }
  final Comment comment;
  List<Comment>replies =[];
  TextEditingController commentcontroler = TextEditingController();

  _QuestionRepliesState(this.comment);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:LightColors.cc,

        appBar: AppBar(iconTheme: IconThemeData(color: LightColors.bb),
          backgroundColor: LightColors.white,
          elevation: 0,

            ),
      body:Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QuestionItem(comment),
          Expanded(
            child: BlocBuilder<ForumsCubit,ForumsStates>(builder: (context,state)
            {
              if (state is CommentsLoaded)
              {
                replies = state.Comments.reversed.toList();//must change that
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                      itemBuilder: (context, index) =>
                          Reply(replies[index])
                      ,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10,),
                      itemCount: replies.length),
                );
              }
              else
                return Center(child: CircularProgressIndicator(color: LightColors.bb,));
            }
            ),
          ),
          Container( child:
      Row(children:[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(

                controller:commentcontroler ,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius:BorderRadius.circular(40)),
                  hintText: "add a reply ...",hintStyle: TextStyle(fontSize:19,color: LightColors.bb ),

                )
            ),
          ),
        ) ,    Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: LightColors.bb,
            child: IconButton(icon:Icon(Icons.send_outlined,color:LightColors.white,size: 20,),
              onPressed: (){
                BlocProvider.of<ForumsCubit>(context).SendQuestion(commentcontroler.text);
                commentcontroler.clear();
              },),
          ),
        ),
        ],
      ),
      )
            ])
           );
          }

  Widget Reply (Comment comment){
    if(comment.Username==this.comment.Username)
      return Row(
        children: [
          Expanded(
            child: Bubble(margin: BubbleEdges.only(top:10),
            alignment: Alignment.topRight,
            nip: BubbleNip.rightCenter,
            nipHeight: 10,
            nipWidth: 10,
            child: Padding(
              padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
              child: Text(comment.message,style: TextStyle(fontSize: 18,color: Colors.white),textAlign: TextAlign.end,),
            ),
            color: LightColors.bb,),
          ),
         CircleAvatar(backgroundImage: NetworkImage(comment.ImageURL),radius: 25,)
        ],
      );

    else
      return Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(comment.ImageURL),radius: 25,),
          Expanded(
            child: Bubble(margin: BubbleEdges.only(top:10),
              alignment: Alignment.topLeft,
              nip: BubbleNip.leftCenter,
              nipHeight: 10,
              nipWidth: 10,
              child: Padding(
                padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                child: Text(comment.message,style: TextStyle(fontSize: 18,color: Colors.white),textAlign: TextAlign.start,),
              ),
              color: Colors.lightBlue,),
          ),

        ],
      );

  }



  Widget QuestionItem(Comment comment){
    return ClipRRect(
      borderRadius:BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
      child: Container(
        decoration: BoxDecoration(color: LightColors.white),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(comment.ImageURL),),
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      Text("@"+comment.Username, style: TextStyle(color: LightColors.bb),),
                      Text("26/10/2021", style: TextStyle(color: Colors.grey,fontSize: 10),),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(comment.message,style: TextStyle(color:LightColors.bb,fontWeight: FontWeight.w800,fontSize: 20),textAlign: TextAlign.center,),
              ),

              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LikeButton(
                      isLiked :isloved,
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          color: isLiked ? Colors.deepOrange: LightColors.black3,
                          size: 35.0,

                        );

                      },
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.mode_comment_rounded,color: LightColors.black3,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${BlocProvider.of<ForumsCubit>(context).Comments.length}",style: TextStyle(color: LightColors.bb,fontSize: 16),),
                  ),


                ],
              )

            ],
          ),
        ),),
    );

  }
}
