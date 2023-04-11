import '../models.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Medecin extends PersonnelSante {
  bool _admin;
  Specialite _specialite;
  Secretaire _secretaire;

  Medecin(
    super._uid,
    super._identifiant,
    super._nom,
    super._prenoms,
    super._telephone,
    super._email,
    super._adresse,
    super._clinique,
    this._admin,
    this._specialite,
    this._secretaire,
  );

  factory Medecin.fromJson(Map<String, dynamic> json) {
    return Medecin(
      json['uid'],
      json['identifiant'],
      json['nom'],
      json['prenoms'],
      json['telephone'],
      json['email'],
      json['adresse'],
      json['clinique'],
      json['admin'],
      parseSpecialite(json['specialite']),
      Secretaire.fromJson(json['secretaire']),
    );
  }

  factory Medecin.faker(
    User user,
    Secretaire secretaire,
  ) {
    var faker = Faker();
    var uid = user.uid;
    var nom = faker.person.name();
    var prenoms = faker.person.firstName();
    var telephone = faker.phoneNumber.us();
    var email = user.email!;
    var adresse = faker.address.streetAddress();
    var clinique = faker.company.name();
    return Medecin(
      uid,
      null,
      nom,
      prenoms,
      telephone,
      email,
      adresse,
      clinique,
      false,
      SpecialiteExtension.faker(),
      secretaire,
    );
  }

  bool get admin => _admin;
  Specialite get specialite => _specialite;
  Secretaire get secretaire => _secretaire;

  void setAdmin(bool admin) => _admin = admin;
  void setSpecialite(Specialite specialite) => _specialite = specialite;
  void setSecretaire(Secretaire secretaire) => _secretaire = secretaire;

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
        'admin': admin,
        'specialite': specialite.name,
        'secretaire': secretaire.toJson(),
      };

  static Specialite parseSpecialite(String name) {
    Specialite specialite =
        Specialite.values.firstWhere((s) => s.toString() == 'Specialite.$name');
    return specialite;
  }
}
