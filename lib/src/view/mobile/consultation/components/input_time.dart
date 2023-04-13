import 'package:flutter/material.dart';

/*
  * This class is a widget that displays the time input
  * and the time picker
*/
class InputTime extends StatefulWidget {
  const InputTime({
    super.key,
    this.maxwidth,
    required String labelText,
    required String hintText,
    required this.controller,
  });

  final double? maxwidth;
  final TextEditingController controller;

  @override
  State<InputTime> createState() => _InputTimeState();
}

class _InputTimeState extends State<InputTime> {
  TimeOfDay _time = TimeOfDay.now();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        widget.controller.text = _time.timeFormatted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: FormField(builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Heure',
            labelStyle: TextStyle(
              color: Theme.of(context).primaryColorDark,
            ),
            errorStyle:
                const TextStyle(color: Colors.redAccent, fontSize: 16.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            constraints: BoxConstraints(
                maxHeight: 60.0, maxWidth: widget.maxwidth ?? 200.0),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          // ignore: unnecessary_null_comparison
          isEmpty: _time == null,
          child: InkWell(
            onTap: () => _selectTime(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(_time.timeFormatted),
                const Icon(Icons.timer, color: Colors.black87),
              ],
            ),
          ),
        );
      }),
    );
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String get timeFormatted {
    String? newHour;
    String? newMinute;
    if (hour < 10) {
      newHour = '0$hour';
    }
    newHour = '$hour';
    if (minute < 10) {
      newMinute = '0$minute';
    }
    newMinute = '$minute';
    return '$newHour:$newMinute';
  }
}
