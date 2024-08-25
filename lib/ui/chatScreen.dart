import 'package:flutter/material.dart';

class NotificationPagScreen extends StatelessWidget {
  final String id;
  const NotificationPagScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(id),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ElevatedButton(
                  onPressed: () {
                    print("accepted");
                  },
                  child: Text("Accept")),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: ElevatedButton(
                  onPressed: () {
                    print("rejected");
                  },
                  child: Text("Reject")),
            )
          ],
        ),
      ),
    ));
  }
}
