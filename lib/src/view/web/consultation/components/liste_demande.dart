import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ListeDemande extends StatelessWidget {
    ListeDemande({super.key,});

   List<Map<String, dynamic>> demandes = [
    {
      'date':  DateTime(2023, 3, 26),
      'heure': '12:00',
      'sender': 'Monsieur Jean',
      'description': 'Maux de tete atroce, besoin de prise en charge',
      'readed': false,
    },
     {
      'date':  DateTime(2023, 3, 26),
      'heure': '12:00',
      'sender': 'Monsieur Jean',
      'description': 'Maux de tete atroce, besoin de prise en charge',
      'readed': true,
    }, {
      'date':  DateTime(2023, 3, 26),
      'heure': '12:00',
      'sender': 'Monsieur Jean',
      'description': 'Maux de tete atroce, besoin de prise en charge',
      'readed': true,
    }, {
      'date':  DateTime(2023, 3, 26),
      'heure': '12:00',
      'sender': 'Monsieur Jean',
      'description': 'Maux de tete atroce, besoin de prise en charge',
      'readed': false,
    }, {
      'date':  DateTime(2023, 3, 26),
      'heure': '12:00',
      'sender': 'Monsieur Jean',
      'description': 'Maux de tete atroce, besoin de prise en charge',
      'readed': true,
    }, {
      'date':  DateTime(2023, 3, 26),
      'heure': '12:00',
      'sender': 'Monsieur Jean',
      'description': 'Maux de tete atroce, besoin de prise en charge',
      'readed': false,
    }, {
      'date':  DateTime(2023, 3, 26),
      'heure': '12:00',
      'sender': 'Monsieur Jean',
      'description': 'Maux de tete atroce, besoin de prise en charge',
      'readed': false,
    }, {
      'date':  DateTime(2023, 3, 26),
      'heure': '12:00',
      'sender': 'Monsieur Jean',
      'description': 'Maux de tete atroce, besoin de prise en charge',
      'readed': false,
    },
     {
      'date':  DateTime(2023, 3, 26),
      'heure': '12:00',
      'sender': 'Monsieur Jean',
      'description': 'Maux de tete atroce, besoin de prise en charge',
      'readed': false,
    },
     {
      'date':  DateTime(2023, 3, 26),
      'heure': '12:00',
      'sender': 'Monsieur Jean',
      'description': 'Maux de tete atroce, besoin de prise en charge',
      'readed': false,
    },
     {
      'date':  DateTime(2023, 3, 26),
      'heure': '12:00',
      'sender': 'Monsieur Jean',
      'description': 'Maux de tete atroce, besoin de prise en charge',
      'readed': false,
    },
     {
      'date':  DateTime(2023, 3, 26),
      'heure': '12:00',
      'sender': 'Monsieur Jean',
      'description': 'Maux de tete atroce, besoin de prise en charge',
      'readed': false,
    },
    

  ];

  @override
  Widget build(BuildContext context) {
    return demandes.isEmpty ?
    const Center(
      child: Text('Pas de demande', style: TextStyle(color: Colors.black),)
    ):
    ListView.builder(
      //shrinkWrap: true,
      itemCount: demandes.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            dense: true,
            title : Text(DateFormat('dd/MM/yyyy').format(demandes[index]['date']), style: const TextStyle(fontSize: 12),),
            subtitle:Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(demandes[index]['sender'], style: const TextStyle(fontWeight: FontWeight.bold),),
                Text(demandes[index]['description'], style: const TextStyle(fontSize: 12),),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(demandes[index]['heure'], textAlign: TextAlign.end, style: const TextStyle(fontSize: 10),),
                const SizedBox(width: 10,),
                demandes[index]['readed']? const SizedBox() : const Icon(Icons.circle, size: 10, color: Colors.green,),

              ],
            )
          )
        );
      },
    );
  }
}
