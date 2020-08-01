import 'package:flutter/material.dart';
class EditNoteScreen extends StatefulWidget {
  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sun Jul26',
          style: TextStyle(color: Colors.black, fontSize: 12.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed:(){Navigator.pop(context);},
          icon: Icon(Icons.arrow_back),
          color: Colors.blueAccent,),
        actions: <Widget>[
          FlatButton(
            onPressed: (){},
            child:Text('Save'),
            textColor: Colors.blueAccent, )
        ],

      ),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          TextFormField(
            maxLengthEnforced: false,
            autofocus: true,
            maxLines: null,
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            decoration: InputDecoration.collapsed(
                hintText: 'Title'
            ),
          ),
          //SizedBox(height: 6.0,),
          TextFormField(
            maxLines: null,
            style: TextStyle(fontSize: 18.0,),
            decoration: InputDecoration.collapsed(hintText: "Add details"),
          )
        ],
      ),
    );
  }
}
