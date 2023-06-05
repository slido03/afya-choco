import '../models.dart';
import 'package:faker/faker.dart';

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
    Map<String, String> instructions = json['instructions'].map((key, value) {
      return MapEntry(key, value.toString());
    }).cast<String, String>();
    return Ordonnance(
      DateTime.fromMillisecondsSinceEpoch(json['date']),
      Medecin.fromJson(json['medecin']),
      Patient.fromJson(json['patient']),
      Diagnostic.fromJson(json['diagnostic']),
      instructions,
    );
  }

  factory Ordonnance.faker(
    Medecin medecin,
    Patient patient,
    Diagnostic diagnostic,
  ) {
    var faker = Faker();
    var date = faker.date.dateTime(minYear: 2022, maxYear: 2024);
    var instructions = {
      'Repos médical': faker.lorem.word(),
      'Vitamine C': faker.lorem.word(),
      "Doliprane": faker.lorem.word(),
      'Artemisia': faker.lorem.sentence(),
    };
    return Ordonnance(
      date,
      medecin,
      patient,
      diagnostic,
      instructions,
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
        'date': date.millisecondsSinceEpoch,
        'medecin': medecin.toJson(),
        'patient': patient.toJson(),
        'diagnostic': diagnostic.toJson(),
        'instructions': instructions,
      };
}
