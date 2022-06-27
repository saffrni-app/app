
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:safari/StartScreen/StartScreen.dart';



class MyTrip extends StatefulWidget {
  const MyTrip({Key? key}) : super(key: key);

  @override
  State<MyTrip> createState() => _MyTripState();
}

class _MyTripState extends State<MyTrip> {

  final items = [Country("Saudi Arabia", "sa"),Country("Syria", "sy"), Country("Egypt", "eg")]; //just add the name and code(in small letters) of the Country

   Country? Choice;     // to save the choice of the "From"  DropDownButton
   Country? Helper;     // to help swap the values of "From" and "To" DropDownButtons
   Country? Choice2;    // to save the choice of the "To"  DropDownButton
   bool Chosen= false; // to Chnage the color of the date when the user chooses a new date
   int Adults=1;
   int Kids=0;
   int Infants=0;
   int rooms=1;
   bool Hotel= false;
   bool Plane= false;
   String? Class;
   double X=0;



   DateTimeRange dateTimeRange= DateTimeRange(start: DateTime.now(),
       end: (DateTime.now()).add(new Duration(days: 7))); // the date that will be displayed before the user choose a new date range

  @override
  Widget build(BuildContext context) {
    double Height= (MediaQuery.of(context).size.height+120)+X;
    return Scaffold(
      body: ListView(children: [
        Container(
          height: Height,
          color:Colors.lightBlueAccent,
          //Color.fromRGBO(104, 111, 129,1),
          child: Stack(
          children: [
            Positioned(top:0,left: 0,right: 0,
                child: Image.asset("images/Trip Planning 1.gif")),
            Positioned(top: 0,left:110,right:100,child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Plan Your Journey",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
            )),
            Positioned(top:250,left:0,right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(mainAxisSize: MainAxisSize.min,children: [
                      Row(
                        children:[
                          Column(
                            children: [
                              Icon(Icons.flight_takeoff),
                              Padding(
                                padding: const EdgeInsets.only(top:8.0),
                                child: Text("From",textAlign: TextAlign.center, style: TextStyle(fontSize: 12),),
                              )
                            ],
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton2<Country>(iconSize: 0,
                                  dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                  selectedItemHighlightColor: Colors.greenAccent[300],
                                  hint: Text("Pick A Country"),
                                  value: Choice,
                                  onChanged: (value){
                                    setState(() {
                                      Choice=value;
                                    });},
                                  items: items.map((item) => DropdownMenuItem<Country>(value:item,child: CountryWidget(item))).toList(),
                                )
                            ),
                          ),],
                      ), //The "From" DropDownButton
                      Row(children: [
                        Expanded(flex:10,child: Divider(color: Colors.grey,height: 5)),
                        Container(height: 45,width: 45,
                            child: FloatingActionButton(onPressed: (){setState(() {
                              Helper=Choice;
                              Choice=Choice2;
                              Choice2=Helper;
                            });},
                              backgroundColor: Colors.amber,
                              child: Icon(Icons.swap_vert,color: Colors.white,),
                              foregroundColor: Colors.black45,)),
                        Expanded(child: Divider(color: Colors.grey,height: 5)),

                      ],), // divider with swap values
                      Row(
                        children:[
                          Column(
                            children: [
                              Icon(Icons.flight_land_outlined),
                              Padding(
                                padding: const EdgeInsets.only(top:8.0),
                                child: Text("To",textAlign: TextAlign.center, style: TextStyle(fontSize: 12),),
                              )
                            ],
                          ),
                          SizedBox(width:28),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton2<Country>(iconSize: 0,
                                  dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                  selectedItemHighlightColor: Colors.greenAccent[300],
                                  hint: Text("Pick A Country"),
                                  value: Choice2,
                                  onChanged: (value){
                                    setState(() {
                                      Choice2=value;

                                    });},
                                  items: items.map((item) => DropdownMenuItem<Country>(value:item,child: CountryWidget(item))).toList(),
                                )
                            ),
                          ),],
                      ),// The "To" DropDownButton
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Divider(color: Colors.grey,height: 5),
                      ), //simple divider
                      InkWell(
                          child: Container(height: 60,
                            child: Row(children: [
                              Icon(Icons.date_range),
                              SizedBox(width: 40),
                              Column(children: [
                                Text("Leaving Date",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black54),),
                                SizedBox(height: 20,),
                                Text(dateTimeRange.start.toString().split(' ')[0],style: TextStyle(fontWeight:FontWeight.w400,color: Chosen?Colors.lightBlue:Colors.black45),)
                              ],),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: VerticalDivider(width: 20,thickness: 2,),
                              ),
                              Column(children: [
                                Text("Return Date",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black54),),
                                SizedBox(height: 20,),
                                Text(dateTimeRange.end.toString().split(' ')[0],style: TextStyle(fontWeight: FontWeight.w400,color:Chosen? Colors.lightBlue:Colors.black45))
                              ]),

                            ],),
                          ),
                          onTap: PickDateRange
                      ), // the container is necessary for the vertical divider
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Divider(color: Colors.grey,height: 5),
                      ), //simple divider
                      Row(
                        children: [
                          Icon(Icons.people),
                          Expanded(child: Theme( data: ThemeData(dividerColor: Colors.transparent),
                            child: ExpansionTile(onExpansionChanged: (value){
                              setState(() {
                                if(value==true)
                                  X+=220;
                                else
                                  X-=220;

                              });
                            },textColor: Colors.green,iconColor: Colors.green,title: Text("Number Of Travellers",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w400),),childrenPadding:EdgeInsets.all(8),children: [
                              Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Icon(Icons.man),
                                        Text("Adults"),
                                        Text("(older than 12 Year old)", style: TextStyle(color: Colors.lightBlue,fontSize: 10 ),)
                                      ],
                                    ),
                                  ),
                                   Spacer(),
                                  Row(mainAxisAlignment: MainAxisAlignment.end,children: [SizedBox(width: 30, height: 30,
                                    child: FloatingActionButton(backgroundColor: Colors.amber,child: Icon(Icons.add),onPressed: (){
                                      setState(() {
                                        Adults++;
                                      });}),
                                  ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("$Adults"),
                                    ),
                                    SizedBox( width: 30,height: 30,
                                      child: FloatingActionButton(backgroundColor: Colors.amber,child: Icon(Icons.remove),onPressed: (){setState(() {
                                        if(Adults>1)
                                          Adults--;
                                      });}),
                                    )])

                                ],),
                              Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(top: 8,left: 25.0,bottom: 8),
                                    child: Column(
                                      children: [
                                        Icon(Icons.boy),
                                        Text("Kids"),
                                        Text("(2 - 12 year old)", style: TextStyle(color: Colors.lightBlue,fontSize: 10 ),)
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Row(mainAxisAlignment: MainAxisAlignment.end,children: [SizedBox(width: 30, height: 30,
                                    child: FloatingActionButton(backgroundColor: Colors.amber,child: Icon(Icons.add),onPressed: (){
                                      setState(() {
                                        Kids++;
                                      });}),
                                  ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("$Kids"),
                                    ),
                                    SizedBox( width: 30,height: 30,
                                      child: FloatingActionButton(backgroundColor: Colors.amber,child: Icon(Icons.remove),onPressed: (){setState(() {
                                        if(Kids>0)
                                          Kids--;
                                      });}),
                                    )])

                                ],),
                              Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(top:8.0,),
                                    child: Column(
                                      children: [
                                        Icon(Icons.child_friendly),
                                        Text("Infants"),
                                        Text("(younger than 2 Year olds)", style: TextStyle(color: Colors.lightBlue,fontSize: 10 ))
                                      ],
                                    ),
                                  ),

                                  Spacer(),
                                  Row(mainAxisAlignment: MainAxisAlignment.end,children: [SizedBox(width: 30, height: 30,
                                    child: FloatingActionButton(backgroundColor: Colors.amber,child: Icon(Icons.add),onPressed: (){
                                      setState(() {
                                        Infants++;
                                      });}),
                                  ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("$Infants"),
                                    ),
                                    SizedBox( width: 30,height: 30,
                                      child: FloatingActionButton(backgroundColor: Colors.amber,child: Icon(Icons.remove),onPressed: (){setState(() {
                                        if(Infants>0)
                                          Infants--;
                                      });}),
                                    )])

                                ],),

                            ],),
                          )),


                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Divider(color: Colors.grey,height: 5),
                      ),
                      Row(
                        children: [
                          Icon(Icons.house),
                          Expanded(child: Theme( data: ThemeData(dividerColor: Colors.transparent),
                            child: ExpansionTile(onExpansionChanged: (value){
                              setState(() {
                                if(value==true)
                                  X+=120;
                                else
                                  X-=120;

                              });
                            },textColor: Colors.green,iconColor: Colors.green,
                              title: Text("Hotel Options",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w400),),
                              childrenPadding:EdgeInsets.all(8),
                              children: [
                                Row(
                                  children: [Text("Need A Place To Stay?"),
                                    Spacer(),
                                    Checkbox(value: Hotel,
                                      onChanged: (value){
                                      setState(() {
                                        Hotel=value!;

                                      });

                                      },),

                                  ],
                                ),
                                Visibility(
                                    visible:Hotel,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top:8.0,),
                                        child: Column(
                                          children: [
                                            Icon(Icons.king_bed_rounded),
                                            Text("Rooms"),
                                          ],
                                        ),
                                      ),
                                        Expanded(
                                        child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                            children: [SizedBox(width: 30, height: 30,
                                          child: FloatingActionButton(backgroundColor: Colors.amber,child: Icon(Icons.add),onPressed: (){
                                            setState(() {
                                              rooms++;
                                            });}),
                                        ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("$rooms"),
                                          ),
                                          SizedBox( width: 30,height: 30,
                                            child: FloatingActionButton(backgroundColor: Colors.amber,child: Icon(Icons.remove),onPressed: (){setState(() {
                                              if(rooms>1)
                                                rooms--;
                                            });}),
                                          )]),
                                      )

                                    ],),
                                ),
                            ],),
                          )),


                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Divider(color: Colors.grey,height: 5),
                      ),
                      Row(
                        children: [
                          Icon(Icons.airplanemode_active_rounded),
                          Expanded(child: Theme( data: ThemeData(dividerColor: Colors.transparent),
                            child: ExpansionTile(onExpansionChanged: (value){
                              setState(() {
                                if(value==true)
                                  X+=120;
                                else
                                  X-=120;

                              });
                            },textColor: Colors.green,iconColor: Colors.green,
                              title: Text("Flight Options",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w400),),
                              childrenPadding:EdgeInsets.all(8),
                              children: [
                                Row(
                                  children: [Text("Need To Book A Flight?"),
                                    Spacer(),
                                    Checkbox(value: Plane,
                                      onChanged: (value){
                                        setState(() {
                                          Plane=value!;

                                        });

                                      },),

                                  ],
                                ),
                                Visibility(
                                  visible:Plane,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top:8.0,),
                                        child: DropdownButtonHideUnderline(child:  DropdownButton2<String>(
                                          dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                          selectedItemHighlightColor: Colors.greenAccent[300],
                                          hint: Text("Class"),
                                          value: Class,
                                          onChanged: (value){
                                            setState(() {
                                              Class=value;


                                            });},
                                          items: [DropdownMenuItem(child: Text("Economy"),value:"Economy"),DropdownMenuItem(child: Text("Premium Economy"),value: "Premium Economy",),
                                            DropdownMenuItem(child: Text("Business Class"),value: "Business Class",),DropdownMenuItem(child: Text("First Class"),value: "First Class",)],
                                        ),
                                        ),
                                      ),


                                    ],),
                                ),
                              ],),
                          )),


                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Divider(color: Colors.grey,height: 5),
                      ),
                      MaterialButton(onPressed: (){
                        Navigator.push(context , MaterialPageRoute(builder: (context) => StartScreen()));
                      },
                        child: Container(height: 60,decoration: BoxDecoration(color: Colors.amberAccent,borderRadius: BorderRadius.circular(25)),
                          child: Center(child: Text("Let's Go !",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 26),)),),)
                    ],
                    ),
                  ),
                ),
              ),
            ),
          ],
      ),
        )],)
    );

  }
  
  Widget CountryWidget(Country country)
  {
    return Row(children: [
      CircleAvatar(backgroundImage: AssetImage("icons/flags/png/${country.Code}.png",package: 'country_icons')),
      SizedBox(width: 10,) ,
      Text(country.Name)],

    );
  }


  Future PickDateRange()async{
    DateTimeRange? newDateTimeRange= await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        saveText: "Choose"
    );
    if(newDateTimeRange== null)
      return ;

    setState(() {
      dateTimeRange= newDateTimeRange;
      Chosen=true;

    });

  }
}





class Country{
  
  final String Name;
  final String Code;

  Country( this.Name,this.Code);
  
}
