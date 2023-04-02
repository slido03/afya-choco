import 'package:uuid/uuid.dart';

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
      json['uid'] as String,
      json['identifiant'] as String?,
      json['nom'] as String,
      json['prenoms'] as String,
      json['telephone'] as String,
      json['email'] as String,
      json['adresse'] as String?,
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
