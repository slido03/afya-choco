import 'package:afya/src/view/web/consultation/components/saisie_identifiant.dart';
import 'package:flutter/material.dart';

class TopRdv extends StatefulWidget {
  const TopRdv({Key? key}) : super(key: key);

  @override
  _TopRdvState createState() => _TopRdvState();
}

class _TopRdvState extends State<TopRdv> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 100,
        width: 158,
        color: const Color.fromRGBO(37, 211, 102, 0.1),
         child: Padding(
           padding: const EdgeInsets.all(20.0),
           child: Expanded(
             child: Row(
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                  ),
                  onPressed: null,
                  child: const Text('3 Jours')
                 ),
                const SizedBox(width: 15,),
                OutlinedButton(
                   style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),)
                  ),
                  onPressed: null,
                  child: const Text('Semaine')
                 ),
                 const SizedBox(width : 15),
                OutlinedButton(
                   style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),)
                  ),
                  onPressed: null,
                  child: const Text('Mois')
                 ),
                 const SizedBox(width : 125),
                 //const SaisieIdentifiant(),
              ]
             ),
           ),
         ),
      ),
    );
  }
}