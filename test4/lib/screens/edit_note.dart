import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test4/config/date_time_data.dart';
import 'package:test4/config/note_actions.dart';
import 'package:test4/config/notes/bloc/note_bloc.dart';
import 'package:test4/screens/home.dart';

class EditNoteScreen extends StatelessWidget {
  bool changeDetector = false;
  String _title;
  String _description;
  EditNoteScreen({String title, String description}) {
    this._title = title;
    this._description = description;
  }
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _noteBloc = BlocProvider.of<NoteBloc>(context);
    return Scaffold(
      appBar: _buildAppBar(context, _noteBloc),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context, NoteBloc _noteBloc) {
    return AppBar(
      title: getDate(),
      leading: IconButton(
        onPressed: () {
          if (changeDetector == false) {
            Navigator.pop(context);
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Just a moment....'),
                  content: Text('Do you want to save changes before closing?'),
                  actions: [
                    FlatButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    _saveButton(context, _noteBloc)
                  ],
                );
              },
            );
          }
        },
        icon: Icon(Icons.arrow_back),
      ),
      actions: <Widget>[
        ButtonBar(children: [
          _saveButton(context, _noteBloc),
        ])
      ],
    );
  }

  RaisedButton _saveButton(BuildContext context, NoteBloc _noteBloc) {
    return RaisedButton(
      onPressed: () async {
        await saveNote(
            title: _titleController.text, des: _descriptionController.text);
        _noteBloc.add(UpdateNoteListEvent());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      },
      child: Text('Save'),
    );
  }

  ListView _buildBody() {
    return ListView(
      padding: EdgeInsets.all(12.0),
      children: <Widget>[
        _titleTextFormField(),
        SizedBox(height: 12.0),
        _desctiptionTextFormField()
      ],
    );
  }

  TextFormField _titleTextFormField() {
    _titleController.text = this._title;
    return TextFormField(
      controller: _titleController,
      onChanged: (value) {
        changeDetector = true;
      },
      maxLengthEnforced: false,
      autofocus: false,
      maxLines: null,
      style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      decoration: InputDecoration.collapsed(hintText: 'Title'),
    );
  }

  TextFormField _desctiptionTextFormField() {
    _descriptionController.text = this._description;
    return TextFormField(
      controller: _descriptionController,
      onChanged: (value) {
        changeDetector = true;
      },
      maxLines: null,
      style: TextStyle(fontSize: 18.0),
      decoration: InputDecoration.collapsed(hintText: "Add details"),
    );
  }
}
