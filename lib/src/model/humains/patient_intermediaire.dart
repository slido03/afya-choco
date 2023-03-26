import '../models.dart';
import 'package:uuid/uuid.dart';

class PatientIntermediaire extends Patient {
  String _identifiantTemporaire;

  PatientIntermediaire(
    super._identifiant,
    super._nom,
    super._prenoms,
    super._telephone,
    super._email,
    super._adresse,
    super._dateNaissance,
    super._sexe,
    this._identifiantTemporaire,
  );

  factory PatientIntermediaire.fromJson(Map<String, dynamic> json) {
    return PatientIntermediaire(
      null,
      json['nom'] as String,
      json['prenoms'] as String,
      json['telephone'] as String,
      json['email'] as String?,
      json['adresse'] as String?,
      null,
      null,
      json['identifiantTemporaire'] as String,
    );
  }

  String get identifiantTemporaire => _identifiantTemporaire;
  void setIdentifiantTemporaire() => _identifiantTemporaire = _makeTempID(this);

  @override
  Map<String, dynamic> toJson() => {
        'nom': nom,
        'prenoms': prenoms,
        'telephone': telephone,
        'email': email,
        'adresse': adresse,
        'identifiantTemporaire': identifiantTemporaire,
      };
}

String _makeTempID(Patient patient) {
  num hash = Object.hash(
    patient.telephone,
    patient.email,
    patient.adresse,
  );
  var uuid = const Uuid();

  String debut = uuid.v1();
  String fin = hash.toString();

  debut = debut.substring(0, 2);
  debut = debut.toUpperCase();
  fin = fin.substring(0, 4);
  String identifiant = 'TP$debut$fin';
  return identifiant;
}
