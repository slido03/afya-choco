import '../models.dart';

class Ordonnance {
  final int _id;
  final DateTime _date;
  final Medecin _medecin;
  final Patient _patient;
  final Diagnostic _diagnostic;
  Map<String, String> _instructions;

  Ordonnance(
    this._id,
    this._date,
    this._medecin,
    this._patient,
    this._diagnostic,
    this._instructions,
  );

  int get id => _id;
  DateTime get date => _date;
  Medecin get medecin => _medecin;
  Patient get patient => _patient;
  Diagnostic get diagnostic => _diagnostic;
  Map<String, String> get instructions => _instructions;

  void setInstructions(Map<String, String> instructions) =>
      _instructions = instructions;
}
