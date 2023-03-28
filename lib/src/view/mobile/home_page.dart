import 'package:flutter/material.dart';

// importing the top app bar and bottom nav bar

import 'top_app_bar.dart';
import 'bottom_nav_bar.dart';
import 'consultation/components/banner_carousel.dart';
import 'consultation/components/section_first_presentation.dart';
import 'consultation/components/menu_dialog_consultation.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    return Scaffold(
      appBar: TopAppBar(title: 'AFYA'),
      body: Center(
          child: Column(
        //mainAxisAlignment: MainAxisAlignment.,
        children: const <Widget>[
          SizedBox(height: 20.0),
          BannerCarousel(),
          //InputTextArea(labelText: "nom", hintText: "entrez votre messgae"),
          //InputDate(),
          /*Text(
                ":) Hello AFYA !!",
                style: TextStyle(fontSize: 30.0),
              ),*/
          SizedBox(height: 10.0),
          Expanded(child: FirstPresentation()),
        ],
      )),

      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSimpleDialog(context);
        },
        tooltip: 'new consultation',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}