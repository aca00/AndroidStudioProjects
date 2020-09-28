import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteIt/config/note_actions.dart';
import 'package:noteIt/config/notes/bloc/note_bloc.dart';
import 'package:noteIt/config/search_data.dart';
import 'package:noteIt/config/theme_data.dart';

import 'package:noteIt/screens/setting.dart';
import 'package:animations/animations.dart';
import 'package:noteIt/screens/update_note.dart';

class HomeScreen extends StatelessWidget {

  List<Note> noteList;
  bool deleteCheck = true;
  @override
  Widget build(BuildContext context) {
    final _noteBloc = BlocProvider.of<NoteBloc>((context));
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      final List<Note> _listOfNotes = state.noteList.reversed.toList();
      return Scaffold(
          floatingActionButton: _buildFloatingActionButton(context),
          appBar: _buildAppBar(context, _listOfNotes),
          body: ListView.builder(
              itemCount: state.itemCount,
              itemBuilder: (BuildContext context, int i) {
                final Note _note = _listOfNotes[i];
                final int _star = _note.starred;
                final String _titleText = _note.title;
                final String _descriptionText = _note.description;
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Deleted'),
                        action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              this.deleteCheck = false;
                              _noteBloc.add(UpdateNoteListEvent());
                              debugPrint(
                                  ' OnPressed deleteCheck  : ${deleteCheck}');
                            }),
                        duration: Duration(milliseconds: 700),
                      ));
                      await Future.delayed(Duration(milliseconds: 1200));
                      if (deleteCheck == true) {
                        debugPrint(
                            ' undo not pressed deleteCheck : ${deleteCheck}');
                        await deletNote(id: _note.id);

                        _noteBloc.add(UpdateNoteListEvent());
                      } else if (deleteCheck == false) {
                        deleteCheck = true;
                      }
                    } else if (direction == DismissDirection.endToStart) {
                      await starNote(_note);
                      _noteBloc.add(UpdateNoteListEvent());
                    }
                  },
                  background: Container(
                    color: Colors.transparent,
                    child: Icon(Icons.delete),
                  ),
                  secondaryBackground: Container(
                    color: Colors.transparent,
                    child: Icon(Icons.star),
                  ),
                  child: OpenContainer(
                    closedElevation: 0,
                    closedColor: Colors.transparent,
                    closedBuilder: (context, action) =>
                        _buildNoteCard(_star, _titleText, _descriptionText),
                    openBuilder: (context, action) => buildViewMode(
                        context, _titleText, _descriptionText, _note),
                  ),
                );
              }));
    });
  }

  Card _buildNoteCard(int _star, String _titleText, String _descriptionText) {
    return Card(
      child: ListTile(
        trailing: Icon(
          Icons.star,
          size: 11,
          color: getStarColor(_star),
        ),
        title: Text(
          _titleText,
          maxLines: 1,
        ),
        subtitle: Text(
          _descriptionText,
          maxLines: 2,
        ),
      ),
    );
  }

  
  AppBar _buildAppBar(BuildContext context, List<Note> noteList) {
    return AppBar(
      leading: _searchButton(context, noteList),
      title: Text('Notes'),
      actions: <Widget>[_iconButtonNavigationSettings(context)],
    );
  }

  IconButton _iconButtonNavigationSettings(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SettingScreen()));
        },
        icon: Icon(
          Icons.settings,
        ));
  }

  IconButton _searchButton(context, List<Note> noteList) {
    return IconButton(
      onPressed: () {
        showSearch(context: context, delegate: CustomSearchDelegate(noteList));
      },
      icon: Icon(
        Icons.search,
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.add,
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EditNoteScreen(Note('', '', '', 0), 'Save')));
      },
    );
  }
}

starNote(Note note) async {
  if (note.starred == 1) {
    note.starred = 0;
  } else if (note.starred == 0) {
    note.starred = 1;
  }
  await saveNote(note);
}
Scaffold buildViewMode(BuildContext context, String _titleText,
      String _descriptionText, Note note) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditNoteScreen(note, 'Update')));
              })
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: [
          Text(
            _titleText,
            style: TextStyle(fontSize: 28),
          ),
          SizedBox(height: 12.0),
          Text(
            _descriptionText,
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
