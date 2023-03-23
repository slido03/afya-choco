import '../models.dart';

class Medecin extends PersonnelSante {
  Specialite _specialite;
  String _numeroLicence;
  Secretaire _secretaire;

  Medecin(
    super._id,
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

  Specialite get specialite => _specialite;
  String get numeroLicence => _numeroLicence;
  Secretaire get secretaire => _secretaire;

  void setSpecialite(Specialite specialite) => _specialite = specialite;
  void setNumeroLicence(String numeroLicence) => _numeroLicence = numeroLicence;
  void setSecretaire(Secretaire secretaire) => _secretaire = secretaire;
}
