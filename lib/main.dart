import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'IM-Lab-9'),
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
  final model = Model();
  final answers = <String>[];
  final questions = <String>[];

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ColoredBox(
        color: const Color.fromRGBO(244, 244, 245, 1),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 65.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 400,
                  child: ListView.builder(
                      controller: _controller,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: answers.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10,),
                            BubbleSpecialOne(
                              text: questions[index],
                              isSender: true,
                              color: Colors.purple.shade100,
                              textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.purple,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            BubbleSpecialOne(
                              text: answers[index],
                              isSender: false,
                              color: Colors.purple.shade100,
                              textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.purple,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        );
                      }),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 400,
                width: 400,
                child: MessageBar(
                  onSend: (srt) {
                    setState(() {
                      questions.add(srt);
                      answers.add(model.answer);
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
