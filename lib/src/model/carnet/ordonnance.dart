import '../models.dart';

class Ordonnance {
  final DateTime _date;
  final Medecin _medecin;
  final Patient _patient;
  final Diagnostic _diagnostic;
  Map<String, String> _instructions; //structure à déterminer

  Ordonnance(
    this._date,
    this._medecin,
    this._patient,
    this._diagnostic,
    this._instructions,
  );

  factory Ordonnance.fromJson(Map<String, dynamic> json) {
    return Ordonnance(
      DateTime.parse(json['date']),
      Medecin.fromJson(json['medecin']),
      Patient.fromJson(json['patient']),
      Diagnostic.fromJson(json['diagnostic']),
      json['instructions'] as Map<String, String>,
    );
  }

  DateTime get date => _date;
  Medecin get medecin => _medecin;
  Patient get patient => _patient;
  Diagnostic get diagnostic => _diagnostic;
  Map<String, String> get instructions => _instructions;

  void setInstructions(Map<String, String> instructions) =>
      _instructions = instructions;

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'médecin': medecin.toJson(),
        'patient': patient.toJson(),
        'diagnostic': diagnostic.toJson(),
        'instructions': instructions,
      };
}
