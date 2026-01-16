import 'package:flutter/material.dart';
import 'interface/redacteur_interface.dart';

void main() {
  runApp(const MonAppli());
}

// 1. Classe principale de configuration
class MonAppli extends StatelessWidget {
  const MonAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magazine Infos',
      debugShowCheckedModeBanner: false,
      home: const pageAccueil(), // Magazine Infos reste la page d’accueil
    );
  }
}

// 2. Classe pageAccueil (inchangée)
class pageAccueil extends StatelessWidget {
  const pageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magazine Infos'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => RedacteurInterface()),
            );
          },
        ),
        actions: const [Icon(Icons.search), SizedBox(width: 10)],
      ),

      body: const SingleChildScrollView(
        child: Column(
          children: [
            Image(image: AssetImage('assets/Images/Magazineinfos.png')),
            PartieTitre(),
            PartieTexte(),
            PartieIcone(),
            PartieRubrique(),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Tu as cliqué dessus');
        },
        backgroundColor: Colors.pink,
        child: const Text('Click'),
      ),
    );
  }
}

// 3. Classe PartieTitre
class PartieTitre extends StatelessWidget {
  const PartieTitre({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Titre du premier niveau",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            "Titre du second niveau",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// 4. Classe PartieTexte
class PartieTexte extends StatelessWidget {
  const PartieTexte({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Text(
        "Magazine Infos est un magazine numérique moderne qui offre à ses lecteurs "
        "des articles variés sur la mode, la presse, la culture et les tendances actuelles.",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

// 5. Classe PartieIcone
class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: const [
              Icon(Icons.phone, color: Colors.pink),
              SizedBox(height: 5),
              Text("TEL", style: TextStyle(color: Colors.pink)),
            ],
          ),
          Column(
            children: const [
              Icon(Icons.email, color: Colors.pink),
              SizedBox(height: 5),
              Text("MAIL", style: TextStyle(color: Colors.pink)),
            ],
          ),
          Column(
            children: const [
              Icon(Icons.share, color: Colors.pink),
              SizedBox(height: 5),
              Text("PARTAGE", style: TextStyle(color: Colors.pink)),
            ],
          ),
        ],
      ),
    );
  }
}

// 6. Classe PartieRubrique
class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/Images/Presse.jpg',
              width: 150,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/Images/Mode.png',
              width: 150,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
