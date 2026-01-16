import 'package:flutter/material.dart';
import '../database/database_manager.dart';
import '../modele/redacteur.dart';

class RedacteurInterface extends StatefulWidget {
  @override
  _RedacteurInterfaceState createState() => _RedacteurInterfaceState();
}

class _RedacteurInterfaceState extends State<RedacteurInterface> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  List<Redacteur> redacteurs = [];

  @override
  void initState() {
    super.initState();
    chargerRedacteurs();
  }

  Future<void> chargerRedacteurs() async {
    final data = await DatabaseManager.getAllRedacteurs();
    setState(() {
      redacteurs = data;
    });
  }

  Future<void> ajouterRedacteur() async {
    if (_nomController.text.isEmpty ||
        _prenomController.text.isEmpty ||
        _emailController.text.isEmpty)
      return;

    final r = Redacteur(
      nom: _nomController.text,
      prenom: _prenomController.text,
      email: _emailController.text,
    );

    await DatabaseManager.insertRedacteur(r);
    _nomController.clear();
    _prenomController.clear();
    _emailController.clear();
    chargerRedacteurs();
  }

  void modifierRedacteur(Redacteur r) {
    final nomCtrl = TextEditingController(text: r.nom);
    final prenomCtrl = TextEditingController(text: r.prenom);
    final emailCtrl = TextEditingController(text: r.email);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Modifier le rédacteur"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomCtrl,
              decoration: const InputDecoration(labelText: "Nom"),
            ),
            TextField(
              controller: prenomCtrl,
              decoration: const InputDecoration(labelText: "Prénom"),
            ),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Annuler"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Modifier"),
            onPressed: () async {
              final updated = Redacteur(
                id: r.id,
                nom: nomCtrl.text,
                prenom: prenomCtrl.text,
                email: emailCtrl.text,
              );
              await DatabaseManager.updateRedacteur(updated);
              Navigator.pop(context);
              chargerRedacteurs();
            },
          ),
        ],
      ),
    );
  }

  void supprimerRedacteur(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Supprimer"),
        content: const Text("Voulez-vous vraiment supprimer ce rédacteur ?"),
        actions: [
          TextButton(
            child: const Text("Non"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Oui"),
            onPressed: () async {
              await DatabaseManager.deleteRedacteur(id);
              Navigator.pop(context);
              chargerRedacteurs();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        title: const Text(
          "Gestion des Rédacteurs",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: "Nom"),
            ),
            TextField(
              controller: _prenomController,
              decoration: const InputDecoration(labelText: "Prénom"),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 10),

            ElevatedButton.icon(
              icon: const Icon(Icons.add, color: Colors.black),
              label: const Text(
                "Ajouter un Rédacteur",
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: ajouterRedacteur,
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: redacteurs.length,
                itemBuilder: (_, i) {
                  final r = redacteurs[i];
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text("${r.nom} ${r.prenom}"),
                      subtitle: Text(r.email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => modifierRedacteur(r),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => supprimerRedacteur(r.id!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
