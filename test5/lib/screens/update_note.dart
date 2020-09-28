import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteIt/config/date_time_data.dart';
import 'package:noteIt/config/note_actions.dart';
import 'package:noteIt/config/notes/bloc/note_bloc.dart';
import 'package:noteIt/screens/home.dart';

class EditNoteScreen extends StatelessWidget {
  final Note note;

  final String _buttonName;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  EditNoteScreen(this.note, [this._buttonName]);

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
                  _saveButton(context, _noteBloc, note)
                ],
              );
            },
          );
        },
        icon: Icon(Icons.arrow_back),
      ),
      actions: <Widget>[
        ButtonBar(children: [
          _saveButton(context, _noteBloc, note),
        ])
      ],
    );
  }

  RaisedButton _saveButton(
      BuildContext context, NoteBloc _noteBloc, Note note) {
    return RaisedButton(
      onPressed: () async {
        await saveNote(note);
        _noteBloc.add(UpdateNoteListEvent());

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      },
      child: Text(this._buttonName),
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
    _titleController.text = note.title;
    return TextFormField(
      onChanged: (value) {
        note.title = _titleController.text;
      },
      controller: _titleController,
      maxLengthEnforced: false,
      autofocus: false,
      maxLines: null,
      style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      decoration: InputDecoration.collapsed(hintText: 'Title'),
    );
  }

  TextFormField _desctiptionTextFormField() {
    _descriptionController.text = note.description;
    return TextFormField(
      controller: _descriptionController,
      onChanged: (value) {
        note.description = _descriptionController.text;
      },
      maxLines: null,
      style: TextStyle(fontSize: 18.0),
      decoration: InputDecoration.collapsed(hintText: "Add details"),
    );
  }
}
