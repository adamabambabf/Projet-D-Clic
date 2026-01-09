import 'package:flutter/material.dart';

void main() {
  runApp(const MonAppli());
}

// Premier Widget : Configuration (Stateless)
class MonAppli extends StatelessWidget {
  const MonAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magazine', // Titre demandé page 6
      debugShowCheckedModeBanner: false, // Pour enlever la bande "Debug"
      home: const pageAccueil(),
    );
  }
}

// Deuxième Widget : Interface (Stateless comme demandé Figure 4)
class pageAccueil extends StatelessWidget {
  const pageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magazine Infos'), // Titre page 7
        centerTitle: true,
        backgroundColor: Colors.pink, // Couleur Figure 1
        leading: const Icon(Icons.menu), // Icône menu à gauche
        actions: const [
          Icon(Icons.search), // Icône recherche à droite
          SizedBox(width: 10),
        ],
      ),
      body: Center(
        // Utilisation de l'image déclarée dans ton pubspec.yaml
        child: Image.asset('assets/images/magazineInfos.JPEG.png'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action demandée page 7 : afficher un message en console
          print('Tu as cliqué dessus');
        },
        backgroundColor: Colors.pink,
        child: const Text('Click'), // Texte demandé sur le bouton
      ),
    );
  }
}
