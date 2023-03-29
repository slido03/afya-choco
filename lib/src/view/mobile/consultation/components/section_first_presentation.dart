import 'package:flutter/material.dart';

/*
 * This class is used to display the first presentation of the app
*/
class FirstPresentation extends StatelessWidget {
  const FirstPresentation({super.key});

  // list of the features of the app
  final _fonctionnalites = const <String>[
    'Consulter les resulats devos analyses',
    'Prendre rendez-vous avec votre médecin',
    'Cosulter votre carnet de santé',
    'Consulter votre historique d\'analyses',
    'Consulter votre historique de rendez-vous',
    'Consulter votre historique de consultations',
    'Prendre en main votre agenda médical',
  ];

  Widget _salutation() {
    return RichText(
        text: const TextSpan(
      text: 'Bienvenue sur ',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontFamily: 'Roboto',
        fontStyle: FontStyle.italic,
      ),
      children: <TextSpan>[
        TextSpan(
          text: 'AFYA!!\n',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.italic,
          ),
        ),
        TextSpan(
          text: 'votre application de santé !\n',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    ));
  }

  Widget _fonctionnalite(String explication) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
        const SizedBox(width: 10.0),
        Wrap(
          children: [Text(
            explication,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          ]
        ),
      ],
    );
  }

  Widget _blocFonctionnalite(List<String> fonctionnalites) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '\nce que vous pouvez faire avec AFYA:\n\n',
          style: TextStyle(
              // apply theme colors
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline),
        ),
        for (var fonctionnalite in fonctionnalites)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: _fonctionnalite(fonctionnalite),
          ),
          
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      height: 200.0,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        color: Colors.green[300],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _salutation(),
          _blocFonctionnalite(_fonctionnalites),
        ],
      ),
    );
  }
}
