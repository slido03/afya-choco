import '../models.dart';

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
      json['uid'] as String,
      json['identifiant'] as String,
      json['nom'] as String,
      json['prenoms'] as String,
      json['telephone'] as String,
      json['email'] as String,
      json['adresse'] as String,
      DateTime.parse(json['dateNaissance']),
      parseSexe(json['sexe']),
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
