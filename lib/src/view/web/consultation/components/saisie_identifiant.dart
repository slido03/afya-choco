import 'package:flutter/material.dart';

class SaisieIdentifiant extends StatefulWidget {
  const SaisieIdentifiant({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SaisieIdentifiantState createState() => _SaisieIdentifiantState();
}

class _SaisieIdentifiantState extends State<SaisieIdentifiant> {

  final TextEditingController _controller = TextEditingController(); 
  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(style: BorderStyle.solid, color: Colors.green, width: 3)
       ),
       padding: const EdgeInsets.all(15),
       child: Row(
          children: [
            const Icon(Icons.menu),
            //const SizedBox(width: 10,),
            Expanded(
              child: Card(
                elevation: 0.0,
                shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                ),
                color: Colors.white,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Entrez l\'identifiant du patient '
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30,),
            const Icon(Icons.search),
          ],
        ),
    );
  }
}

 