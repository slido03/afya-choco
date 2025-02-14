import '../models.dart';
import 'package:faker/faker.dart';

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
      json['duree'],
      Patient.fromJson(json['patient']),
      Medecin.fromJson(json['medecin']),
      json['lieu'],
      parseObjet(json['objet']),
      parseStatut(json['statut']),
    );
  }

  factory RendezVous.faker(
    Patient patient,
    Medecin medecin,
  ) {
    var faker = Faker();
    var dateHeure = faker.date.dateTime(minYear: 2021, maxYear: 2024);
    var duree = faker.randomGenerator.integer(50, min: 15);
    var lieu = faker.company.name();
    return RendezVous(
      dateHeure,
      duree,
      patient,
      medecin,
      lieu,
      ObjetRendezVousExtension.faker(),
      StatutRendezVousExtension.faker(),
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
