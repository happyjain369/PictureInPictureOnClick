import 'package:flutter/material.dart';
import 'package:sample/first_page.dart';
import 'package:sample/third_page.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('NO PIP here'),
            ElevatedButton(
              child: const Text('There is one more screen'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdPage()),
                ); //Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('Go Back to the Home Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FirstPage()),
                );
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
