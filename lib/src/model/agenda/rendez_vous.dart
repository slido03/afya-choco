import '../models.dart';

class RendezVous {
  DateTime _dateHeure;
  int _duree;
  final Patient _patient;
  final Medecin _medecin;
  String _lieu;
  final ObjetRendezVous _objet;
  StatutRendezVous _statut;

  RendezVous(
    this._dateHeure,
    this._duree,
    this._patient,
    this._medecin,
    this._lieu,
    this._objet,
    this._statut,
  );

  factory RendezVous.fromJson(Map<String, dynamic> json) {
    return RendezVous(
      DateTime.fromMillisecondsSinceEpoch(json['dateHeure']),
      json['duree'] as int,
      Patient.fromJson(json['patient']),
      Medecin.fromJson(json['medecin']),
      json['lieu'] as String,
      parseObjet(json['objet']),
      parseStatut(json['statut']),
    );
  }

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

  Map<String, dynamic> toJson() => {
        'dateHeure': dateHeure.millisecondsSinceEpoch,
        'duree': duree,
        'patient': patient.toJson(),
        'medecin': medecin.toJson(),
        'lieu': lieu,
        'objet': objet.name,
        'statut': statut.name,
      };

  static ObjetRendezVous parseObjet(String name) {
    ObjetRendezVous objet = ObjetRendezVous.values
        .firstWhere((o) => o.toString() == 'ObjetRendezVous.$name');
    return objet;
  }

  static StatutRendezVous parseStatut(String name) {
    StatutRendezVous statut = StatutRendezVous.values
        .firstWhere((s) => s.toString() == 'StatutRendezVous.$name');
    return statut;
  }
}
