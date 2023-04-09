export 'humains/utilisateur.dart';
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

extension SexeExtension on Sexe {
  String get value {
    switch (this) {
      case Sexe.homme:
        return 'homme';
      case Sexe.femme:
        return 'femme';
      default:
        throw ArgumentError('Sexe inconnu');
    }
  }
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

extension SpecialiteExtension on Specialite {
  String get value {
    switch (this) {
      case Specialite.cardiologie:
        return 'cardiologie';
      case Specialite.anesthesiologie:
        return 'anesthesiologie';
      case Specialite.chirurgieCardiothoracique:
        return 'chirurgie cardiothoracique';
      case Specialite.chirurgieGenerale:
        return 'chirurgie générale';
      case Specialite.chirurgieOrthopedique:
        return 'chirurgie orthopédique';
      case Specialite.dermatologie:
        return 'dermatologie';
      case Specialite.endocrinologie:
        return 'endocrinologie';
      case Specialite.gastroEnterologie:
        return 'gastro-enterologie';
      case Specialite.geriatrie:
        return 'geriatrie';
      case Specialite.gynecologieObstetrique:
        return 'gynécologie obstétrique';
      case Specialite.hematologie:
        return 'hématologie';
      case Specialite.infectiologie:
        return 'infectiologie';
      case Specialite.medecineInterne:
        return 'médecine interne';
      case Specialite.nephrologie:
        return 'néphrologie';
      case Specialite.neurologie:
        return 'neurologie';
      case Specialite.oncologie:
        return 'oncologie';
      case Specialite.ophtalmologie:
        return 'ophtalmologie';
      case Specialite.orl:
        return 'Otho-rhyno-laryngologie';
      case Specialite.pediatrie:
        return 'pédiatrie';
      case Specialite.pneumologie:
        return 'pneumologie';
      case Specialite.psychiatrie:
        return 'psychiatrie';
      case Specialite.radiologie:
        return 'radiologie';
      case Specialite.rhumatologie:
        return 'rhumatologie';
      case Specialite.toxicologie:
        return 'toxicologie';
      default:
        throw ArgumentError('Spécialité inconnue');
    }
  }
}

enum ObjetMessage {
  prendreRendezVous,
  modifierRendezVous,
  annulerRendezVous,
  demanderInformations,
  confirmerRendezVous,
  donnerInformations,
  signalerMiseAJour,
}

extension ObjetMessageExtension on ObjetMessage {
  String get value {
    switch (this) {
      case ObjetMessage.prendreRendezVous:
        return 'Prise de rendez-vous';
      case ObjetMessage.modifierRendezVous:
        return 'Changement de rendez-vous';
      case ObjetMessage.annulerRendezVous:
        return 'Annulation de rendez-vous';
      case ObjetMessage.demanderInformations:
        return "Demande d'informations";
      case ObjetMessage.confirmerRendezVous:
        return 'Confirmation de rendez-vous';
      case ObjetMessage.donnerInformations:
        return 'Renseignements';
      case ObjetMessage.signalerMiseAJour:
        return 'Mise à jour de vos informations médicales';
      default:
        throw ArgumentError('Objet de message inconnu');
    }
  }
}

enum StatutMessage {
  nonTraite,
  traite,
}

extension StatutMessageExtension on StatutMessage {
  String get value {
    switch (this) {
      case StatutMessage.nonTraite:
        return 'Non traité';
      case StatutMessage.traite:
        return 'traité';
      default:
        throw ArgumentError('Statut de message inconnu');
    }
  }
}

enum ObjetRendezVous {
  consultation,
  examen,
  soin,
}

extension ObjetRendezVousExtension on ObjetRendezVous {
  String get value {
    switch (this) {
      case ObjetRendezVous.consultation:
        return 'Consultation médicale';
      case ObjetRendezVous.examen:
        return 'Examens médicaux';
      case ObjetRendezVous.soin:
        return 'Soins médicaux';
      default:
        throw ArgumentError('Objet de rendez-vous inconnu');
    }
  }
}

enum StatutRendezVous {
  enAttente,
  effectue,
  annule,
}

extension StatutRendezVousExtension on StatutRendezVous {
  String get value {
    switch (this) {
      case StatutRendezVous.enAttente:
        return 'En attente';
      case StatutRendezVous.effectue:
        return 'Effectué';
      case StatutRendezVous.annule:
        return 'Annulé';
      default:
        throw ArgumentError('Statut de rendez-vous inconnu');
    }
  }
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

extension GroupeSanguinExtension on GroupeSanguin {
  String get value {
    switch (this) {
      case GroupeSanguin.aPositif:
        return 'A+';
      case GroupeSanguin.aNegatif:
        return 'A-';
      case GroupeSanguin.bPositif:
        return 'B+';
      case GroupeSanguin.bNegatif:
        return 'B-';
      case GroupeSanguin.oPositif:
        return 'O+';
      case GroupeSanguin.oNegatif:
        return 'O-';
      case GroupeSanguin.abPositif:
        return 'AB+';
      case GroupeSanguin.abNegatif:
        return 'AB-';
      default:
        throw ArgumentError('Groupe sanguin inconnu');
    }
  }
}

enum StatutDiagnostic {
  enCours,
  confirme,
}

extension StatutDagnosticExtension on StatutDiagnostic {
  String get value {
    switch (this) {
      case StatutDiagnostic.enCours:
        return 'En cours';
      case StatutDiagnostic.confirme:
        return 'Confirmé';
      default:
        throw ArgumentError('Statut de diagnostic inconnu');
    }
  }
}
