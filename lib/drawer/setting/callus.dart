import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';
class Numbers extends StatefulWidget {
  const Numbers({Key? key}) : super(key: key);

  @override
  _NumbersState createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {
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
        title: Text(
          'call us',

        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20,right: 10,left: 15,bottom: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'call us to f,flffgk',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                height: (MediaQuery.of(context).size.height)-690,
                color: Colors.grey[100],
                child: Row(
                  children: [
                    Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.add_ic_call,
                          size: 25,
                          color: Theme.of(context).bottomAppBarColor,
                        ),
                        onPressed: (){
                          customLaunch('tel:+5465564');
                        },
                      ),
                    ),
                    SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,top: 20),
                      child: Column(
                        children: [
                          Text(
                            '0978746621',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Text(
                              'initial',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}