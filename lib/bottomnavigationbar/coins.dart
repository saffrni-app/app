import 'package:flutter/material.dart';
class Coins extends StatelessWidget {
  const Coins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'coins',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
                Icons.favorite,

            ),
            onPressed: (){
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'coins',
        ),
      ),
    );
  }
}
