import '../models.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PersonnelSante extends Utilisateur {
  final String _clinique;

  PersonnelSante(
    super._uid,
    super._identifiant,
    super._nom,
    super._prenoms,
    super._telephone,
    super._email,
    super._adresse,
    this._clinique,
  );

  factory PersonnelSante.fromJson(Map<String, dynamic> json) {
    return PersonnelSante(
      json['uid'],
      json['identifiant'],
      json['nom'],
      json['prenoms'],
      json['telephone'],
      json['email'],
      json['adresse'],
      json['clinique'],
    );
  }

  factory PersonnelSante.faker(User user) {
    var faker = Faker();
    var uid = user.uid;
    var nom = faker.person.name();
    var prenoms = faker.person.firstName();
    var telephone = faker.phoneNumber.us();
    var email = user.email!;
    var adresse = faker.address.streetAddress();
    var clinique = faker.company.name();
    return PersonnelSante(
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

  String get clinique => _clinique;

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
      };
}
