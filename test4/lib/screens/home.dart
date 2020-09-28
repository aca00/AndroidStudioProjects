import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test4/config/note_actions.dart';
import 'package:test4/config/notes/bloc/note_bloc.dart';
import 'package:test4/config/search_data.dart';
import 'package:test4/config/theme_data.dart';
import 'package:test4/screens/edit_note.dart';
import 'package:test4/screens/setting.dart';
import 'package:animations/animations.dart';
import 'package:test4/screens/update_note.dart';

class HomeScreen extends StatelessWidget {
  bool deleteCheck = true;
  @override
  Widget build(BuildContext context) {
    Note note;

    final _noteBloc = BlocProvider.of<NoteBloc>((context));
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(context),
      appBar: _buildAppBar(context),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          final List _listOfNotes = state.db.reversed.toList();
          return ListView.builder(
              itemCount: state.itemCount,
              itemBuilder: (BuildContext context, int i) {
                Map<String, dynamic> _note = {}..addAll(_listOfNotes[i]);
                debugPrint('  _note : ${_note}');
                final int _star = _note['starred'];
                final String _titleText = _note['title'];
                final String _descriptionText = _note['description'];
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
                        await deletNote(id: _note['_id']);

                        _noteBloc.add(UpdateNoteListEvent());
                      } else if (deleteCheck == false) {
                        deleteCheck = true;
                      }
                    } else if (direction == DismissDirection.endToStart) {
                      if (_note['starred'] == 0) {
                        _note['starred'] = 1;
                      } else if (_note['starred'] == 1) {
                        _note['starred'] = 0;
                      }

                      await updateNote(note: _note);
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
                    closedBuilder: (context, action) => Card(
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
                    ),
                    openBuilder: (context, action) => Scaffold(
                      appBar: AppBar(
                        actions: [
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateNoteScreen(
                                              note: _note,
                                            )));
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
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: _searchButton(context),
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

  IconButton _searchButton(context) {
    return IconButton(
      onPressed: () {
        showSearch(context: context, delegate: CustomSearchDelegate());
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
            context, MaterialPageRoute(builder: (context) => EditNoteScreen()));
      },
    );
  }
}
