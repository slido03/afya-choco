import 'package:afya/src/model/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:afya/src/viewModel/view_models.dart';
//import 'package:afya/src/repository/repositories.dart';

class AppSeeder {
  final String email;
  final String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final PatientViewModel patientViewModel = PatientViewModel();
  final MedecinViewModel medecinViewModel = MedecinViewModel();
  final SecretaireViewModel secretaireViewModel = SecretaireViewModel();
  final PersonnelSanteViewModel personnelSanteViewModel =
      PersonnelSanteViewModel();
  final MessageViewModel messageViewModel = MessageViewModel();
  final RendezVousViewModel rendezVousViewModel = RendezVousViewModel();
  final EvenementViewModel evenementViewModel = EvenementViewModel();
  final NoteViewModel noteViewModel = NoteViewModel();
  final RappelViewModel rappelViewModel = RappelViewModel();
  final CarnetViewModel carnetViewModel = CarnetViewModel();
  final DiagnosticViewModel diagnosticViewModel = DiagnosticViewModel();
  final ExamenViewModel examenViewModel = ExamenViewModel();
  final OrdonnanceViewModel ordonnanceViewModel = OrdonnanceViewModel();
  final StatutMedicalViewModel statutMedicalViewModel =
      StatutMedicalViewModel();

  AppSeeder({required this.email, required this.password});

  //on authenthifie l'user pour être sûr qu'il a bien un compte
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      if (kDebugMode) {
        print('sign in goes on');
      }
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        if (kDebugMode) {
          print('userCredential non nul');
        }
      }
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print('userCredential nul');
      }
      return null;
    }
  }

  //seeder pour un utilisateur
  Future<void> seed() async {
    User? user = await signInWithEmailAndPassword(email, password);
    Secretaire? secretaireCentral =
        await messageViewModel.getSecretariatCentral();
    if (user != null) {
      //on crée d'abord un patient faker puis on le persiste
      Patient patient = Patient.faker(user);
      await patientViewModel.ajouter(patient);
      if (kDebugMode) {
        print('patient ajouté');
      }
      //ensuite un personnel sante
      PersonnelSante personnelSante = PersonnelSante.faker(user);
      await personnelSanteViewModel.ajouter(personnelSante);
      if (kDebugMode) {
        print('personnel sante ajouté');
      }
      //ensuite un secretaire
      Secretaire secretaire = Secretaire.faker(user);
      await secretaireViewModel.ajouter(secretaire);
      if (kDebugMode) {
        print('secretaire ajouté');
      }
      //ensuite un medecin
      Medecin medecin = Medecin.faker(user, secretaire);
      await medecinViewModel.ajouter(medecin);
      if (kDebugMode) {
        print('medecin ajouté');
      }

      //on passe ensuite aux messages, on en crée au moins 10 entre les entités humaines
      if (secretaireCentral != null) {
        for (int i = 0; i < 10; i++) {
          await messageViewModel
              .envoyer(Message.faker(patient, secretaireCentral));
          if (kDebugMode) {
            print('message envoyé');
          }
        }

        for (int i = 0; i < 10; i++) {
          await messageViewModel
              .envoyer(Message.faker(secretaireCentral, patient));
          if (kDebugMode) {
            print('message envoyé');
          }
        }

        for (int i = 0; i < 10; i++) {
          await messageViewModel
              .envoyer(Message.faker(secretaireCentral, medecin));
          if (kDebugMode) {
            print('message envoyé');
          }
        }

        for (int i = 0; i < 10; i++) {
          await messageViewModel
              .envoyer(Message.faker(medecin, secretaireCentral));
          if (kDebugMode) {
            print('message envoyé');
          }
        }

        for (int i = 0; i < 10; i++) {
          await messageViewModel
              .envoyer(Message.faker(personnelSante, secretaireCentral));
        }

        for (int i = 0; i < 10; i++) {
          await messageViewModel
              .envoyer(Message.faker(secretaireCentral, personnelSante));
          if (kDebugMode) {
            print('message envoyé');
          }
        }

        for (int i = 0; i < 10; i++) {
          await messageViewModel
              .envoyer(Message.faker(secretaireCentral, secretaire));
          if (kDebugMode) {
            print('message envoyé');
          }
        }

        for (int i = 0; i < 10; i++) {
          await messageViewModel
              .envoyer(Message.faker(secretaire, secretaireCentral));
          if (kDebugMode) {
            print('message envoyé');
          }
        }
      }

      //on prend ensuite les rendez-vous, les evenements, notes et rappels
      for (int i = 0; i < 10; i++) {
        //rendez-vous
        RendezVous rendezVous = RendezVous.faker(patient, medecin);
        await rendezVousViewModel.ajouter(rendezVous);
        if (kDebugMode) {
          print('rendez-vous ajouté');
        }
        //evenement
        Evenement evenement = Evenement.faker(rendezVous);
        await evenementViewModel.ajouter(evenement);
        if (kDebugMode) {
          print('evenement ajouté');
        }
        //notes
        for (int i = 0; i < 2; i++) {
          await noteViewModel.ajouter(Note.faker(evenement));
          if (kDebugMode) {
            print('note ajouté');
          }
        }
        //rappel
        await rappelViewModel.ajouter(Rappel.faker(evenement));
        if (kDebugMode) {
          print('rappel ajouté');
        }
      }

      //statut médical
      await statutMedicalViewModel.ajouter(StatutMedical.faker(patient));
      if (kDebugMode) {
        print('statut médical ajouté');
      }

      //examens
      for (int i = 0; i < 10; i++) {
        await examenViewModel.ajouter(Examen.faker(patient, medecin));
        if (kDebugMode) {
          print('examen ajouté');
        }
      }
      //diagnostics et ordonnances
      for (int i = 0; i < 10; i++) {
        Examen examen = Examen.faker(patient, medecin);
        Diagnostic diagnostic = Diagnostic.faker(medecin, examen);
        await diagnosticViewModel.ajouter(diagnostic);
        if (kDebugMode) {
          print('diagnostic ajouté');
        }
        await ordonnanceViewModel
            .ajouter(Ordonnance.faker(medecin, patient, diagnostic));
        if (kDebugMode) {
          print('ordonnnance ajouté');
        }
      }

      //carnet
      Examen examen = Examen.faker(patient, medecin);
      await examenViewModel.ajouter(examen);
      Diagnostic diagnostic = Diagnostic.faker(medecin, examen);
      await diagnosticViewModel.ajouter(diagnostic);
      Ordonnance ordonnance = Ordonnance.faker(medecin, patient, diagnostic);
      await ordonnanceViewModel.ajouter(ordonnance);
      await carnetViewModel.ajouter(Carnet.faker(patient, examen, ordonnance));
      if (kDebugMode) {
        print('carnet ajouté');
      }
    }
  }
}
