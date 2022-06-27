import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:safari/drawer/setting/about_us.dart';
import 'package:safari/drawer/setting/account.dart';
import 'package:safari/drawer/setting/contact_us.dart';
import 'package:safari/drawer/setting/setting.dart';

import 'package:safari/theme/colors/color.dart';
import 'package:safari/homelayout/homelayout.dart';
import 'package:safari/main_screen/main_screen.dart';

import '../LoginAll/Presentation/hello.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: DrawerScreen(setIndex: (index) {
        setState(() {
          currentIndex = index;


        });
      },),
      mainScreen: currentScreen(),
      borderRadius: 30,
      //showShadow: true,

      angle: 0.0,
      slideWidth: (MediaQuery.of(context).size.height)-570,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      menuBackgroundColor: Theme.of(context).canvasColor,

    );
  }

  Widget currentScreen() {
    // return Main();
    switch(currentIndex) {
      case 0:
        return HomeLayout();
      case 1:
        return myLogin();

      case 2:
        return Setting();
      case 3:
        return AboutUs();
      case 4:
        return ContactUs();

      default:
        return HomeScreen();
    }
  }

}

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key? key, this.title = "Home"}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.title),
        centerTitle: true,
        leading: DrawerWidget(),
      ),
    );
  }
}

class DrawerScreen extends StatefulWidget {
  final ValueSetter setIndex;
  const DrawerScreen({Key? key, required this.setIndex}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(child:
          Container(
            child: Column(

              children: [
                CircleAvatar(child: Image.asset('images/malaysia1.jpg',),
                  maxRadius: 40,

                ),
                Text('flutter',style: Theme.of(context).textTheme.headline4,),
              ],),
          )),
          drawerList(Icons.home_outlined, "home", 0),
          Divider(),

          drawerList(
              Icons.perm_identity, "account", 1),

          Divider(),
          drawerList(Icons.settings, "settings", 2),
          Divider(),

          drawerList(Icons.people_outline, "about us", 3),
          Divider(),

          drawerList(Icons.call, "contact us", 4),
          Divider(),




          Spacer(),
          Padding(padding: const EdgeInsets.all(8),child: InkWell(child:Row(
            children: [
              Icon(Icons.exit_to_app,),
              SizedBox(width: 20,),
              Text('logout',style: Theme.of(context).textTheme.headline5,)
            ],
          )),),
          SizedBox(height: 30,)
        ],
      ),
    );
  }

  Widget drawerList(IconData icon, String text, int index) {
    return GestureDetector(

      onTap: () {
        widget.setIndex(index);
        ZoomDrawer.of(context)?.close();

      },

      child: Column(
        children: [

          Padding(padding: const EdgeInsets.all(8),child: InkWell(child:Row(
            children: [
              Icon(icon,color:Colors.white ,size: 25,),
              SizedBox(width: 10,),
              Text(text,style: Theme.of(context).textTheme.button,),
            ],
          )),),


        ],
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ZoomDrawer.of(context)!.toggle();
      },
      icon: Icon(Icons.menu,),
    );
  }
}

