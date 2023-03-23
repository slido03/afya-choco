import '../models.dart';

class Secretaire extends PersonnelSante {
  String _numeroSecuriteSociale;
  final List<Medecin> _medecins = [];

  Secretaire(
    super._id,
    super._nom,
    super._prenoms,
    super._telephone,
    super._email,
    super._adresse,
    super._clinique,
    this._numeroSecuriteSociale,
  );

  String get numeroSecuriteSociale => _numeroSecuriteSociale;
  List<Medecin> get medecins => _medecins;
  int get nombreMedecins => _medecins.length;

  void setNumeroSecuriteSociale(String numeroSecuriteSociale) =>
      _numeroSecuriteSociale = numeroSecuriteSociale;
  void ajouterMedecin(Medecin medecin) => _medecins.add(medecin);
  void supprimerMedecin(Medecin medecin) => _medecins.remove(medecin);
}
