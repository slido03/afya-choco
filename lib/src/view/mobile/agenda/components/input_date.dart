import 'package:flutter/material.dart';

// import for formatting the date
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

/*
  * This class is a widget that displays the date input
  * and the date picker
*/
class InputDate extends StatefulWidget {
  const InputDate({
    super.key,
    this.maxwidth,
    required String labelText,
    required String hintText,
    required this.controller,
    required this.initialDate,
  });

  final double? maxwidth;
  final TextEditingController controller;
  final DateTime initialDate;

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _date = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        widget.controller.text = formatDate(_date);
      });
    }
  }

  formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: FormField(
        builder: (FormFieldState state) {
          return InputDecorator(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Date',
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
            isEmpty: _date == null,
            child: InkWell(
              onTap: () => _selectDate(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(formatDate(_date)),
                  const Icon(Icons.calendar_today, color: Colors.black87),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
