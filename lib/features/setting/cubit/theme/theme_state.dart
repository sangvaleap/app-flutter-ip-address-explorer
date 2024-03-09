import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeMode mode;
  final bool isDefaultSystem;

  const ThemeState(
      {this.mode = ThemeMode.system, this.isDefaultSystem = false});

  @override
  List<Object?> get props => [mode, isDefaultSystem];
}
