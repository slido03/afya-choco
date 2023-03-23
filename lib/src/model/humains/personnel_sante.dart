import '../models.dart';

class PersonnelSante extends Personne {
  final String _clinique;

  PersonnelSante(
    super._id,
    super._nom,
    super._prenoms,
    super._telephone,
    super._email,
    super._adresse,
    this._clinique,
  );

  String get clinique => _clinique;
}
