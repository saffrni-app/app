import 'package:flutter/material.dart';
class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orange,
      child: SafeArea(
        child: Theme(
          data: ThemeData(
            brightness: Brightness.dark,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text('asdf'),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('home'),
                onTap: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}