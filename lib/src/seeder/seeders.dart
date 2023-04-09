import 'package:afya/src/model/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:afya/src/viewModel/view_models.dart';

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
  Future<void> seeder(String email, String password) async {
    User? user = await signInWithEmailAndPassword(email, password);
    Secretaire? secretaireCentral =
        await messageViewModel.getSecretariatCentral();
    if (user != null) {
      //on crée d'abord un patient faker puis on le persiste
      Patient patient = Patient.faker(user);
      patientViewModel.ajouter(patient);
      //ensuite un personnel sante
      PersonnelSante personnelSante = PersonnelSante.faker(user);
      personnelSanteViewModel.ajouter(personnelSante);
      //ensuite un secretaire
      Secretaire secretaire = Secretaire.faker(user);
      secretaireViewModel.ajouter(secretaire);
      //ensuite un medecin
      Medecin medecin = Medecin.faker(user, secretaire);
      medecinViewModel.ajouter(medecin);

      //on passe ensuite aux messages, on en crée au moins 10 entre les entités humaines
      if (secretaireCentral != null) {
        for (int i = 0; i < 10; i++) {
          messageViewModel.envoyer(Message.faker(patient, secretaireCentral));
        }

        for (int i = 0; i < 10; i++) {
          messageViewModel.envoyer(Message.faker(secretaireCentral, patient));
        }

        for (int i = 0; i < 10; i++) {
          messageViewModel.envoyer(Message.faker(secretaireCentral, medecin));
        }

        for (int i = 0; i < 10; i++) {
          messageViewModel.envoyer(Message.faker(medecin, secretaireCentral));
        }

        for (int i = 0; i < 10; i++) {
          messageViewModel
              .envoyer(Message.faker(personnelSante, secretaireCentral));
        }

        for (int i = 0; i < 10; i++) {
          messageViewModel
              .envoyer(Message.faker(secretaireCentral, personnelSante));
        }

        for (int i = 0; i < 10; i++) {
          messageViewModel
              .envoyer(Message.faker(secretaireCentral, secretaire));
        }

        for (int i = 0; i < 10; i++) {
          messageViewModel
              .envoyer(Message.faker(secretaire, secretaireCentral));
        }
      }

      //on prend ensuite les rendez-vous, les evenements, notes et rappels
      for (int i = 0; i < 15; i++) {
        //rendez-vous
        RendezVous rendezVous = RendezVous.faker(patient, medecin);
        rendezVousViewModel.ajouter(rendezVous);
        //evenement
        Evenement evenement = Evenement.faker(rendezVous);
        evenementViewModel.ajouter(evenement);
        //notes
        for (i = 0; i < 2; i++) {
          noteViewModel.ajouter(Note.faker(evenement));
        }
        //rappel
        rappelViewModel.ajouter(Rappel.faker(evenement));
      }

      //statut médical
      statutMedicalViewModel.ajouter(StatutMedical.faker(patient));

      //examens
      for (int i = 0; i < 10; i++) {
        examenViewModel.ajouter(Examen.faker(patient, medecin));
      }
      //diagnostics et ordonnances
      for (int i = 0; i < 10; i++) {
        Examen examen = Examen.faker(patient, medecin);
        Diagnostic diagnostic = Diagnostic.faker(medecin, examen);
        diagnosticViewModel.ajouter(diagnostic);
        ordonnanceViewModel
            .ajouter(Ordonnance.faker(medecin, patient, diagnostic));
      }

      //carnet
      Examen examen = Examen.faker(patient, medecin);
      examenViewModel.ajouter(examen);
      Diagnostic diagnostic = Diagnostic.faker(medecin, examen);
      diagnosticViewModel.ajouter(diagnostic);
      Ordonnance ordonnance = Ordonnance.faker(medecin, patient, diagnostic);
      ordonnanceViewModel.ajouter(ordonnance);
      carnetViewModel.ajouter(Carnet.faker(patient, examen, ordonnance));
    }
  }
}
