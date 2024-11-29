import 'package:flutter/material.dart';

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('g'),
            Row(
              children: [
                Text('g2'),
                Text('k'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
