import 'package:flutter/material.dart';

class AcceptRejectService extends StatelessWidget {
  const AcceptRejectService({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Accept/Reject'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text('Accept/Reject Service'),
            ],
          ),
        ),
      ),
    );
  }
}
