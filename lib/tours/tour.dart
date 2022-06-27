import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_button/like_button.dart';
import 'package:safari/expanded/expandedwidget.dart';
import 'package:safari/main_screen/bloc_main/main_bloc.dart';
import 'package:safari/main_screen/bloc_main/main_event.dart';
import 'package:safari/main_screen/bloc_main/main_state.dart';
import 'package:safari/offers/offer.dart';
import 'package:safari/reviewmodle.dart';
import 'package:safari/stars/star.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';
class Tours extends StatefulWidget {
  // String image;
  // String name;
  // int stars;
  // int night;
  // int day;
  // int price;
  // int view;
  //int place;
  // int num;
  // int num2;
  // String description;
  // String include;
  // Tours({
  //   required this.image,
  //   required this.name,
  //   required this.stars,
  //   required this.night,
  //   required this.day,
  //   required this.price,
  //   required this.view,
  //   required this.place,
  //   required this.num,
  //   required this.num2,
  //   required this.description,
  //   required this.include,
  // });


  @override
  State<Tours> createState() => _ToursState();
}

class _ToursState extends State<Tours> {
  List<String> imageList = [
    'images/malaysia1.jpg',
    'images/malaysia2.jpg',
    'images/malaysia6.jpg',
    'images/malaysia7.jpg',
    'images/malaysia8.jpg',
    'images/malaysia9.jpg',
    'images/malaysia10.jpg',
    'images/malaysia11.jpg',
    'images/malaysia12.jpg',
  ];

  List<String> buttons=[
    'Detail',
    'reviews',
    'rate now',
  ];

  bool fav=false;
  int selectedindex=0;
  double rating=0;
  int currentIndex=0;
  bool isloved = false;
  int lovecount=0;
  final items=['report'];

 void customLaunch(command)async{
   if(await canLaunch(command)){
     await UrlLauncher.launch(command);
   }else{
     print('could not launch $command');
   }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.favorite),
        //     onPressed: (){
        //       fav=true;
        //     },
        //   ),
        // ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [

                _CarouselSlider(),

                SizedBox(height: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15,left: 5),
                      child: Column(
                        children: [
                         Padding(
                           padding: EdgeInsets.only(left: 30),
                           child: Column(
                             children: [
                               Row(
                                 children: [
                                   Text(
                                     'Malaysia',
                                     style: Theme.of(context).textTheme.headline1,
                                   ),
                                   SizedBox(width: 40,),
                                   Align(
                                     alignment: Alignment.topRight,
                                     child: IconTheme(
                                       data: IconThemeData(
                                         color: Colors.amber,
                                         size: 30,
                                       ),
                                       child: StarDisplay(value: 3),
                                     ),
                                   ),
                                   SizedBox(width: 20,),
                                   LikeButton(
                                     isLiked :isloved,
                                     // likeCount:lovecount,

                                     likeBuilder: (bool isLiked) {
                                       return Icon(
                                         Icons.favorite_outline,
                                         color: isLiked ? Colors.deepOrange: Colors.grey[700],
                                         size: 35.0,

                                       );
                                       onPressed: () {
                                         Navigator.pop(context);
                                       };
                                     },

                                   ),
                                 ],
                               ),
                               SizedBox(height: 12,),
                               Row(
                                 children: [
                                   Icon(
                                     Icons.location_pin,
                                     color: Colors.orangeAccent,size: 20,
                                   ),
                                   SizedBox(width: 12,),
                                   Text(
                                     "Brasillia",
                                     style: Theme.of(context).textTheme.headline6,
                                   ),

                                 ],
                               ),
                             ],
                           ),
                         ),
                          Column(
                            children: [
                              SizedBox(height: 15,),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                //color: Colors.black,
                                height: (MediaQuery.of(context).size.height)-750,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:buttons.length ,
                                    itemBuilder: (context,index){
                                      return _buildlist(context, index);

                                    }),

                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: SingleChildScrollView(
                              child: Column(children: [
                                SizedBox(height: 5,),
                                selectedindex==0?detail(): selectedindex==1?reviews():Rate(),
                              ],),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),

    );

  }

  Widget _CarouselSlider() {
    return CarouselSlider(items: imageList.map((e) =>
        ClipRRect(

          borderRadius: BorderRadius.only(bottomRight: Radius.circular(45),bottomLeft: Radius.circular(45),),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(e, width: double.infinity,fit: BoxFit.cover),
            ],
          ),
        )).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlayInterval: Duration(seconds: 4),
        autoPlay: true,
        enableInfiniteScroll: true,

        height: (MediaQuery.of(context).size.height)-480,
      ),
    );
  }
  ///list of buttons
  Widget _buildlist(BuildContext context,int index){
    Size size=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedindex=index;
        });

      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          //  height: 20,
//padding: EdgeInsets.symmetric(horizontal: 8,vertical: 20),
          width: size.width*0.25,
          decoration: BoxDecoration(
              color:selectedindex==index?Colors.orange: Colors.white70,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xffffdd9a))

          ),
          child: Center(
            child: Text(
              buttons[index],
              style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 16,
                color: selectedindex==index? Colors.white:Colors.orange,
              ),
            ),
          ),
        ),
      ),
    );

  }

  // Widget _buildlist(BuildContext context,int index){
  //   Size size=MediaQuery.of(context).size;
  //   return GestureDetector(
  //     onTap: (){
  //       setState(() {
  //         selectedindex=index;
  //       });
  //
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.only(right: 10),
  //       child: Container(
  //
  //         width: size.width*0.25,
  //         decoration: BoxDecoration(
  //           color:selectedindex==index?Colors.orange: Colors.grey[600],
  //           borderRadius: BorderRadius.circular(20),
  //
  //         ),
  //         child: Center(
  //           child: Text(
  //             buttons[index],
  //             style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 16,
  //                 color: selectedindex==index? Colors.white:Colors.white
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  //
  // }

  Widget detail(){
   return Column(
     children: [
       Padding(
         padding: EdgeInsets.only(left: 25,right: 25),
         child: Column(
           children: [
             SizedBox(height: 15,),
             Row(

               children: [
                 Text(
                   '8 ',
                   style: Theme.of(context).textTheme.headline4,
                 ),
                 Text(
                   ' Nights ',
                   style: Theme.of(context).textTheme.subtitle2,
                 ),
                 Text(
                   '9',
                   style: Theme.of(context).textTheme.headline4,
                 ),
                 Text(
                   ' Days',
                   style: Theme.of(context).textTheme.subtitle2,
                 ),
               ],
             ),
             SizedBox(height: 15,),
             Row(
               children: [
                 Align(
                   alignment: Alignment.topLeft,
                   child: Column(
                     // mainAxisAlignment: MainAxisAlignment.start,
                     //crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         'Price',
                         style: Theme.of(context).textTheme.subtitle2,
                       ),
                       SizedBox(height: 5,),
                       Text(
                         '125 D',
                         style: Theme.of(context).textTheme.headline4,
                       ),
                     ],
                   ),
                 ),
                 SizedBox(width: 60,),
                 Align(
                   alignment: Alignment.center,
                   child: Column(

                     children: [
                       Text(
                         'Likes',
                         style: Theme.of(context).textTheme.subtitle2,
                       ),
                       SizedBox(height: 5,),
                       Text(
                         '45K',
                         style: Theme.of(context).textTheme.headline4,
                       ),
                     ],
                   ),
                 ),
                 SizedBox(width: 60,),
                 Align(
                   alignment: Alignment.center,
                   child: Column(

                     children: [
                       Text(
                         'Places',
                         style: Theme.of(context).textTheme.subtitle2,
                       ),
                       SizedBox(height: 5,),
                       Text(
                         '43',
                         style: Theme.of(context).textTheme.headline4,
                       ),
                     ],
                   ),
                 ),
               ],
             ),
             SizedBox(height: 15,),
             Column(
               children: [
                 Align(
                   alignment: Alignment.topLeft,
                   child: Text(
                     'program',
                     style: Theme.of(context).textTheme.subtitle1,
                   ),
                 ),
                 SizedBox(height: 10,),
                 ExpandedWidget(
                   text:'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaasAAAaaaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaasAAAaaaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaasAAAaaa',

                 ),
               ],
             ),
             //SizedBox(height: 15,),
             SizedBox(height: 5,),
             Column(
               children: [
                 Align(
                   alignment: Alignment.topLeft,
                   child: Text(
                     'our program include',
                     style: Theme.of(context).textTheme.subtitle1,
                   ),
                 ),
                 SizedBox(height: 10,),
                 ExpandedWidget(
                   text:'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaasAAAaaaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaasAAAaaaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaasAAAaaaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaasAAAaaa',
                   //style: Theme.of(context).textTheme.button,
                 ),
               ],
             ),
             SizedBox(height: 15,),
             Align(
               alignment: Alignment.topLeft,
               child: Text(
                 'contact us',
                 style: Theme.of(context).textTheme.subtitle1,
               ),
             ),
             Row(
               children: [
                 Row(
                   children: [
                     IconButton(
                       icon: Icon(
                         Icons.call,
                         size: 25,
                         color: Theme.of(context).bottomAppBarColor,
                       ),
                       onPressed: (){
                         customLaunch('tel:+5465564');
                       },
                     ),
                     SizedBox(width: 10,),
                     Text(
                       '023156974',
                       style: Theme.of(context).textTheme.headline4,
                     ),
                   ],
                 ),
                 SizedBox(width: 20,),
                 Row(
                   children: [
                     IconButton(
                       icon: Icon(
                         Icons.sms,
                         size: 25,
                         color: Theme.of(context).bottomAppBarColor,
                       ),
                       onPressed: (){
                         customLaunch('sms:45455');
                       },
                     ),
                     SizedBox(width: 10,),
                     Text(
                       '023156974',
                       style: Theme.of(context).textTheme.headline4,
                     ),
                   ],
                 ),
               ],
             ),
           ],
         ),
       ),
       SizedBox(height: 5,),
       Padding(
         padding: const EdgeInsets.only(bottom: 10,),
         child: SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child: Row(
             children: [
               Container(
                 width: MediaQuery.of(context).size.width*0.30,
                 height: (MediaQuery.of(context).size.height)-740,
                 child: Center(
                   child: Text(
                     'Book now',
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 18,
                         color:Colors.white,
                     ),
                   ),
                 ),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(35),
                   color: Colors.orange,
                 ),
               ),
               SizedBox(width: 10,),
               Container(
                 width: MediaQuery.of(context).size.width*0.30,
                 height: (MediaQuery.of(context).size.height)-750,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(35),
                   color: Colors.grey[600],
                 ),
                 //color: Theme.of(context).cardColor,
                 child: MaterialButton(
                   child: Text(
                     'by bank',
                     style: TextStyle(
                       fontWeight: FontWeight.w800,
                       fontSize: 16,
                       color:Colors.white,
                     ),
                   ),
                   onPressed: (){},
                 ),
               ),
               SizedBox(width: 7,),
               Container(
                 width: MediaQuery.of(context).size.width*0.45,
                 height: (MediaQuery.of(context).size.height)-750,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(35),
                   color: Colors.grey[600],
                 ),
                 //color: Theme.of(context).cardColor,
                 child: MaterialButton(
                   child: Text(
                     'when we arrived',
                     style: TextStyle(
                       fontWeight: FontWeight.w800,
                       fontSize: 16,
                       color:Colors.white,
                     ),
                   ),
                   onPressed: (){},
                 ),
               ),
             ],
           ),
         ),
       ),
     ],
   );
  }

  Widget reviews(){
    bool isless=false;
    bool isMore = false;
    var select='bmw';
    List<String>itemss=['report'];
    List<double> ratings = [0.1, 0.3, 0.5, 0.7, 0.9];
    return SingleChildScrollView(

      child: Container(
        child: Column(
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8,),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "4.5",
                            style: TextStyle(fontSize: 48.0,color:Colors.indigo,),
                          ),
                          TextSpan(
                            text: "/5",
                            style: TextStyle(
                              fontSize: 24.0,
                              color:Color(0xffffdd9a),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10,),
                    //عرض التقييم عن طريق النجمات
                    StarDisplay( value: 4,),

                    SizedBox(height: 16.0),
                    Text(
                      "${reviewList.length} Reviews",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20,),
                //عرض نسبة التقييمات لكل عدد من النجمات لحالها

                Container(
                  height: 120,
                  width:160,
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(width: 4.0),
                          Icon(Icons.star, color: Color(0xffffdd9a)),
                          SizedBox(width: 4.0),
                          // LinearPercentIndicator(
                          //   lineHeight: 6.0,
                          //   linearStrokeCap: LinearStrokeCap.roundAll,
                          //   width: MediaQuery.of(context).size.width / 2.8,
                          //   animation: true,
                          //   animationDuration: 2500,
                          //   percent: ratings[index],
                          //   progressColor: Colors.indigo,
                          // ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            //Text("mkjl",style: TextStyle(fontSize: 100),)

            ///reviewlist:هي ليست افتراضيى بتبعت للموديل المعلومات
            ///عرض التعليقات

            ListView.builder(
              physics: BouncingScrollPhysics(),

              //scrollDirection: Axis.horizontal,
              shrinkWrap: true,

              padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
              itemCount: reviewList.length,
              itemBuilder: (context, index) {
                return  Container(
                  padding: EdgeInsets.only(
                    top: 2.0,
                    bottom: 2.0,
                    left: 16.0,
                    right: 0.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 45.0,
                            width: 45.0,
                            margin: EdgeInsets.only(right: 16.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(reviewList[index].image),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(44.0),
                            ),
                          ),
                          Column(
                            children: [Text(
                              reviewList[index].name,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                              SizedBox(height: 8,),
                              Text(
                                reviewList[index].date,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 48),
                              child: DropdownButton(items:itemss.map((e) =>
                                  DropdownMenuItem(child:
                                  Text("$e"),
                                    value: e,
                                  )).toList(),
                                onChanged: (val){},
                                enableFeedback: false,
                                iconEnabledColor: Colors.orange,
                                iconDisabledColor: Colors.indigo,
                                elevation: 0,
                                borderRadius: BorderRadius.zero,
                              )
                            // IconButton(
                            //   onPressed:(){
                            //
                            //     setState(() {
                            //
                            //     });
                            //   },
                            //   icon: Icon(Icons.more_vert),
                            // ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.0),
                      Row(
                        children: [


                          SizedBox(width:10),

                        ],
                      ),
                      SizedBox(height: 8.0),
                      GestureDetector(
                          onTap: (){},
                          child: Text(
                            reviewList[index].comment,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          )

                      ),
                      Divider(thickness: 3,color: Colors.grey[200],indent: 20,endIndent: 20,)
                    ],
                  ),
                );

                // return ReviewUI(
                //   image: reviewList[index].image,
                //   name: reviewList[index].name,
                //   date: reviewList[index].date,
                //   comment: reviewList[index].comment,
                //   rating: reviewList[index].rating,
                //   onPressed: () => print("More Action $index"),
                //   onTap: () => setState(() {
                //     isMore = !isMore;
                //   }),
                //   isLess: isMore,
                // );
              },
              // itemBuilder: (context, index) {
              //      return Divider(
              //        thickness: 2.0,
              //        color: Colors.orangeAccent,
              //      );
              //    },
            ),

            //         Container(
            // child:SingleChildScrollView(
            //   child: Column(children: [
            //
            //   ],),
            // )
            //
            //            ),




          ],
        ),
      ),
    );
  }
  ///rate now start
  Widget Rate(){
    return Center(
      child: Column(
        children: [ratingg(),
          SizedBox(height: 20,),
          EnterComment(),
          SizedBox(height: 10,),

        ],
      ),
    );

  }
  Widget ratingg(){
    //double rating=0;
    return Center(child: Row(children: [
      RatingBar.builder(
        maxRating: 1,
        itemBuilder: (context,_)=>
            Icon(Icons.star,color: Colors.amber,size: 10,),
        onRatingUpdate: (rating)=>setState(() {
          this.rating=rating;
        }),
      ),
      SizedBox(width: 10,),
      Text('Rating: $rating',
        style:TextStyle(fontSize: 15) ,),


    ],)
    );
  }
  Widget EnterComment(){
    return Row(
      children: [
        Container(
          // alignment: Alignment.center,
          //margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          padding: EdgeInsets.only(left: 20 ),
          height: 54,
          width: 250,
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(50),
            color: Color(0xffEEEEEE),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 20),
                  blurRadius: 100,
                  color: Color(0xffEEEEEE)
              ),
            ],
          ),
          child: TextFormField(

            keyboardType: TextInputType.visiblePassword,

            cursorColor: Color(0xffF5591F),
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusColor: Color(0xffF5591F),

              hintText: "Enter Comment",


            ),
            onFieldSubmitted: (val){
              print(val);
            },


          ),

        ),
        SizedBox(width: 2,),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white38,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 20),
                  blurRadius: 100,
                  color: Colors.white70
              ),
            ],
          ),
          child: IconButton(onPressed: () {  },
            icon: Icon(Icons.comment_outlined,
              color: Colors.lightBlueAccent,),
          ),
        ),






      ],
    );


  }
///end
}
