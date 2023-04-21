import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Utilisateur {
  String _uid; //id unique généré par firebase auth
  String? _identifiant;
  String _nom;
  String _prenoms;
  String _telephone;
  String _email;
  String? _adresse;

  Utilisateur(
    this._uid,
    this._identifiant,
    this._nom,
    this._prenoms,
    this._telephone,
    this._email,
    this._adresse,
  );

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      json['uid'],
      json['identifiant'],
      json['nom'],
      json['prenoms'],
      json['telephone'],
      json['email'],
      json['adresse'],
    );
  }

  //créer faker user à partir d'un compte utilisateur créé
  factory Utilisateur.faker(User user) {
    var faker = Faker();
    var uid = user.uid;
    var nom = faker.person.name();
    var prenoms = faker.person.firstName();
    var telephone = faker.phoneNumber.us();
    var email = user.email!;
    var adresse = faker.address.streetAddress();
    return Utilisateur(
      uid,
      null,
      nom,
      prenoms,
      telephone,
      email,
      adresse,
    );
  }

  String get uid => _uid;
  String? get identifiant => _identifiant;
  String get nom => _nom;
  String get prenoms => _prenoms;
  String get telephone => _telephone;
  String get email => _email;
  String? get adresse => _adresse;
  String get nomComplet => '$nom $prenoms';
  @override
  String toString() => nomComplet;

  void setIdentifiant() => _identifiant = _makeID(this);
  void setNom(String nom) => _nom = nom;
  void setPrenom(String prenoms) => _prenoms = prenoms;
  void setTelephone(String telephone) => _telephone = telephone;
  void setEmail(String email) => _email = email;
  void setAdresse(String adresse) => _adresse = adresse;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'identifiant': identifiant,
        'nom': nom,
        'prenoms': prenoms,
        'telephone': telephone,
        'email': email,
        'adresse': adresse,
      };
}

String _makeID(Utilisateur utilisateur) {
  num hash = Object.hash(
    utilisateur.uid,
    utilisateur.telephone,
    utilisateur.email,
    utilisateur.adresse,
  );
  var uuid = const Uuid();

  String debut = uuid.v1();
  String fin = hash.toString();

  debut = debut.substring(0, 4);
  debut = debut.toUpperCase();
  fin = fin.substring(0, 4);
  String identifiant = debut + fin;
  return identifiant;
}
