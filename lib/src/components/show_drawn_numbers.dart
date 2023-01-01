import 'package:flutter/material.dart';

class ShowDrawnNumbers extends StatelessWidget {
  final String letter;
  final List<int> numbers;
  const ShowDrawnNumbers({
    Key? key,
    required this.letter,
    required this.numbers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          letter,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 200,
          height: 250,
          child: Card(
            color: Colors.deepPurple,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                padding: const EdgeInsets.all(5.0),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                crossAxisCount: 4,
                children: List<Widget>.generate(
                  numbers.length,
                  (index) {
                    return ClipOval(
                      child: Container(
                        color: Colors.white,
                        height: 50.0,
                        width: 50.0,
                        child: Center(
                          child: Text(
                            '${numbers[index]}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
