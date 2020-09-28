import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test4/config/date_time_data.dart';
import 'package:test4/config/note_actions.dart';
import 'package:test4/config/notes/bloc/note_bloc.dart';
import 'package:test4/screens/home.dart';

class UpdateNoteScreen extends StatelessWidget {
  Map<String, dynamic> _note;
  bool changeDetector = false;

  UpdateNoteScreen({Map note}) {
    this._note = {}..addAll(note);
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
                    _updateButton(context, _noteBloc)
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
          _updateButton(context, _noteBloc),
        ])
      ],
    );
  }

  RaisedButton _updateButton(BuildContext context, NoteBloc _noteBloc) {
    return RaisedButton(
      onPressed: () async {
        _note['title'] = _titleController.text;
        _note['description'] = _descriptionController.text;

        await updateNote(note: _note);
        _noteBloc.add(UpdateNoteListEvent());

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      },
      child: Text('Update'),
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
    _titleController.text = _note['title'];
    return TextFormField(
      onChanged: (value) {
        changeDetector = true;
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
    _descriptionController.text = _note['description'];
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
