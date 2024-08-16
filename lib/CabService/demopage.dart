import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
  final String data;
  const DemoPage({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Text('${data} '),
      ),
    );
  }
}
