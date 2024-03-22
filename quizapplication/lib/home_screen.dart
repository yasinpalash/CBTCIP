import 'package:flutter/material.dart';
import 'package:quizapplication/summary_screen.dart';
import 'package:quizapplication/widgets.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  SharedPreferences? sharedPreferences;
  int highestScore = 0;
  int quizNumber = 1;
  int questionIndex = 0;
  int score = 0;
  bool isAnswered = false;

  List<String> questions = [
    'What is the capital of France?',
    'Who painted the Mona Lisa?',
    'What is the largest planet in our solar system?',
    'Which gas do plants absorb from the atmosphere?',
    'What is the largest mammal on Earth?',
    'Who wrote the play "Romeo and Juliet"?',
    'What is the chemical symbol for gold?',
    'Which country is known as the Land of the Rising Sun?',
  ];

  List<List<String>> options = [
    ['Paris', 'London', 'Madrid', 'Rome'],
    ['Leonardo da Vinci', 'Pablo Picasso', 'Vincent van Gogh', 'Claude Monet'],
    ['Saturn', 'Mars', 'Earth', 'Jupiter'],
    ['Carbon dioxide', 'Oxygen', 'Nitrogen', 'Hydrogen'],
    ['Blue whale', 'African elephant', 'Giraffe', 'Hippopotamus'],
    ['William Shakespeare', 'Charles Dickens', 'Jane Austen', 'George Orwell'],
    ['Au', 'Ag', 'Fe', 'Hg'],
    ['Japan', 'China', 'South Korea', 'India'],
  ];

  List<String> correctAnswers = ['Paris', 'Leonardo da Vinci', 'Jupiter', 'Carbon dioxide', 'Blue whale', 'William Shakespeare', 'Au', 'Japan'];

  List<String> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      highestScore = sharedPreferences?.getInt('highestScore') ?? 0;
    });
  }

  void checkAnswer(String selectedOption) {
    if (isAnswered) {
      return;
    }

    String correctAnswer = correctAnswers[questionIndex];
    bool isCorrect = selectedOption == correctAnswer;

    setState(() {
      selectedAnswers.add(selectedOption);
      isAnswered = true;

      if (isCorrect) {
        score++;
        sharedPreferences?.setInt('highestScore', score);
      }
    });
  }

  void shareScore() {
    String message = 'I scored $score out of ${questions.length} in the quiz app!';
    Share.share(message);
  }

  void nextQuestion() {
    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
        isAnswered = false;
      });
    } else {
      // Handle quiz completion
      navigateToSummaryScreen();
    }
  }

  void navigateToSummaryScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(
          totalScore: score,
          highestScore: highestScore,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Question ${questionIndex + 1}:',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey
              ),
            ),
            const SizedBox(height: 8),
            Text(
              questions[questionIndex],
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: options[questionIndex]
                  .asMap()
                  .entries
                  .map(
                    (entry) => OptionItem(
                  index: entry.key,
                  text: entry.value,
                  isSelected: selectedAnswers.contains(entry.value),
                  isCorrect: entry.value == correctAnswers[questionIndex],
                  showCorrectAnswer: isAnswered && entry.value == correctAnswers[questionIndex],
                  onSelected: () {
                    if (!isAnswered) {
                      checkAnswer(entry.value);
                    }
                  },
                ),
              )
                  .toList(),
            ),
            const SizedBox(height: 16),
            // Text(
            //   'Correct Answer: ${correctAnswers[questionIndex]}',
            //   style: const TextStyle(
            //     color: Colors.grey,
            //     fontWeight: FontWeight.w600,
            //     fontSize: 22
            //   ),
            // ),
            // const SizedBox(height: 16),
            ElevatedButton(
              onPressed: nextQuestion,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              child: const Text('Next Question', style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 16),
            Text(
              'Score: $score / ${questions.length}',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: shareScore,
                ),
              ],
            ),

            Text(
              'Highest Score: $highestScore',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),

          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quiz $quizNumber',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              'High Score: $highestScore',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
