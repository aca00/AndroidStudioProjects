import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thisDay/config/bloc/config_bloc.dart';
import 'package:thisDay/config/bloc/month_bloc.dart';
import 'package:thisDay/config/bloc/change_bloc.dart';
import 'package:thisDay/config/date_time_data.dart';
import 'package:thisDay/config/entry.dart';
import 'package:thisDay/config/theme_data.dart';
import 'package:thisDay/screens/universalEditScreen.dart';

final double titleFontSize = 18.0;
final double descriptionFontSize = titleFontSize - 1;
final titleController = TextEditingController();
final descriptionController = TextEditingController();
final yearController = TextEditingController();

class UniversalWidget {
  BuildContext context;
  dynamic blocc;
  dynamic blocc2;
  Entry entry;
  dynamic blocc3;

  // UniversalWidget();

  UniversalWidget.addEventBottomSheet({this.context, this.entry}) {
    eventBottomSheet();
  }

  UniversalWidget.addDeleteConfirmationAlert(
      {this.context, this.entry, bool checkStory}) {
    deleteConfirmationAlert(checkStory: checkStory);
  }

  UniversalWidget.addEditDeleteAlert({this.context, this.entry}) {
    editDeleteAlert();
  }

  UniversalWidget.addEditAlert(
      {this.context,
      String appBarTitle,
      dynamic queryDay,
      int queryMonth,
      dynamic queryCode,
      dynamic queryYear,
      dynamic storyId,
      dynamic storyName}) {
    editAlert(
        storyName: storyName,
        appBarTitle: appBarTitle,
        queryDay: queryDay,
        queryMonth: queryMonth,
        queryCode: queryCode,
        queryYear: queryYear,
        storyId: storyId);
  }

  eventBottomSheet() {
    titleController.text = "${this.entry.title ?? ''}";
    yearController.text = "${this.entry.year ?? ''}";
    descriptionController.text = "${this.entry.description ?? ''}";
    this.blocc = BlocProvider.of<ConfigBloc>(this.context);
    this.blocc2 = BlocProvider.of<MonthBloc>(this.context);
    this.blocc3 = BlocProvider.of<UpdateEventsInsideStoryBloc>(this.context);

    _getMonthName(dynamic val) {
      if (val != null) {
        return monthList[val - 1];
      } else {
        return null;
      }
    }

    this.blocc.add(TheChangeEvent(_getMonthName(this.entry.month),
        this.entry.day, this.entry.priority - 1));
    return showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                pickDate(),
                titleTextFormField(),
                separator(12),
                descriptionTextFormField(),
                separator(170),
                eventButtonBar(),
              ],
            ),
          );
        });
  }

  deleteConfirmationAlert({bool checkStory}) {
    this.blocc3 = BlocProvider.of<UpdateEventsInsideStoryBloc>(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Are you sure want to delete this?'),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          RaisedButton(
            child: Text('Delete'),
            onPressed: () async {
              assert(this.entry.id != null);

              // checking whether story is being deleted
              if (checkStory == true) {
                // we are deleting a story
                await deleteEventsOfStory(storyId: this.entry.id);
                await deleteStory(id: this.entry.id);
              } else if (checkStory == null) {
                // we are deleting  an event
                await deleteEvent(id: this.entry.id);
              }

              Navigator.pop(context);
              this.blocc3.add(UpdateEventsInsideStoryEvent());
            },
          )
        ],
      ),
    );
  }

  editDeleteAlert() {
    showDialog(
        context: this.context,
        builder: (context) => SimpleDialog(
              children: [
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit'),
                  onTap: () {
                    Navigator.pop(context);
                    UniversalWidget.addStoryBottomSheet(
                        context: this.context, entry: this.entry);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                  onTap: () {
                    Navigator.pop(context);
                    UniversalWidget.addDeleteConfirmationAlert(
                        context: this.context,
                        entry: this.entry,
                        checkStory: true);
                  },
                )
              ],
            ));
  }

  editAlert(
      {String appBarTitle,
      dynamic queryDay,
      int queryMonth,
      dynamic queryCode,
      dynamic queryYear,
      dynamic storyId,
      dynamic storyName}) {
    this.context = context;

    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return BlocProvider<UpdateEventsInsideStoryBloc>(
                          create: (context) => UpdateEventsInsideStoryBloc(),
                          child: UniversalEditScreen(
                              appBarTitle,
                              queryDay,
                              queryMonth,
                              queryYear,
                              storyId,
                              queryCode,
                              storyName),
                        );
                      }));
                    }),
              ],
            ));
  }

  UniversalWidget.addStoryBottomSheet({this.context, this.entry}) {
    storyBottomSheet();
  }
  storyBottomSheet() {
    titleController.text = "${this.entry.title ?? ''}";
    descriptionController.text = "${this.entry.description ?? ''}";
    this.blocc = BlocProvider.of<UpdateEventsInsideStoryBloc>(this.context);
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                separator(12),
                titleTextFormField(),
                separator(12),
                descriptionTextFormField(),
                separator(170),
                storyButtonBar(),
                //iconPicker(),
              ],
            ),
          );
        });
  }

  // IconButton addStoryButton({BuildContext context, Entry story}) {
  //   this.entry = story;
  //   this.context = context;
  //   this.blocc = BlocProvider.of<UpdateEventsInsideStoryBloc>(this.context);
  //   return IconButton(
  //     icon: Icon(Icons.add),
  //     onPressed: () {
  //       showModalBottomSheet(
  //           context: context,
  //           builder: (context) {
  //             return Container(
  //               padding: EdgeInsets.all(12),
  //               child: ListView(
  //                 children: [
  //                   separator(12),
  //                   titleTextFormField(),
  //                   separator(12),
  //                   descriptionTextFormField(),
  //                   separator(170),
  //                   storyButtonBar(),
  //                   //iconPicker(),
  //                 ],
  //               ),
  //             );
  //           });
  //     },
  //   );
  // }

  // // FloatingActionButton addEventButton(
  // //     {BuildContext context, ConfigBloc configBloc, Entry entry}) {
  // //   return FloatingActionButton(
  // //     child: Icon(Icons.add),
  // //     onPressed: () {
  // //       //editEventBottomSheet(context: context, entry: entry);
  // //     },
  // //   );
  // // }

  Row pickDate() {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            controller: yearController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(4),
            ],
            decoration: InputDecoration.collapsed(hintText: 'YYYY'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              this.entry.year = int.parse(yearController.text);
              
            },
          ),
        ),
        BlocBuilder<ConfigBloc, ConfigState>(
          builder: (context, state) {
            this.entry.priority = state.priority;

            return IconButton(
                icon: Icon(Icons.bookmark),
                color: getPriorityColor(state.priority),
                onPressed: () {
                  this.blocc.add(
                      TheChangeEvent(state.month, state.date, state.priority));
                });
          },
        ),
        SizedBox(width: 50),
        BlocBuilder<ConfigBloc, ConfigState>(
          builder: (context, state) {
            final int index = monthList.indexOf(state.month);
            this.entry.month = index + 1;

            return DropdownButton(
              value: state.month,
              hint: Text('Month'),
              items: dropDownMonths,
              onChanged: (String value) {
                this
                    .blocc
                    .add(TheChangeEvent(value, state.date, state.priority - 1));
              },
            );
          },
        ),
        SizedBox(width: 20),
        BlocBuilder<ConfigBloc, ConfigState>(
          builder: (context, state) {
            int day = state.date;
            this.entry.day = day;
            return DropdownButton<int>(
              hint: Text('Day'),
              value: state.date,
              items: dropDownDates,
              onChanged: (value) {
                this.entry.day = value;
                this.blocc.add(
                    TheChangeEvent(state.month, value, state.priority - 1));
              },
            );
          },
        )
      ],
    );
  }

  TextFormField descriptionTextFormField() {
    return TextFormField(
      controller: descriptionController,
      style: TextStyle(fontSize: descriptionFontSize),
      onChanged: (value) {
        this.entry.description = descriptionController.text;
      },
      maxLines: 1,
      decoration: InputDecoration.collapsed(hintText: 'Details (Optional)'),
    );
  }

  TextFormField titleTextFormField() {
    return TextFormField(
      controller: titleController,
      maxLines: 1,
      onChanged: (newValue) {
        this.entry.title = titleController.text;
        debugPrint('  live entry : ${this.entry.title}');
      },
      decoration: InputDecoration.collapsed(
        hintText: 'Title',
      ),
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize),
    );
  }

  SizedBox separator(double val) {
    return SizedBox(height: val);
  }

  ButtonBar eventButtonBar() {
    return ButtonBar(children: [cancelButton(), saveEventButton()]);
  }

  FlatButton cancelButton() {
    return FlatButton(
        onPressed: () {
          Navigator.pop(this.context);
        },
        child: Text('Cancel'));
  }

  BlocBuilder saveEventButton() {
    return BlocBuilder<MonthBloc, MonthState>(
      builder: (context, state) {
        return RaisedButton(
          onPressed: () async {
            if (this.entry.title != null) {
              if (this.entry.title != '') {
                CircularProgressIndicator();
                //debugPrint('  adf : ${this.entry.title}');
                await saveEvent(this.entry);
                this.blocc2.add(MonthChangeEvent(state.numMonth));
                this.blocc3.add(UpdateEventsInsideStoryEvent());
                Navigator.pop(context);
              }
            } else {
              // user need to know that title is mandatory
            }
          },
          child: Text('Save'),
        );
      },
    );
  }

  ButtonBar storyButtonBar() {
    debugPrint('   story button: ${this.entry.title}');
    return ButtonBar(
      children: [cancelButton(), saveStoryButton()],
    );
  }

  RaisedButton saveStoryButton() {
    return RaisedButton(
      onPressed: () async {
        if (this.entry.title != null) {
          if (this.entry.title != '') {
            await saveStory(this.entry);
            this.blocc.add(UpdateEventsInsideStoryEvent());
            Navigator.pop(this.context);
          }
        }
      },
      child: Text('Save'),
    );
  }
}

Container addTopic() {
  return Container(
    child: ListView(children: [
      TextFormField(
        decoration: InputDecoration(
          hintText: 'Title',
        ),
        style: TextStyle(fontSize: 12),
      ),
      // iconPicker
    ]),
  );
}

// universal functions

String getMonthName(dynamic val) {
  if (val != null) {
    return "${monthList[val - 1]}";
  }
  return null;
}
