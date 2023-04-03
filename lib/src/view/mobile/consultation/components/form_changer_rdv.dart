import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'button_cancel.dart';
import 'button_submit.dart';
import 'rdv_dialog.dart';
import 'select_rdv.dart';
import 'input_text_area.dart';

/*
 * This is a form that is used to change a rendez-vous. the last one for préférence.
 */
class FormChangerRdv extends StatefulWidget {
  const FormChangerRdv({super.key, this.rdv});

  // getting the rdv from the database can be
  final Map<String, dynamic>? rdv;

  @override
  State<FormChangerRdv> createState() => _FormChangerRdvState();
}

class _FormChangerRdvState extends State<FormChangerRdv> {
  late bool _isGoodRdv;

  @override
  initState() {
    super.initState();
    _isGoodRdv = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRdvDialog(context);
    });
  }

  Future<void> showRdvDialog(BuildContext context) async {
    final Widget dialog = RdvDialog(rdv: widget.rdv);

    final isGoodRdv_ = await showDialog<bool?>(
          context: context,
          builder: (BuildContext context) {
            return dialog;
          },
        ) ??
        false;

    setState(() {
      _isGoodRdv = isGoodRdv_;
      if (kDebugMode) {
        print('isGoodRdv_ = $_isGoodRdv');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // appel de la fonction showRdvDialog une fois que build est appelé et est terminé
    var size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          Visibility(
            visible: !_isGoodRdv,
            child: SelectRdv(
              rdvs: const [
                {
                  'id': 1,
                  'date': '01 Jan',
                  "medecin": "Dr. Jean",
                },
                {
                  'id': 2,
                  'date': '01 Jan',
                  "medecin": "Dr. koko",
                },
                {'id': 3, 'date': '01 Jan', "medecin": "Dr. kiki"},
                {'id': 4, 'date': '01 Jan', "medecin": "Dr. kaka"},
                {'id': 5, 'date': '01 Jan', "medecin": "Dr. kuku"},
                {'id': 6, 'date': '01 Jan', "medecin": "Dr. kiki"},
                {'id': 7, 'date': '01 Jan', "medecin": "Dr. koukou"}
              ],
              maxwidth: size.width * 0.95,
            ),
          ),
          InputTextArea(
            labelText: "message",
            hintText: "quel est le motif de votre demande ?",
            maxwidth: size.width * 0.95,
          ),
          Container(
            width: size.width * 0.95,
            margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                ButtonCancel(),
                SizedBox(width: 20),
                ButtonSubmit(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
