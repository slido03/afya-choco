import 'package:flutter/material.dart';
import '../../constant/afya_logo.dart';

class RdvTopBar extends StatefulWidget {
  const RdvTopBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RdvTopBarState createState() => _RdvTopBarState();
}

class _RdvTopBarState extends State<RdvTopBar> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 7,
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AfyaLogo(),
          ],
        ),
      ),
    );
  }
}
