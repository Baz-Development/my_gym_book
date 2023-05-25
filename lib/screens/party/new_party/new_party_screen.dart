import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/group_model.dart';
import 'package:my_gym_book/common/models/user_model.dart';
import 'package:my_gym_book/common/services/firebase_analytics_service.dart';
import 'package:my_gym_book/common/theme_helper.dart';
import 'package:my_gym_book/repository/firebase_groups_repository.dart';
import 'package:my_gym_book/repository/firebase_user_repository.dart';
import 'package:uuid/uuid.dart';

class NewPartyScreen extends StatefulWidget {
  const NewPartyScreen({super.key});

  @override
  _NewPartyScreenState createState() => _NewPartyScreenState();
}

class _NewPartyScreenState extends State<NewPartyScreen>{
  final GroupRepository _groupRepository = GroupRepository();
  final _formKey = GlobalKey<FormState>();

  TextEditingController partyNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var email = FirebaseAuth.instance.currentUser?.email;
    if (email == null) {
      return;
    }
    FirebaseAnalyticsService.logEvent(
        "group_create_start",
        {
          "email": email
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Gym Book"),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: Center(
        child: createNewPartyForms()
      )
    );
  }

  Widget createNewPartyForms() {
     return Container(
       margin: const EdgeInsets.fromLTRB(25, 25, 25, 10),
       padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
       alignment: Alignment.center,
       child: Column(
         children: [
           Form(
             key: _formKey,
             child: Column(
               children: [
                 const Text(
                   "Cadastro",
                   style: TextStyle(
                       fontSize: 50,
                       color: Colors.grey
                   ),
                 ),
                 const SizedBox(height: 20.0),
                 Container(
                   decoration: ThemeHelper().inputBoxDecorationShaddow(),
                   child: TextFormField(
                     controller: partyNameController,
                     autovalidateMode: AutovalidateMode.onUserInteraction,
                     decoration: ThemeHelper().textInputDecoration('Nome do grupo', 'Insira o nome do grupo'),
                     validator: (val) {
                       if (val!.isEmpty) {
                         return "A nome é obrigatório";
                       }
                       return null;
                     },
                   ),
                 ),
                 const SizedBox(height: 20.0),
                 SizedBox(
                   height: 50,
                   width: double.infinity,
                   child: ElevatedButton(
                     child: const Padding(
                       padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                       child: Text(
                         "Salvar",
                         style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                           color: Colors.white,
                         ),
                       ),
                     ),
                     onPressed: () {
                       if (_formKey.currentState!.validate()) {
                         var partyName = partyNameController.text;
                         createParty(partyName);
                         Navigator.pop(context, 1);
                       }
                     },
                   ),
                 ),
               ],
             ),
           ),
         ],
       ),
     );
  }

  Future<void> createParty(String partyName) async {
    var email = FirebaseAuth.instance.currentUser?.email;
    if (email == null) {
      return;
    }
    var user = await getUser(email);
    var group = GroupModel(
      Uuid().v4(),
      partyName,
      [
        user
      ]
    );
    _groupRepository.createGroup(group);
    FirebaseAnalyticsService.logEvent(
        "group_created",
        {
          "email": email
        }
    );
  }
}