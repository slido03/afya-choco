import '../models.dart';

class Medecin extends PersonnelSante {
  Specialite _specialite;
  String _numeroLicence;
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
    this._specialite,
    this._numeroLicence,
    this._secretaire,
  );

  factory Medecin.fromJson(Map<String, dynamic> json) {
    return Medecin(
      json['uid'] as String,
      json['identifiant'] as String,
      json['nom'] as String,
      json['prenoms'] as String,
      json['telephone'] as String,
      json['email'] as String,
      json['adresse'] as String,
      json['clinique'] as String,
      parseSpecialite(json['specialite']),
      json['numeroLicence'] as String,
      Secretaire.fromJson(json['secretaire']),
    );
  }

  Specialite get specialite => _specialite;
  String get numeroLicence => _numeroLicence;
  Secretaire get secretaire => _secretaire;

  void setSpecialite(Specialite specialite) => _specialite = specialite;
  void setNumeroLicence(String numeroLicence) => _numeroLicence = numeroLicence;
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
        'specialite': specialite.name,
        'numeroLicence': numeroLicence,
        'secretaire': secretaire.toJson(),
      };

  static Specialite parseSpecialite(String name) {
    Specialite specialite =
        Specialite.values.firstWhere((s) => s.toString() == 'Specialite.$name');
    return specialite;
  }
}
