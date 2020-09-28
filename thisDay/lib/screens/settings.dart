import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thisDay/config/theme/bloc/theme_bloc.dart';
import 'package:thisDay/config/theme_data.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeBloc = BlocProvider.of<ThemeBloc>(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
            appBar: _buildAppBar(context), body: _buildBody(state, _themeBloc));
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(title: Text('Settings'));
  }

  ListView _buildBody(ThemeState state, ThemeBloc _themeBloc) {
    return ListView(
      children: [
        _listTileForDarkMode(state, _themeBloc),
        _listTileForAccentColor(state,_themeBloc),
      ],
    );
  }

  ListTile _listTileForAccentColor(ThemeState state, ThemeBloc _themeBloc) {
    return ListTile(
      leading: Icon(Icons.color_lens, color: getAccentColor(state.accentcolor)),
      title: Text('Accent Color'),
      onTap: () {
        _themeBloc.add(AccentColorChangedEvent());
      },
    );
  }

  ListTile _listTileForDarkMode(ThemeState state, ThemeBloc _themeBloc) {
    return ListTile(
      leading: Icon(Icons.brightness_4),
      title: Text('Dark'),
      trailing: Switch(
          value: state.val,
          onChanged: (bool value) {
            _themeBloc.add(BrightnessChangedEvent(value));
          }),
    );
  }
}
