import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConnectionPage extends StatelessWidget {
  const ConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: FormConnexion()),

    );
  }
}
class FormConnexion extends StatefulWidget {
  const FormConnexion({
    super.key,
  });

  @override
  State<FormConnexion> createState() => _FormConnexionState();
}

class _FormConnexionState extends State<FormConnexion> {

  final _keyForm = GlobalKey<FormState>();
  final textEditContID = TextEditingController();
  final textEditContPWD = TextEditingController();
  var switchRemember = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _keyForm,
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Connexion à Twitter"),
            TextFormField(
              controller: textEditContID,
              decoration: const InputDecoration(hintText: "Identifiant"),
              validator: (val){
                if(val == null || val.isEmpty){
                  return "Veuillez remplir le champ";
                }
                if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z.]{2,6}$").hasMatch(val)){
                  return "Vérifier le format (ex: john@kennedy.gov)";
                }
                return null;
              },
            ),
            TextFormField(
              controller: textEditContPWD,
              decoration: const InputDecoration(hintText: "Mot de passe"),
              validator: (val){
                if(val == null || val.isEmpty){
                  return "Veuillez remplir le champ";
                }
                return null;
              },
            ),
            SwitchListTile(controlAffinity: ListTileControlAffinity.leading,
              value: switchRemember,
              onChanged: (val){
                setState(() {
                  switchRemember = val;

                });
              },
              title: const Text("Mémoriser mes informations"),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton.icon(
                  onPressed: (){
                    if(_keyForm.currentState?.validate() == true){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Bienvenu ${textEditContID.text}")
                          )
                      );
                      context.go("/homepage",extra: textEditContID.text);
                    }
                  }, icon: const Icon(Icons.login
              ),
                  label: const Text("Connexion")),
            )
          ],),
      ),
    );
  }
}