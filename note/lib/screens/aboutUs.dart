import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  Color _frameColor;
  Color _textColor;
  Color _accentColor;
  Color _cardColor;
  AboutUsScreen(
      Color frameColor, Color textColor, Color accentColor, Color cardColor) {
    this._frameColor = frameColor;
    this._accentColor = accentColor;
    this._textColor = textColor;
    this._cardColor = cardColor;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: this._frameColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: this._accentColor,
        ),
        backgroundColor: this._frameColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Note It',
          style: TextStyle(fontWeight: FontWeight.bold, color: this._textColor),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(children: <Widget>[
          Card(
            color: this._cardColor,
            child: Center(
              child: Text(
                'About',
                style: TextStyle(color: this._textColor),
              ),
            ),
          ),
          Card(
              color: this._cardColor,
              child: Center(
                child: Text(
                  'Mail Address',
                  style: TextStyle(color: this._textColor),
                ),
              ))
        ]),
      ),
    );
  }
}
