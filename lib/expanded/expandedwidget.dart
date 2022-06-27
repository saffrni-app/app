import 'package:flutter/material.dart';
class ExpandedWidget extends StatefulWidget {
  final String text;
  const ExpandedWidget({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandedWidgetState createState() => _ExpandedWidgetState();
}


class _ExpandedWidgetState extends State<ExpandedWidget> {
  late String firsthalf;
  late String secondhalf;
  @override
  void initState() {

    super.initState();
    if (widget.text.length>50){
      firsthalf=widget.text.substring(0,50);
      secondhalf=widget.text.substring(51,widget.text.length);
    }else{
      firsthalf=widget.text;
      secondhalf="";
    }
  }
  bool flag=true;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        child:secondhalf.length==""?
        Text(widget.text,style: Theme.of(context).textTheme.bodyText1,):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
                flag?firsthalf:widget.text,
              style: Theme.of(context).textTheme.bodyText1,
            ),

            InkWell(
              onTap: (){
                print("tapped");
                setState(() {
                  flag=!flag;
                });
              },
              child:   Row(
                children: [
                  Text(
                    flag ? "Show more" : "Show less",
                    style: TextStyle(color: Colors.orange,fontSize:16 ),),
                  Icon(flag?Icons.keyboard_arrow_down:Icons.keyboard_arrow_up,color: Colors.amber,),
                ],
              ),
            ),

          ],
        )
        ,
      ),
    );
  }
}
