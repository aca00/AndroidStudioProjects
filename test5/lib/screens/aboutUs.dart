import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About'),
        ),
        body: ListView(
          children: [
            Center(
              child: Text('This app is developed for learning purpose only'),
            ),
            SizedBox(height: 12),
            Center(
                child: Text(
                    "Privacy? Don't worry. \n I am a beginner and don't know how to  make use of your data. Once I learnt I will add privacy policy sure..!")),
            
            SizedBox(
              height: 12
            ),
            Center(
              child: Text('T&C? Nothing special. You can use it at your will'),
            ),
            SizedBox(height: 12),
            Center(
              child: Text(
                  'Support? Nothing like that. I said I built this for learning new stuffs.'),
            ),
            SizedBox(height: 12),
          ],
        ));
  }
}
