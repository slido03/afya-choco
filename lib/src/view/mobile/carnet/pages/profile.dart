//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:afya/src/view/mobile/carnet/profile_storage.dart';
import 'package:afya/src/model/models.dart';
import 'package:intl/intl.dart';
import 'dart:async';
// import de Material Symbols
import 'package:flutter_material_symbols/flutter_material_symbols.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.userId});
  final String userId;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          ProfileStorage.patientInitialized(widget.userId),
        ]),
        builder: (context, result) {
          if (result.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ));
          } else if (result.hasData) {
            final List<Patient?> data = result.data!;
            final patient = data[0];
            return Container(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                      //padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                    const Text(
                      "Informations civiques",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: (patient == null)
                            ? const Padding(
                                //patient nul
                                padding: EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 10,
                                ),
                                child: Text(
                                    "Vos informations civiques n'ont pas encore été renseignées par un professionnel de santé",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    )),
                              )
                            : Padding(
                                //patient non nul
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .80,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                patient.nom,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                patient.prenoms,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                patient.telephone,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.email,
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                patient.email,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                patient.adresse!,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.date_range,
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                patient.dateNaissance
                                                    .dateFormatted,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.wc,
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                patient.sexe!.value,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Statut médical",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    statutMedicalWidget(
                        context, ProfileStorage.statutInialized(widget.userId)),
                  ])))),
            );
          }
          //en cas d'erreur quelconque (result.hasError) dans ce cas patient == null
          return Container(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                      //padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                    const Text(
                      "Informations civiques",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 10,
                              ),
                              child: Text(
                                  "Vos informations civiques n'ont pas encore été renseignées par un professionnel de santé",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ))),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Statut médical",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    statutMedicalWidget(
                        context, ProfileStorage.statutInialized(widget.userId)),
                  ])))));
        });
  }

  Widget statutMedicalWidget(
      BuildContext context, Future<StatutMedical?> statut) {
    return FutureBuilder(
        future: Future.wait([
          statut,
        ]),
        builder: (context, result) {
          if (result.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ));
          } else if (result.hasData) {
            final List<StatutMedical?> data = result.data!;
            final statutMedical = data[0];
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: (statutMedical == null) // statutMédical nul
                    ? const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 10,
                        ),
                        child: Text(
                            "Votre statut médical n'a pas encore été renseigné par un professionnel de santé",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            )),
                      )
                    : Padding(
                        // statutMédical non nul
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .80,
                                ),
                                Row(
                                  children: [
                                    // Icon de groupe sanguin
                                    Icon(
                                      Icons.bloodtype,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      statutMedical.groupeSanguin.value,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    const Text(
                                      "(Groupe sanguin)",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    // Icon d'alergies via google font
                                    Icon(
                                      MaterialSymbols.allergies,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      statutMedical.allergies.isEmpty
                                          ? "Aucune"
                                          : statutMedical.allergies.join(",\n"),
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    const Text(
                                      "(Alergies)",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    // Icon de maladies hereditaires
                                    Icon(
                                      MaterialSymbols.genetics,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      statutMedical.maladiesHereditaires.isEmpty
                                          ? "Aucune"
                                          : statutMedical.maladiesHereditaires
                                              .join(",\n"),
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    const Text(
                                      "(Maladies hereditaires)",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
            );
          }
          //en cas d'erreur quelconque (result.hasError) dans ce cas statut == null
          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 10,
                    ),
                    child: Text(
                        "Votre statut médical n'a pas encore été renseigné par un professionnel de santé",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )),
                  )));
        });
  }
}

extension FormatDate on DateTime? {
  String get dateFormatted => DateFormat('dd/MM/yyyy').format(this!);
  String get timeFormatted => DateFormat('HH:mm').format(this!);
}
