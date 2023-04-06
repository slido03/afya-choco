import 'package:flutter/material.dart';
//import 'package:flutter_material_symbols/flutter_material_symbols.dart';

import 'package:introduction_screen/introduction_screen.dart';

import 'home_page.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);


  void navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) =>
              const HomePage(title: 'HomePage')), //à changer par la home page
    );
  }
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          titleWidget: const Center(
            child: Text(
              "Bienvenue sur Afya",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
                color: Colors.green,
              ),
            ),
          ),
          image: const Center(
            child: Icon(
              Icons.android,
              size: 100, 
              color: Colors.green,
            ),
          ),
          body: "Une application qui facilite votre vie hospitalière et médicale",
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            bodyTextStyle: TextStyle(fontSize: 18.0),
            pageColor: Colors.white,
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          titleWidget: const Center(
            child: Text(
              "Consultaion",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
                color: Colors.green,
              ),
            ),
          ),
          body: "Vous pouvez prendre rendez-vous avec votre médecin, demander des informations à votre Clinique ou à votre pharmacie, et bien plus encore.",
          image: const Center(
            child: Icon(
              //FlutterMaterialSymbols.calendar,
              Icons.medical_services_rounded,
              size: 100, 
              color: Colors.green,
            ),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            bodyTextStyle: TextStyle(fontSize: 18.0),
            pageColor: Colors.white,
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          titleWidget: const Center(
            child: Text(
              "Carnet de santé",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
                color: Colors.green,
              ),
            ),
          ),
          body: "Vous pouvez consulter votre dossier médical, vos résultats d'analyses, vos ordonnances, vos vaccins, et bien plus encore.",
          image: const Center(
            child: Icon(
              Icons.book,
              size: 100, 
              color: Colors.green,
            ),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            bodyTextStyle: TextStyle(fontSize: 18.0),
            pageColor: Colors.white,
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          titleWidget: const Center(
            child: Text(
              "Agenda médical",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
                color: Colors.green,
              ),
            ),
          ),
          body: "Vous pouvez consulter votre agenda médical, et avoir des rappels de vos rendez-vous, et bien plus encore.",
          image: const Center(
            child: Icon(
              Icons.calendar_month,
              size: 100, 
              color: Colors.green,
            ),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            bodyTextStyle: TextStyle(fontSize: 18.0),
            pageColor: Colors.white,
            imagePadding: EdgeInsets.zero,
          ),
        ),
      ],
      onDone: () => navigateToHome(context),
      onSkip: () => navigateToHome(context),
      showSkipButton: true,
      //showDoneButton: false,
      //showBackButton: true,
      skip: const Text("Passer"),
      done: const Text("Fait", style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      back: const Icon(Icons.arrow_back),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeColor: Colors.green,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  } 
}