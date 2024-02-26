import 'package:flutter/material.dart';
import 'dart:math';

class Question {
  final String text;
  final List<String> options;
  final String answer;

  const Question({
    required this.text,
    required this.options,
    required this.answer,
  });
}

List<Question> questions = [
  const Question(
    text: "Of what wood was Noah’s Ark made?",
    options: ["Acacia wood", "Gopher wood", "Cedar of Lebanon", "Carob wood"],
    answer: "Gopher wood",
  ),
  const Question(
    text: "How long was the ark?",
    options: ["500 cubits", " 100 cubits", "300 cubits", "250 cubits"],
    answer: "300 cubits",
  ),
  const Question(
    text: "For how long did the flood rain fall?  ",
    options: [
      "80 days and nights",
      " 12 days and nights",
      "107 days and nights",
      "40 days and 40 nights"
    ],
    answer: "40 days and 40 nights",
  ),
  const Question(
    text: "How long did the flood cover the earth?",
    options: [" 19 days", "150 days", " 50 days", "15 days"],
    answer: "150 days",
  ),
  const Question(
    text: "How old was Joseph when his brethren sold him into slavery?",
    options: ["69", " 23", "17", "90"],
    answer: "17",
  ),
  const Question(
    text: "Who suggested that Joseph interpret the dreams of Pharaoh?",
    options: ["Potiphar", "The cupbearer", "Judah", "The baker"],
    answer: "The cupbearer",
  ),
  const Question(
    text: "What are the names of Joseph’s two sons?",
    options: [
      "John and Mark",
      "Cain and Abel",
      "Ephraim and Manasseh",
      "Dan and Naphtali"
    ],
    answer: "Ephraim and Manasseh",
  ),
  const Question(
    text: "What are the names of Joseph’s two sons?",
    options: [
      "John and Mark",
      "Cain and Abel",
      "Ephraim and Manasseh",
      "Dan and Naphtali"
    ],
    answer: "Ephraim and Manasseh",
  ),
  const Question(
    text: "What are the names of Joseph’s two sons?",
    options: [
      "John and Mark",
      "Cain and Abel",
      "Ephraim and Manasseh",
      "Dan and Naphtali"
    ],
    answer: "Ephraim and Manasseh",
  ),
  const Question(
    text: "What are the names of Joseph’s two sons?",
    options: [
      "John and Mark",
      "Cain and Abel",
      "Ephraim and Manasseh",
      "Dan and Naphtali"
    ],
    answer: "Ephraim and Manasseh",
  ),
  const Question(
    text: "What are the names of Joseph’s two sons?",
    options: [
      "John and Mark",
      "Cain and Abel",
      "Ephraim and Manasseh",
      "Dan and Naphtali"
    ],
    answer: "Ephraim and Manasseh",
  ),

  // Add more questions here
];

void main() {
  questions.shuffle(); // Shuffle the questions
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentQuestionIndex = 0;
  String questionText = '';
  String? selectedOption;
  int correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    _updateQuestion();
  }

  void _updateQuestion() {
    if (currentQuestionIndex < 10) {
      final question = questions[currentQuestionIndex];
      setState(() {
        questionText = question.text;
        selectedOption = null; // Reset selected option
      });
    } else {
      // Quiz completed, show results
      _showResults();
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Quiz Results"),
        content:
            Text("You Scored $correctAnswers out of 10 questions correctly."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _restartQuiz();
            },
            child: const Text("Restart Quiz"),
          ),
        ],
      ),
    );
  }

  void _restartQuiz() {
    setState(() {
      questions.shuffle(); // Shuffle the questions for a new quiz
      currentQuestionIndex = 0;
      correctAnswers = 0;
      _updateQuestion();
    });
  }

  List<Widget> _buildOptions() {
    return questions[currentQuestionIndex].options.map((option) {
      return RadioListTile<String>(
        title: Text(
          option,
          style: TextStyle(fontSize: 20),
        ),
        value: option,
        groupValue: selectedOption,
        onChanged: (String? value) {
          setState(() {
            selectedOption = value;
          });
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 154, 8, 180),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('QUIZ CRAZE'),
        backgroundColor: const Color.fromARGB(255, 75, 11, 86),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Answer The Quiz',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20),
            Text(
              questionText,
              style: const TextStyle(
                fontSize: 30.0,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildOptions(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedOption != null) {
                  // Verify answer
                  if (selectedOption ==
                      questions[currentQuestionIndex].answer) {
                    correctAnswers++;
                  }
                  // Proceed to the next question
                  currentQuestionIndex++;
                  _updateQuestion();
                } else {
                  // Display a message to select an option
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Alert"),
                      content: Text("Please select an option"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text(
                currentQuestionIndex < questions.length - 1
                    ? 'Next Question'
                    : 'Finish',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
