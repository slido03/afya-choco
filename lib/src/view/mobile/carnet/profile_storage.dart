//import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:afya/src/model/models.dart';
import 'package:localstorage/localstorage.dart';
import 'package:afya/src/viewModel/view_models.dart';

//stockage du profile en local
class ProfileStorage {
  static final LocalStorage _patientStorage = LocalStorage('patientStorage');
  static final LocalStorage _statutStorage = LocalStorage('statutStorage');
  static final StatutMedicalViewModel _statutMedicalViewModel =
      StatutMedicalViewModel();
  static final PatientViewModel _patientViewModel = PatientViewModel();

  static Future<bool> _initialization() async {
    bool patientStorageReady = await _patientStorage.ready;
    bool statutStorageReady = await _statutStorage.ready;
    if (patientStorageReady && statutStorageReady) {
      return true;
    }
    return false;
  }

  static Future<void> _storePatient(String uid) async {
    Future<Patient?> p = _patientViewModel.trouverUid(uid);
    Patient? patient = await p;
    if (patient != null) {
      await _patientStorage.setItem('patient', patient.toJson());
    }
  }

  static Future<void> _storeStatut(String uid) async {
    Future<StatutMedical?> statutM = _statutMedicalViewModel.trouverUid(uid);
    StatutMedical? statutMedical = await statutM;
    if (statutMedical != null) {
      await _statutStorage.setItem('statutMedical', statutMedical.toJson());
    }
  }

  static Future<Map<String, dynamic>?> _getPatient() async {
    return await _patientStorage.getItem('patient');
  }

  static Future<Map<String, dynamic>?> _getStatut() async {
    return await _statutStorage.getItem('statutMedical');
  }

  static Future<Patient?> patientInitialized(String uid) async {
    //storage initialized
    if (await _initialization()) {
      //si le patient n'a pas encore été stocké on le stocke
      if (await _getPatient() == null) {
        await _storePatient(uid);
      }
      Map<String, dynamic>? patientJson = await _getPatient();
      Patient patient = Patient.fromJson(patientJson!);
      return patient;
    }
    return null;
  }

  static Future<StatutMedical?> statutInialized(String uid) async {
    //storage initialized
    if (await _initialization()) {
      //si le statut n'a pas encore été stocké on le stocke
      if (await _getStatut() == null) {
        await _storeStatut(uid);
      }
      Map<String, dynamic>? statutJson = await _getStatut();
      StatutMedical statutMedical = StatutMedical.fromJson(statutJson!);
      return statutMedical;
    }
    return null;
  }

  static Future<void> clear() async {
    await _patientStorage.clear();
    await _statutStorage.clear();
  }
}
