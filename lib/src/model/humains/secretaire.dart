import '../models.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Secretaire extends PersonnelSante {
  // ignore: prefer_final_fields
  List<Medecin> _medecins = [];

  Secretaire(
    super._uid,
    super._identifiant,
    super._nom,
    super._prenoms,
    super._telephone,
    super._email,
    super._adresse,
    super._clinique,
    //this._medecins,
  );

  factory Secretaire.fromJson(Map<String, dynamic> json) {
    return Secretaire(
      json['uid'],
      json['identifiant'],
      json['nom'],
      json['prenoms'],
      json['telephone'],
      json['email'],
      json['adresse'],
      json['clinique'],
      //medecinsFromJson(json['medecins']),
    );
  }

  factory Secretaire.faker(User user) {
    var faker = Faker();
    var uid = user.uid;
    var nom = faker.person.name();
    var prenoms = faker.person.firstName();
    var telephone = faker.phoneNumber.us();
    var email = user.email!;
    var adresse = faker.address.streetAddress();
    var clinique = faker.company.name();
    return Secretaire(
      uid,
      null,
      nom,
      prenoms,
      telephone,
      email,
      adresse,
      clinique,
    );
  }

  List<Medecin> get medecins => _medecins;
  int get nombreMedecins => _medecins.length;
  List<Map<String, dynamic>> get medecinsJson =>
      medecins.map((m) => m.toJson()).toList();

  void ajouterMedecin(Medecin medecin) => _medecins.add(medecin);
  void supprimerMedecin(Medecin medecin) => _medecins.remove(medecin);

  @override
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'identifiant': identifiant,
        'nom': nom,
        'prenoms': prenoms,
        'telephone': telephone,
        'email': email,
        'adresse': adresse,
        'clinique': clinique,
        //'medecins': medecinsJson,
      };

  static List<Medecin> medecinsFromJson(
      List<Map<String, dynamic>> medecinsJson) {
    List<Medecin> medecins =
        medecinsJson.map((medecin) => Medecin.fromJson(medecin)).toList();
    return medecins;
  }
}
