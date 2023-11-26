import 'package:flutter/material.dart';

class MainScrean extends StatefulWidget {
  const MainScrean({Key? key}) : super(key: key);

  @override
  _MainScreanState createState() => _MainScreanState();
}

class _MainScreanState extends State<MainScrean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainScrean'),
      ),
      body: const Center(
        child: Text('MainScrean is working'),
      ),
    );
  }
}
