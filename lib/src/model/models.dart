import 'dart:math';

export 'utilisateurs/utilisateur.dart';
export 'utilisateurs/personnel_sante.dart';
export 'utilisateurs/patient.dart';
export 'utilisateurs/patient_intermediaire.dart';
export 'utilisateurs/medecin.dart';
export 'utilisateurs/secretaire.dart';
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
        return 'Masculin';
      case Sexe.femme:
        return 'Féminin';
      default:
        throw ArgumentError('Sexe inconnu');
    }
  }

  //génère un Sexe aléatoire de l'enum
  static Sexe faker() {
    var values = Sexe.values;
    var randomIndex = Random().nextInt(values.length);
    return values[randomIndex];
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
        return 'Cardiologie';
      case Specialite.anesthesiologie:
        return 'Anesthesiologie';
      case Specialite.chirurgieCardiothoracique:
        return 'Chirurgie cardiothoracique';
      case Specialite.chirurgieGenerale:
        return 'Chirurgie générale';
      case Specialite.chirurgieOrthopedique:
        return 'Chirurgie orthopédique';
      case Specialite.dermatologie:
        return 'Dermatologie';
      case Specialite.endocrinologie:
        return 'Endocrinologie';
      case Specialite.gastroEnterologie:
        return 'Gastro-enterologie';
      case Specialite.geriatrie:
        return 'Geriatrie';
      case Specialite.gynecologieObstetrique:
        return 'Gynécologie obstétrique';
      case Specialite.hematologie:
        return 'Hématologie';
      case Specialite.infectiologie:
        return 'Infectiologie';
      case Specialite.medecineInterne:
        return 'Médecine interne';
      case Specialite.nephrologie:
        return 'Néphrologie';
      case Specialite.neurologie:
        return 'Neurologie';
      case Specialite.oncologie:
        return 'Oncologie';
      case Specialite.ophtalmologie:
        return 'Ophtalmologie';
      case Specialite.orl:
        return 'Otho-rhyno-laryngologie';
      case Specialite.pediatrie:
        return 'Pédiatrie';
      case Specialite.pneumologie:
        return 'Pneumologie';
      case Specialite.psychiatrie:
        return 'Psychiatrie';
      case Specialite.radiologie:
        return 'Radiologie';
      case Specialite.rhumatologie:
        return 'Rhumatologie';
      case Specialite.toxicologie:
        return 'Toxicologie';
      default:
        throw ArgumentError('Spécialité inconnue');
    }
  }

  //génère une Spécialité aléatoire de l'enum
  static Specialite faker() {
    var values = Specialite.values;
    var randomIndex = Random().nextInt(values.length);
    return values[randomIndex];
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

  //génère un ObjetMessage aléatoire de l'enum
  static ObjetMessage faker() {
    var values = ObjetMessage.values;
    var randomIndex = Random().nextInt(values.length);
    return values[randomIndex];
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
        return 'Traité';
      default:
        throw ArgumentError('Statut de message inconnu');
    }
  }

  //génère un StatutMessage aléatoire de l'enum
  static StatutMessage faker() {
    var values = StatutMessage.values;
    var randomIndex = Random().nextInt(values.length);
    return values[randomIndex];
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

  //génère un ObjetRendezVous aléatoire de l'enum
  static ObjetRendezVous faker() {
    var values = ObjetRendezVous.values;
    var randomIndex = Random().nextInt(values.length);
    return values[randomIndex];
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

  //génère un StatutRendezVous aléatoire de l'enum
  static StatutRendezVous faker() {
    var values = StatutRendezVous.values;
    var randomIndex = Random().nextInt(values.length);
    return values[randomIndex];
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

  //génère un GroupeSanguin aléatoire de l'enum
  static GroupeSanguin faker() {
    var values = GroupeSanguin.values;
    var randomIndex = Random().nextInt(values.length);
    return values[randomIndex];
  }
}

enum StatutDiagnostic {
  enCours,
  confirme,
}

extension StatutDiagnosticExtension on StatutDiagnostic {
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

  //génère un StatutDagnostic aléatoire de l'enum
  static StatutDiagnostic faker() {
    var values = StatutDiagnostic.values;
    var randomIndex = Random().nextInt(values.length);
    return values[randomIndex];
  }
}
