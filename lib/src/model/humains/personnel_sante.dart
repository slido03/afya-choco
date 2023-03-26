import '../models.dart';

class PersonnelSante extends Utilisateur {
  final String _clinique;

  PersonnelSante(
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
      json['identifiant'] as String,
      json['nom'] as String,
      json['prenoms'] as String,
      json['telephone'] as String,
      json['email'] as String,
      json['adresse'] as String,
      json['clinique'] as String,
    );
  }

  String get clinique => _clinique;

  @override
  Map<String, dynamic> toJson() => {
        'identifiant': identifiant,
        'nom': nom,
        'prenoms': prenoms,
        'telephone': telephone,
        'email': email,
        'adresse': adresse,
        'clinique': clinique,
      };
}
