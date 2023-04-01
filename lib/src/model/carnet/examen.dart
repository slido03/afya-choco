import '../models.dart';

class Examen {
  final DateTime _date;
  final Specialite _type;
  final Patient _patient;
  final Medecin _medecin;
  Map<String, String> _resultats; //structure à déterminer

  Examen(
    this._date,
    this._type,
    this._patient,
    this._medecin,
    this._resultats,
  );

  factory Examen.fromJson(Map<String, dynamic> json) {
    return Examen(
      DateTime.fromMillisecondsSinceEpoch(json['date']),
      parseType(json['type']),
      Patient.fromJson(json['patient']),
      Medecin.fromJson(json['medecin']),
      json['resultats'] as Map<String, String>,
    );
  }

  DateTime get date => _date;
  Specialite get type => _type;
  Patient get patient => _patient;
  Medecin get medecin => _medecin;
  Map<String, String> get resultats => _resultats;

  void setResultats(Map<String, String> resultats) => _resultats = resultats;

  Map<String, dynamic> toJson() => {
        'date': date.millisecondsSinceEpoch,
        'type': type.name,
        'patient': patient.toJson(),
        'medecin': medecin.toJson(),
        'resultats': resultats,
      };

  static Specialite parseType(String name) {
    Specialite type =
        Specialite.values.firstWhere((t) => t.toString() == 'Specialite.$name');
    return type;
  }
}
