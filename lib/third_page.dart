import 'package:flutter/material.dart';
import "dart:async";
import 'package:floating/floating.dart';
import 'package:sample/second_page.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  //const MyApp({super.key});
  @override
  State<ThirdPage> createState() => _MyAppState();
}

class _MyAppState extends State<ThirdPage> with WidgetsBindingObserver {
  final floating = Floating();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    floating.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    if (lifecycleState == AppLifecycleState.inactive) {
      floating.enable(Rational.square());
    }
  }

  Future<void> enablePip() async {
    final status = await floating.enable(Rational.landscape());
    debugPrint("PiP enabled? $status");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("Open Position Page")),
      body: Center(
        child: PiPSwitcher(
          childWhenDisabled: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Full Screen'),
              ElevatedButton(
                child: const Text('Go Back'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SecondPage()),
                  );
                },
              ),
            ],
          ),
          childWhenEnabled: const Text('Short View'),
        ),
      ),
      floatingActionButton: FutureBuilder<bool>(
        future: floating.isPipAvailable,
        initialData: false,
        builder: (context, snapshot) => snapshot.hasData
            ? PiPSwitcher(
                childWhenDisabled: FloatingActionButton.extended(
                  onPressed: enablePip,
                  label: const Text('Enable PiP'),
                  icon: const Icon(Icons.picture_in_picture),
                ),
                childWhenEnabled: const SizedBox(),
              )
            : const Card(
                child: Text('Pip Unavilable'),
              ),
      ),
    );
  }
}
