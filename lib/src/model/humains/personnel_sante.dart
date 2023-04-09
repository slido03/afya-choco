import '../models.dart';

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
