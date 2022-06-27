
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:safari/color.dart';


import 'more.dart';
class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  List<String> imageList = [
    'images/image1.jpg',
    'images/image2.jpg',
    'images/image3.jpg',
    'images/image4.jpg',
    'images/image5.jpg',
    'images/image6.jpg',
    'images/image7.jpg',
    'images/image8.jpg',
    'images/image9.jpg',
  ];

  List<Offer> offer = [
    Offer(image: 'images/play1.jpg',text: 'AAA',flag: 'plat1'),
    Offer(image: 'images/play2.jpg',text: 'AAA',flag: 'play2'),
    Offer(image: 'images/play3.jpg',text: 'AAA', flag: 'play3'),
    //Offer(image: 'images/rest1.jpg',text: 'AAA', flag: 'rest1'),
    Offer(image: 'images/hotel1.jpg',text: 'AAA', flag: 'hotel1'),
    Offer(image: 'images/hotel2.jpg',text: 'AAA', flag: 'hotel2'),
    Offer(image: 'images/hotel3.jpg',text: 'AAA',flag: 'hotel3'),
    Offer(image: 'images/food1.jpg',text: 'AAA',flag:'food1'),
    Offer(image: 'images/fly1.jpg',text: 'AAA',flag: 'fly1'),
    Offer(image: 'images/fly2.jpg',text: 'AAA', flag: 'fly2'),
  ];

  List<Tour> tour = [
    Tour(image: 'images/play1.jpg',title: 'AAA',description: 'j',price: '1',day: '1', flag: 'plat1'),
    Tour(image: 'images/play2.jpg',title: 'AAA',description: 'j',price: '1',day: '10', flag: 'play2'),
    Tour(image: 'images/play3.jpg',title: 'AAA', description: 'j',price: '1',day: '15', flag: 'play3'),
   // Tour(image: 'images/rest1.jpg',title: 'AAA',description: 'j',price: '1',day: '11',  flag: 'rest1'),
    Tour(image: 'images/hotel1.jpg',title: 'AAA',description: 'j',price: '1',day: '7',  flag: 'hotel1'),
    Tour(image: 'images/hotel2.jpg',title: 'AAA', description: 'j',price: '1',day: '3', flag: 'hotel2'),
    Tour(image: 'images/hotel3.jpg',title: 'AAA',description: 'j',price: '1',day: '8', flag: 'hotel3'),
    Tour(image: 'images/food1.jpg',title: 'AAA',description: 'j',price: '1',day: '4', flag:'food1'),
    Tour(image: 'images/fly1.jpg',title: 'AAA',description: 'j',price: '1',day: '6', flag: 'fly1'),
    Tour(image: 'images/fly2.jpg',title: 'AAA', description: 'j',price: '1',day: '9', flag: 'fly2'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.white,
      appBar: AppBar(
        backgroundColor: LightColors.cc,
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
          ),
          IconButton(
            tooltip: 'favorite',
            icon: Icon(Icons.favorite),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(height: 15.0,),
            _CarouselSlider(),
            SizedBox(height: 28.0,),
            _Offers(),
            SizedBox(height: 28.0,),
            _Tour(),
            SizedBox(height: 70,),
          ],
        ),
      ),


    );
  }

  Widget _CarouselSlider() {
    return CarouselSlider(items: imageList.map((e) =>
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(e, width: 200, height: 120, fit: BoxFit.cover,),
            ],
          ),
        )).toList(), options: CarouselOptions(
      autoPlayInterval: Duration(seconds: 3),
      autoPlay: true,
      enableInfiniteScroll: true,
      enlargeCenterPage: true,
      height: 250,
    ),);
  }

  Widget _Offers() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'OFFERS',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: LightColors.black,
          ),
        ),
        SizedBox(height: 1,),
        SingleChildScrollView(
          //scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: 150,
            child: ListView.builder(
              itemCount: offer.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index)=>Padding(
                padding: const EdgeInsets.only(right: 2,left: 2),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                     children: [
                         Ink.image(
                         image: AssetImage(offer[index].image),
                         child: InkWell(
                           onTap: (){},
                         ),
                         width: 100,
                         height: 150,
                         fit: BoxFit.cover,
                   ),
                       Positioned(
                         bottom: 0,
                         right: 0,
                         child: Container(
                            width: 100,
                           height: 150,
                           color: Colors.black54,
                           padding: EdgeInsets.all(10),
                           child: Center(
                               child: Text(
                                 offer[index].text,
                                 style: TextStyle(color: LightColors.blue),
                               ),
                           ),
                         ),
                         ),
              ],
             ),
                ),
              ),
             // SizedBox(width: 5,),
            ),
          ),


        ),
      ],
    );
  }

  Widget _Tour(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         ' TOURS',
         style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: LightColors.black,
      ),
    ),
        SizedBox(height: 1,),
        SingleChildScrollView(
          //scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: 300,
            child: Container(
              child: ListView.builder(
                itemCount: tour.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index)=> Padding(
                  padding: const EdgeInsets.only(right: 2,left: 2),
                  child: Card(
                    color: LightColors.grey,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                         // alignment: Alignment.center,
                          children: [
                            Image(
                              image: AssetImage(tour[index].image),
                              width: 200,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.all(15).copyWith(bottom: 0),
                          child: Column(
                            children: [
                                Text(
                                    tour[index].title,
                                     style: TextStyle(
                                       fontWeight: FontWeight.w800,
                                       fontSize: 20,
                                       color: LightColors.grey2,
                                     ),
                                 ),
                                SizedBox(height: 7,),
                                Text(
                                   ' ${tour[index].day} Days',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: LightColors.green,
                                    ),
                                ),
                              ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              child: Text('more'),
                              onPressed: (){},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
          ),
          ),
          ),
        ),
    ],
    );
  }
}


class Offer {
   String image;
   String text;
   String flag;
   Offer({
     required this.image,
     required this.text,
     required this.flag,
});
}

class Tour {
  String image;
  String title;
  String description;
  String price;
  String day;
  String flag;
  Tour({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.day,
    required this.flag,
});
}