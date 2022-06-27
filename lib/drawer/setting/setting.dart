import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safari/drawer/drawer.dart';
import 'package:safari/theme/colors/color_bloc.dart';
import 'package:safari/theme/colors/color_state.dart';
class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  //bool isSwitched = true;
  bool isSwitched1 = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ColorCubit,ColorState>(
        listener:(context,state){},
    builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'setting',
              ),
              leading: DrawerWidget(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'change mode',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text(
                        'Light',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(width: 10,),
                      Switch(
                        value: ColorCubit.get(context).isDark,
                        onChanged: (value){
                          setState(() {
                            ColorCubit.get(context).changeAppMode();
                            ColorCubit.get(context).isDark = value;
                          });
                        },
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Dark',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'change language',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text(
                        'Arabic',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(width: 10,),
                      Switch(
                        value: isSwitched1,
                        onChanged: (value){
                          setState(() {
                            isSwitched1 = value;
                          });
                        },
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'English',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
    },
   );
  }
}
