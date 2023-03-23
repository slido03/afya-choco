import '../models.dart';
import 'package:uuid/uuid.dart';

class Patient extends Personne {
  String? _identifiantUnique;
  DateTime? _dateNaissance;
  Sexe? _sexe;
  StatutMedical? _statutMedical;

  Patient(
    super._id,
    super._nom,
    super._prenoms,
    super._telephone,
    super._email,
    super._adresse,
    this._identifiantUnique,
    this._dateNaissance,
    this._sexe,
    this._statutMedical,
  );

  String? get identifiantUnique {
    _identifiantUnique = makeID(this);
    return _identifiantUnique;
  }

  DateTime? get dateNaissance => _dateNaissance;
  Sexe? get sexe => _sexe;
  StatutMedical? get statutMedical => _statutMedical;

  void setDateNaissance(DateTime date) => _dateNaissance = date;
  void setSexe(Sexe sexe) => _sexe = sexe;
  void setStatut(StatutMedical statut) => _statutMedical = statut;
}

String makeID(Patient patient) {
  num hash = Object.hash(
    patient.id,
    patient.telephone,
    patient.email,
    patient.adresse,
  );
  var uuid = const Uuid();

  String debut = uuid.v1();
  String fin = hash.toString();

  debut = debut.substring(0, 4);
  fin = fin.substring(0, 4);
  String identifiant = debut + fin;
  return identifiant;
}
