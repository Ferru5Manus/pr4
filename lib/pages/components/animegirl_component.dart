import 'package:flutter/material.dart';
import 'dart:io';
import '../../model/animegirl.dart';

class AnimegirlComponent extends StatelessWidget {
  final AnimeGirl animeGirl;
  final Function onVote;

  const AnimegirlComponent({super.key, required this.animeGirl, required this.onVote});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(animeGirl.name),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                animeGirl.isAsset
                    ? Image.asset(animeGirl.imagePath, width: 200, height: 200)
                    : Image.file(File(animeGirl.imagePath), width: 200, height: 200),
                const SizedBox(height: 10),
                Text(animeGirl.description),
                const SizedBox(height: 10),
                Text('Votes: ${animeGirl.votes}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  onVote();
                  Navigator.of(context).pop();
                },
                child: const Text('Vote'),
              ),
            ],
          );
        },
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                animeGirl.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                animeGirl.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              animeGirl.isAsset
                  ? Image.asset(animeGirl.imagePath, width: 200, height: 200)
                  : Image.file(File(animeGirl.imagePath), width: 200, height: 200),
              const SizedBox(height: 10),
              Text('Votes: ${animeGirl.votes}'),
            ],
          ),
        ),
      ),
    );
  }
}
