import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:safari/StartScreen/StartScreenApi/StartScreen(Api).dart';
import 'package:safari/animation/animateroute.dart';
import 'package:safari/expanded/expandedfour.dart';
import 'package:safari/offers/offer.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  List<dynamic> imagelist = [
    // 'images/malaysia1.jpg',
    // 'images/malaysia2.jpg',
    // 'images/malaysia6.jpg',
    // 'images/malaysia7.jpg',
    // 'images/malaysia8.jpg',
    // 'images/malaysia9.jpg',
  ];

  List<Option> buttons = [
    Option('Hotels', Icons.home),
    Option('Flight Companies', Icons.flight_rounded),
    Option('Restaurants', Icons.restaurant_menu_rounded),
    Option('Transportaions', Icons.local_taxi),
    Option('Landmarks', Icons.landscape)
  ];
  int selectedindex = 0;

  static String BaseUrl = "http://192.168.169.81:8000/";

  StartApi ss = StartApi();

  getImages() async {
    imagelist = await ss.GetImages();
    print("something" + imagelist.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _CarouselSlider(),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 70,
                // height:  (MediaQuery.of(context).size.height)-800,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: buttons.length,
                    itemBuilder: (context, index) {
                      return _buildlist(context, index);
                    }),
              ),
              PlacesList(),
            ],
          ),
        ));
  }

  Widget _CarouselSlider() {
    return CarouselSlider(
      items: imagelist
          .map((e) => ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(45),
                  bottomLeft: Radius.circular(45),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    InteractiveViewer(
                      maxScale: 4,
                      child: Image.network(BaseUrl+ e,
                          width: double.infinity, fit: BoxFit.cover),
                    )
                  ],
                ),
              ))
          .toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlayInterval: Duration(seconds: 4),
        autoPlay: true,
        enableInfiniteScroll: true,
        height: (MediaQuery.of(context).size.height) - 500,
      ),
    );
  }

  Widget _buildlist(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedindex = index;
          getImages();
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          decoration: BoxDecoration(
              color: selectedindex == index ? Colors.pink : Colors.white70,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black12, width: 3)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Icon(buttons[index].icon,
                    color: selectedindex == index ? Colors.white : Colors.grey),
                SizedBox(width: 5),
                Text(
                  buttons[index].Name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: selectedindex == index ? Colors.white : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget PlacesList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 25, left: 16, right: 16),
        child: StaggeredGridView.countBuilder(
          padding: EdgeInsets.zero,
          crossAxisCount: 2,
          itemCount: imagelist.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.of(context).push(SlideRight(Page: Hotel()));
            },
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(BaseUrl + imagelist[index]),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey, width: 4)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color((0x00000000)),
                              const Color((0xCC000000)),
                              const Color((0xCC000000)),
                              const Color((0xCC000000))
                            ]),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(22),
                            bottomRight: Radius.circular(22))),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("text here",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          staggeredTileBuilder: (index) =>
              StaggeredTile.count(1, index.isEven ? 1.5 : 1.0),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
      ),
    );
  }
}

class Option {
  final String Name;
  final IconData icon;

  Option(this.Name, this.icon);
}
