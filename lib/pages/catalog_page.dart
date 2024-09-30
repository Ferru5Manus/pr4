import 'package:flutter/material.dart';
import '../model/animegirl.dart';
import 'components/animegirl_component.dart';
import 'edit_animegirl_page.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  List<AnimeGirl> animeGirls = [
    AnimeGirl.fromJson({
      "id": "001",
      "name": "Эрешкигаль",
      "description": "Богиня подземного мира из Fate/Grand Order, известная своей силой и красотой.",
      "imagePath": "images/tile001.jpg",
      "isAsset": true,
    }),
    AnimeGirl.fromJson({
      "id": "002",
      "name": "Асука Лангли Сорью",
      "description": "Пилот из Neon Genesis Evangelion, известная своим вспыльчивым характером.",
      "imagePath": "images/tile002.jpg",
      "isAsset": true,
    }),
    AnimeGirl.fromJson({
      "id": "003",
      "name": "Тосака Рин",
      "description": "Маг из Fate/stay night, известная своим умом и боевыми навыками.",
      "imagePath": "images/tile003.jpg",
      "isAsset": true,
    }),
    AnimeGirl.fromJson({
      "id": "004",
      "name": "Рем",
      "description": "Верная горничная из Re:Zero, известная своей силой и преданностью друзьям.",
      "imagePath": "images/tile004.jpg",
      "isAsset": true,
    }),
    AnimeGirl.fromJson({
      "id": "005",
      "name": "Микаса Аккерман",
      "description": "Умелая солдатка из Attack on Titan, яростно защищающая своих друзей.",
      "imagePath": "images/tile005.jpg",
      "isAsset": true,
    }),
  ];

  void _addNewAnimeGirl() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: EditAnimeGirlPage(
            onSave: (newAnimeGirl) {
              setState(() {
                animeGirls.add(newAnimeGirl);
                _sortAnimeGirls();
              });
            },
          ),
        );
      },
    );
  }

  void _editAnimeGirl(int index) {
    final AnimeGirl animeGirl = animeGirls[index];
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: EditAnimeGirlPage(
            animeGirl: animeGirl,
            onSave: (updatedAnimeGirl) {
              setState(() {
                animeGirls[index] = updatedAnimeGirl;
                _sortAnimeGirls();
              });
            },
          ),
        );
      },
    );
  }

  void _deleteAnimeGirl(int index) {
    setState(() {
      animeGirls.removeAt(index);
    });
  }

  void _voteForAnimeGirl(int index) {
    setState(() {
      animeGirls[index].votes += 1;
      _sortAnimeGirls();
    });
  }

  void _sortAnimeGirls() {
    animeGirls.sort((a, b) => b.votes.compareTo(a.votes));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.black54,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
        title: const Center(child: Text('Animegirls Vote'), ),
      ),
      body: ListView.builder(
        itemCount: animeGirls.length,
        itemBuilder: (BuildContext context, int index) {
          AnimeGirl animeGirl = animeGirls[index];
          return Dismissible(
            key: Key(animeGirl.id),
            direction: DismissDirection.horizontal,
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                _editAnimeGirl(index);
                return false;
              } else if (direction == DismissDirection.endToStart) {
                return true;
              }
              return false;
            },
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                _deleteAnimeGirl(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${animeGirl.name} dismissed')),
                );
              }
            },
            background: Container(
              color: Colors.green,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20.0),
              child: const Icon(Icons.edit, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: AnimegirlComponent(
              animeGirl: animeGirl,
              onVote: () => _voteForAnimeGirl(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewAnimeGirl,
        child: const Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
