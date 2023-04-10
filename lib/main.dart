import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/flutter_survey.dart';
import 'package:survey_flutter/result_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Survey Demo',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, hassError) {
          return const MyHomePage(title: 'Flutter Survey');
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  List<QuestionResult> _questionResults = [];
  final List<Question> _initialData = [
    Question(
      isMandatory: true,
      question: '당신의 성별은?',
      answerChoices: const {
        "남자": null,
        "여자": null,
      },
    ),
    Question(
      question: "당신의 연령은?",
      isMandatory: true,
      answerChoices: const {
        "10대": null,
        "20대": null,
        "30대": null,
        "40대": null,
        "50대": null,
        "60대 이상": null,
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Survey(
            onNext: (questionResults) {
              _questionResults = questionResults;
            },
            initialData: _initialData),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.cyanAccent, // Background Color
              ),
              child: const Text("Validate"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _onPressedSendButton(_questionResults);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onPressedSendButton(List<QuestionResult> questionresult) {
    Resultdata resultdata = Resultdata(
        age: questionresult[1].answers[0],
        gender: questionresult[0].answers[0]);

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore
          .collection('survey/daZIh3BoiUKXzwqmNIxK/result')
          .add(resultdata.toMap());
    } catch (ex) {
      log('error');
    }
  }
}
