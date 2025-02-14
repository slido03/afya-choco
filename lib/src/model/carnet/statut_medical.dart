import '../models.dart';
import 'package:faker/faker.dart';

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
    List<String> allergies = json['allergies'].cast<String>().toList();
    List<String> maladiesHereditaires =
        json['maladiesHereditaires'].cast<String>().toList();
    return StatutMedical(
      Patient.fromJson(json['patient']),
      parseGroupeSanguin(json['groupeSanguin']),
      allergies,
      maladiesHereditaires,
    );
  }

  factory StatutMedical.faker(Patient patient) {
    var faker = Faker();
    var allergies = faker.lorem.words(3);
    var maladiesHereditaires = faker.lorem.words(4);
    return StatutMedical(
      patient,
      GroupeSanguinExtension.faker(),
      allergies,
      maladiesHereditaires,
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
