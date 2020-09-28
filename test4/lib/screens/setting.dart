import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test4/config/theme/bloc/theme_bloc.dart';


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
    return AppBar(
      title: Text('Settings'),
      leading: _iconButtonNavigationAboutUs(),
      actions: [
        _iconButtonNavigationHomeScreen(context),
      ],
    );
  }

  ListView _buildBody(ThemeState state, ThemeBloc _themeBloc) {
    return ListView(
      children: [
        _listTileForDarkMode(state, _themeBloc),
        _listTileForAccentColor(_themeBloc),
        
      ],
    );
  }

  ListTile _listTileForAccentColor(ThemeBloc _themeBloc) {
    return ListTile(
    
      title: Text('Accent Color'),
      onTap: () {
        _themeBloc.add(AccentColorChangedEvent());
      },
    );
  }

  ListTile _listTileForDarkMode(ThemeState state, ThemeBloc _themeBloc) {
    return ListTile(
      //dark mode
      title: Text('Dark'),
      trailing: Switch(
          value: state.val,
          onChanged: (bool value) {
            _themeBloc.add(BrightnessChangedEvent(value));
          }),
    );
  }

  IconButton _iconButtonNavigationAboutUs() {
    return IconButton(
      icon: Icon(Icons.info),
      onPressed: () {},
    );
  }
}

IconButton _iconButtonNavigationHomeScreen(context) {
  return IconButton(
    icon: Icon(Icons.bubble_chart),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}
