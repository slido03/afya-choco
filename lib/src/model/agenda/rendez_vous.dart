import '../models.dart';

class RendezVous {
  final int _id;
  DateTime _dateHeure;
  int _duree;
  final Patient _patient;
  final Medecin _medecin;
  String _lieu;
  final ObjetRendezVous _objet;
  StatutRendezVous _statut;

  RendezVous(
    this._id,
    this._dateHeure,
    this._duree,
    this._patient,
    this._medecin,
    this._lieu,
    this._objet,
    this._statut,
  );

  int get id => _id;
  DateTime get dateHeure => _dateHeure;
  int get duree => _duree;
  Patient get patient => _patient;
  Medecin get medecin => _medecin;
  String get lieu => _lieu;
  ObjetRendezVous get objet => _objet;
  StatutRendezVous get statut => _statut;

  void setDateHeure(DateTime dateHeure) => _dateHeure = dateHeure;
  void setDuree(int duree) => _duree = duree;
  void setLieu(String lieu) => _lieu = lieu;
  void setStatut(StatutRendezVous statut) => _statut = statut;
}
