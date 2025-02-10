
import 'package:flutter/material.dart';
import 'question.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  // ✅ Fix listChecker with correctly initialized questions
  List<Question> listChecker = [
    Question(questionText: 'You can lead a cow down stairs but not up stairs.', questionAnswers: false),
    Question(questionText: 'Approximately one quarter of human bones are in the feet.', questionAnswers: true),
    Question(questionText: 'A slug\'s blood is green.', questionAnswers: true),
    //Question(questionText: 'Some cats are actually allergic to humans',questionAnswers:  true),
   // Question(questionText: 'You can lead a cow down stairs but not up stairs.',questionAnswers:  false),
    Question(questionText: 'Approximately one quarter of human bones are in the feet.', questionAnswers: true),
    //Question(questionText: 'A slug\'s blood is green.', questionAnswers: true),
    Question(questionText: 'Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', questionAnswers: true),
    Question(questionText: 'It is illegal to pee in the Ocean in Portugal.', questionAnswers: true),
    Question(
        questionText: 'No piece of square dry paper can be folded in half more than 7 times.',
        questionAnswers: false),
    Question(questionText:
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        questionAnswers: true),
    Question(questionText:
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
       questionAnswers:  false),
    Question(questionText:
        'The total surface area of two human lungs is approximately 70 square metres.',
        questionAnswers: true),
  ];

  int questionNumber = 0;

  /*void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = listChecker[questionNumber].questionAnswers;

    setState(() {
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
      } else {
        scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
      }

      // ✅ Prevent index from going out of bounds
      if (questionNumber < listChecker.length - 1) {
        questionNumber++;
      } else {
        // Reset quiz when reaching the end
        questionNumber = 0;
        //scoreKeeper.clear();
      }
    });
  }*/
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = listChecker[questionNumber].questionAnswers;

    setState(() {
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
      } else {
        scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
      }

      // ✅ Fix: Only reset if all 30 questions are answered
      if (questionNumber < listChecker.length - 1) {
        questionNumber++;
      } else {
        // Show alert before resetting
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Quiz Finished!"),
            content: const Text("You've completed the quiz. Restarting..."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    questionNumber = 0;
                    scoreKeeper.clear(); // Reset score
                  });
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                listChecker[questionNumber].questionText, // ✅ Corrected access
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                'True',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                checkAnswer(true); // ✅ Check if answer is correct
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'False',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                checkAnswer(false); // ✅ Check if answer is correct
              },
            ),
          ),
        ),
        Row(
        children: scoreKeeper),
      ],
    );
  }
}
