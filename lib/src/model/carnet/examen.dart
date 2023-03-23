import '../models.dart';

class Examen {
  final int _id;
  DateTime _date;
  final Specialite _type;
  final Patient _patient;
  final Medecin _medecin;
  Map<String, String> _resultats;

  Examen(
    this._id,
    this._date,
    this._type,
    this._patient,
    this._medecin,
    this._resultats,
  );

  int get id => _id;
  DateTime get date => _date;
  Specialite get type => _type;
  Patient get patient => _patient;
  Medecin get medecin => _medecin;
  Map<String, String> get resultats => _resultats;

  void setDate(DateTime date) => _date = date;
  void setResultats(Map<String, String> resultats) => _resultats = resultats;
}
