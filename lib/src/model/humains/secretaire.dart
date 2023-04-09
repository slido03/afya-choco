import '../models.dart';

class Secretaire extends PersonnelSante {
  String _numeroSecuriteSociale;
  // ignore: prefer_final_fields
  List<Medecin> _medecins = [];

  Secretaire(
    super._uid,
    super._identifiant,
    super._nom,
    super._prenoms,
    super._telephone,
    super._email,
    super._adresse,
    super._clinique,
    this._numeroSecuriteSociale,
    //this._medecins,
  );

  factory Secretaire.fromJson(Map<String, dynamic> json) {
    return Secretaire(
      json['uid'],
      json['identifiant'],
      json['nom'],
      json['prenoms'],
      json['telephone'],
      json['email'],
      json['adresse'],
      json['clinique'],
      json['numeroSecuriteSociale'],
      //medecinsFromJson(json['medecins']),
    );
  }

  String get numeroSecuriteSociale => _numeroSecuriteSociale;
  List<Medecin> get medecins => _medecins;
  int get nombreMedecins => _medecins.length;
  List<Map<String, dynamic>> get medecinsJson =>
      medecins.map((m) => m.toJson()).toList();

  void setNumeroSecuriteSociale(String numeroSecuriteSociale) =>
      _numeroSecuriteSociale = numeroSecuriteSociale;
  void ajouterMedecin(Medecin medecin) => _medecins.add(medecin);
  void supprimerMedecin(Medecin medecin) => _medecins.remove(medecin);

  @override
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'identifiant': identifiant,
        'nom': nom,
        'prenoms': prenoms,
        'telephone': telephone,
        'email': email,
        'adresse': adresse,
        'clinique': clinique,
        'numeroSecuriteSociale': numeroSecuriteSociale,
        //'medecins': medecinsJson,
      };

  static List<Medecin> medecinsFromJson(
      List<Map<String, dynamic>> medecinsJson) {
    List<Medecin> medecins =
        medecinsJson.map((medecin) => Medecin.fromJson(medecin)).toList();
    return medecins;
  }
}
