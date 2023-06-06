import 'package:afya/src/view/web/authentication/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:afya/src/viewModel/message_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../model/models.dart';
import '../../constant/tabs.dart';
//import '../../home/pages/login_page.dart';
import 'liste_demandes.dart';

class ConsultationTab extends StatefulWidget {
  const ConsultationTab({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ConsultationTabState createState() => _ConsultationTabState();
}

class _ConsultationTabState extends State<ConsultationTab>
    with TickerProviderStateMixin {
  AuthService authService = AuthService.instance;
  MessageViewModel messageViewModel = MessageViewModel();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<String?> uid = authService.getCurrentUserUid();
    return FutureBuilder(
        future: Future.wait([uid]),
        builder: (context, result) {
          if (result.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ));
          } else if (result.hasData) {
            final List<String?> data = result.data!;
            final userId = data[0];
            //si l'utilisateur est connecté
            if (userId != null) {
              Future<List<Message>> demandes = messageViewModel.listerRecuObjet(
                  userId, ObjetMessage.prendreRendezVous);
              Future<List<Message>> modifications = messageViewModel
                  .listerRecuObjet(userId, ObjetMessage.modifierRendezVous);
              Future<List<Message>> annulations = messageViewModel
                  .listerRecuObjet(userId, ObjetMessage.annulerRendezVous);
              Future<List<Message>> renseignements = messageViewModel
                  .listerRecuObjet(userId, ObjetMessage.demanderInformations);
              return DefaultTabController(
                length: 5,
                child: Material(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        TabBar(tabs: tabs),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              ChangeNotifierProvider(
                                create: (context) => MessageViewModel(),
                                builder: ((context, child) => ListeDemandes(
                                      messages: demandes,
                                    )),
                              ),
                              ChangeNotifierProvider(
                                create: (context) => MessageViewModel(),
                                builder: ((context, child) => ListeDemandes(
                                      messages: modifications,
                                    )),
                              ),
                              ChangeNotifierProvider(
                                create: (context) => MessageViewModel(),
                                builder: ((context, child) => ListeDemandes(
                                      messages: annulations,
                                    )),
                              ),
                              ChangeNotifierProvider(
                                create: (context) => MessageViewModel(),
                                builder: ((context, child) => ListeDemandes(
                                      messages: renseignements,
                                    )),
                              ),
                              const Text('Rendez-vous')
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              authService.signOut();
              context.go('/');
            }
          }
          if (result.hasError) {
            //en cas d'erreur quelconque (result.hasError)
            return Center(child: Text('Erreur: ${result.error}'));
          }
          return const Center(child: Text('Problème inconnu'));
        });
  }
}
