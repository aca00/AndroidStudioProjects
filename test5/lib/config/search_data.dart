import 'package:flutter/material.dart';

import 'package:noteIt/screens/update_note.dart';

import 'note_actions.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Note> noteList;
  CustomSearchDelegate(this.noteList);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List getList() {
      List<String> list = [];
      noteList.forEach((element) {
        list.add(element.title);
      });
      debugPrint(' string List  : ${list}');
      return list;
    }

    List<String> stringList = getList();
    final suggestionList =
        stringList.where((element) => element.startsWith(query)).toList();

    debugPrint('  suggestionList : ${suggestionList}');
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context, int i) {
        return ListTile(
          title: Text(suggestionList[i]),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditNoteScreen(noteList[i], 'Update')));
          },
        );
      },
    );
  }
}
