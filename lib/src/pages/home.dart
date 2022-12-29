import 'package:bingo/src/components/ball_draw.dart';
import 'package:bingo/src/components/show_drawn_numbers.dart';
import 'package:bingo/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeController = Homecontroller();

  shuffler() {
    if (_homeController.numbers.length < 75) {
      _homeController.startGameBallAnimation();
    } else {
      _showMyDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFedede9),
      appBar: AppBar(
        title: const Text("BINGO"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: _homeController.clearingGameData)
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ValueListenableBuilder<int>(
              valueListenable: _homeController.lastNumberDrawn,
              builder: (context, value, _) {
                return BallDrawn(
                  letter: _homeController.letter,
                  number: value,
                  numberAnimation: _homeController.animatonSpeed,
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _homeController.isEnabledButton,
              builder: (context, value, _) {
                return ElevatedButton(
                  onPressed: value ? () {} : shuffler,
                  child: const Text("Sortear números"),
                );
              },
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 350,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: Text(
                            "Números que já saíram",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ValueListenableBuilder<List<int>>(
                                valueListenable: _homeController.letterBNumbers,
                                builder: (context, value, _) {
                                  return ShowDrawnNumbers(
                                      letter: 'B', numbers: value);
                                },
                              ),
                              ValueListenableBuilder<List<int>>(
                                valueListenable: _homeController.letterINumbers,
                                builder: (context, value, _) {
                                  return ShowDrawnNumbers(
                                      letter: 'I', numbers: value);
                                },
                              ),
                              ValueListenableBuilder<List<int>>(
                                valueListenable: _homeController.letterNNumbers,
                                builder: (context, value, _) {
                                  return ShowDrawnNumbers(
                                      letter: 'N', numbers: value);
                                },
                              ),
                              ValueListenableBuilder<List<int>>(
                                valueListenable: _homeController.letterGNumbers,
                                builder: (context, value, _) {
                                  return ShowDrawnNumbers(
                                      letter: 'G', numbers: value);
                                },
                              ),
                              ValueListenableBuilder<List<int>>(
                                valueListenable: _homeController.letterONumbers,
                                builder: (context, value, _) {
                                  return ShowDrawnNumbers(
                                      letter: 'O', numbers: value);
                                },
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Os números do BINGO são de 1 a 75',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const Text('Já saíram todos os números.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
