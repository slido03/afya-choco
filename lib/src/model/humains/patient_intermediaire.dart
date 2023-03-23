import '../models.dart';
import 'package:uuid/uuid.dart';

class PatientIntermediaire extends Patient {
  PatientIntermediaire(
    super._id,
    super._nom,
    super._prenoms,
    super._telephone,
    super._email,
    super._adresse,
    super._identifiantUnique,
    super._dateNaissance,
    super._sexe,
    super._statutMedical,
  );

  String get identifiantTemporaire => makeTempID(this);
}

String makeTempID(Patient patient) {
  num hash = Object.hash(
    patient.id,
    patient.telephone,
    patient.email,
    patient.adresse,
  );
  var uuid = const Uuid();

  String debut = uuid.v1();
  String fin = hash.toString();

  debut = debut.substring(0, 2);
  fin = fin.substring(0, 4);
  String identifiant = 'TP$debut$fin';
  return identifiant;
}
