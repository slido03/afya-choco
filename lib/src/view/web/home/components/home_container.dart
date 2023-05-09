import 'package:flutter/material.dart';

class HomeContainer1 extends StatelessWidget {
  const HomeContainer1({Key? key}) : super(key: key);

  final List<String> infos = const [
    'AFYA votre application qui facilite la prise en charge medicale de vos patients.',
    'Vous pouvez gerer les informations medicales de vos patients.',
    'Vous pouvez gerer les demandes de rendez-vous de vos patients.',
    'Avec AFYA, vos patients sont plus proches de vous.',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //width: 700,
        height: 400,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(41, 41, 41, 0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < infos.length; i++)
                afya_information(i + 1, infos[i])
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget afya_information(int num, String info) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10,top: 10),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            color: const Color.fromRGBO(30, 82, 42, 1),
            child: Center(
                child: Text(
              num.toString(),
              style: const TextStyle(color: Colors.white),
            )),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Text(
              info,
              style: const TextStyle(fontSize: 20, color: Colors.white),
          ))
        ],
      ),
    );
  }
}
