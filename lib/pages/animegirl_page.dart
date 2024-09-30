import 'package:flutter/material.dart';

import '../model/animegirl.dart';

const String title = "Vote";
const String successMessage = "Voted!";
const String errorMessage = "Vote aborted";
const String acceptButtonTitle = "Vote";

class AnimegirlPage extends StatelessWidget {
  final AnimeGirl animeGirl;

  const AnimegirlPage({super.key, required this.animeGirl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
        title: const Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
                children: [
                  Text(
                    animeGirl.name,
                    style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    animeGirl.description,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Image(image: AssetImage('images/tile${animeGirl.id}.jpg'), width: 200, height: 200),
                  ),
                ]
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(successMessage, style: TextStyle(fontSize: 24),),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text(acceptButtonTitle, style: TextStyle(fontSize: 30, color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
