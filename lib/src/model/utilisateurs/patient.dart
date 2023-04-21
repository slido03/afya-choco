import '../models.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Patient extends Utilisateur {
  DateTime? _dateNaissance;
  Sexe? _sexe;

  Patient(
    super._uid,
    super._identifiant,
    super._nom,
    super._prenoms,
    super._telephone,
    super._email,
    super._adresse,
    this._dateNaissance,
    this._sexe,
  );

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      json['uid'],
      json['identifiant'],
      json['nom'],
      json['prenoms'],
      json['telephone'],
      json['email'],
      json['adresse'],
      DateTime.parse(json['dateNaissance']),
      parseSexe(json['sexe']),
    );
  }

  factory Patient.faker(User user) {
    var faker = Faker();
    var uid = user.uid;
    var nom = faker.person.name();
    var prenoms = faker.person.firstName();
    var telephone = faker.phoneNumber.us();
    var email = user.email!;
    var adresse = faker.address.streetAddress();
    var dateNaissance = faker.date.dateTime(minYear: 1960, maxYear: 2022);
    return Patient(
      uid,
      null,
      nom,
      prenoms,
      telephone,
      email,
      adresse,
      dateNaissance,
      SexeExtension.faker(),
    );
  }

  DateTime? get dateNaissance => _dateNaissance;
  Sexe? get sexe => _sexe;

  void setDateNaissance(DateTime date) => _dateNaissance = date;
  void setSexe(Sexe sexe) => _sexe = sexe;

  @override
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'identifiant': identifiant,
        'nom': nom,
        'prenoms': prenoms,
        'telephone': telephone,
        'email': email,
        'adresse': adresse,
        'dateNaissance': dateNaissance!.toIso8601String(),
        'sexe': sexe!.name,
      };

  static Sexe parseSexe(String name) {
    Sexe sexe = Sexe.values.firstWhere((s) => s.toString() == 'Sexe.$name');
    return sexe;
  }

  @override
  String toString() {
    return nomComplet;
  }
}
