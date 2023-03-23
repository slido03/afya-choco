export 'humains/personne.dart';
export 'humains/personnel_sante.dart';
export 'humains/patient.dart';
export 'humains/patient_intermediaire.dart';
export 'humains/medecin.dart';
export 'humains/secretaire.dart';
export 'agenda/rendez_vous.dart';
export 'agenda/evenement.dart';
export 'agenda/rappel.dart';
export 'agenda/note.dart';
export 'notifications/message.dart';
export 'carnet/statut_medical.dart';
export 'carnet/examen.dart';
export 'carnet/diagnostic.dart';
export 'carnet/ordonnance.dart';
export 'carnet/carnet.dart';

enum Sexe {
  homme,
  femme,
}

enum Specialite {
  cardiologie,
  radiologie,
  chirurgieGenerale,
  chirurgieCardiothoracique,
  chirurgieOrthopedique,
  dermatologie,
  anesthesiologie,
  endocrinologie,
  gastroEnterologie,
  gynecologieObstetrique,
  hematologie,
  geriatrie,
  infectiologie,
  medecineInterne,
  nephrologie,
  neurologie,
  oncologie,
  ophtalmologie,
  orl,
  pediatrie,
  pneumologie,
  psychiatrie,
  rhumatologie,
  toxicologie,
}

enum ObjetMessage {
  prendreRendezVous,
  modifierRendezVous,
  annulerRendezVous,
  demandeInformations,
  confirmerRendezVous,
  donnerInformations,
  signalerMiseAJour,
}

enum StatutMessage {
  traite,
  nonTraite,
}

enum ObjetRendezVous {
  consultation,
  examen,
  soin,
}

enum StatutRendezVous {
  enAttente,
  effectue,
  annule,
}

enum GroupeSanguin {
  aPositif,
  bPositif,
  oPositif,
  abPositif,
  aNegatif,
  bNegatif,
  oNegatif,
  abNegatif,
}

enum StatutDiagnostic {
  enCours,
  confime,
}
