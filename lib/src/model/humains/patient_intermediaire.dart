import '../models.dart';
import 'package:uuid/uuid.dart';

class PatientIntermediaire extends Patient {
  //l'identifiant temporaire permet de remplacer l'identifiant final
  String? _identifiantTemporaire;

  PatientIntermediaire(
    super._uid,
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
      json['uid'] as String,
      null,
      json['nom'] as String,
      json['prenoms'] as String,
      json['telephone'] as String,
      json['email'] as String,
      null,
      null,
      null,
      json['identifiant'] as String,
    );
  }

  String? get identifiantTemporaire => _identifiantTemporaire;
  void setIdentifiantTemporaire() => _identifiantTemporaire = _makeTempID(this);

  @override
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'nom': nom,
        'prenoms': prenoms,
        'telephone': telephone,
        'email': email,
        'identifiant': identifiantTemporaire,
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
