import 'package:flutter/cupertino.dart';

import 'bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ThemeState extends Equatable {
  final ThemeData themeData;

  @override
  List<Object> get props => [];
  ThemeState({this.themeData}) : super();
}
