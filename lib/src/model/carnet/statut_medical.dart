import '../models.dart';

class StatutMedical {
  final Patient _patient;
  GroupeSanguin _groupeSanguin;
  List<String> _allergies = [];
  List<String> _maladiesHereditaires = [];

  StatutMedical(
    this._patient,
    this._groupeSanguin,
    this._allergies,
    this._maladiesHereditaires,
  );

  factory StatutMedical.fromJson(Map<String, dynamic> json) {
    return StatutMedical(
      Patient.fromJson(json['patient']),
      parseGroupeSanguin(json['groupeSanguin']),
      json['allergies'] as List<String>,
      json['maladiesHereditaires'] as List<String>,
    );
  }

  Patient get patient => _patient;
  GroupeSanguin get groupeSanguin => _groupeSanguin;
  List<String> get allergies => _allergies;
  List<String> get maladiesHereditaires => _maladiesHereditaires;

  void setGroupeSanguin(GroupeSanguin groupeSanguin) =>
      _groupeSanguin = groupeSanguin;

  void ajouterAllergie(String allergie) => _allergies.add(allergie);
  void ajouterMaladie(String maladie) => _maladiesHereditaires.add(maladie);
  void supprimerAllergie(String allergie) => _allergies.remove(allergie);
  void supprimerMaladie(String maladie) =>
      _maladiesHereditaires.remove(maladie);

  Map<String, dynamic> toJson() => {
        'patient': patient.toJson(),
        'groupeSanguin': groupeSanguin.name,
        'allergies': allergies,
        'maladiesHereditaires': maladiesHereditaires,
      };

  static GroupeSanguin parseGroupeSanguin(String name) {
    GroupeSanguin groupeSanguin = GroupeSanguin.values
        .firstWhere((g) => g.toString() == 'GroupeSanguin.$name');
    return groupeSanguin;
  }
}
