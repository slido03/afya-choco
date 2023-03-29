import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key, required this.datas});

  final Map<String, dynamic> datas;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: datas['readed']
          ? Colors.white
          : const Color.fromARGB(255, 231, 248, 232),
      //margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                datas['date'],
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
              Text(
                datas['heure'],
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),

          // title
          Text(
            datas['title'],
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          // description of notification

          Text(
            datas['description'],
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
