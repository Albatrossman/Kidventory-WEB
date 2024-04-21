import 'dart:io';

import 'package:kidventory_flutter/core/domain/model/color.dart';

class EventScreenState {
  final bool loading;
  final List<File> files;

  EventScreenState({
    this.loading = false,
    List<File>? files,
  }) : files = files ?? [];

  EventScreenState copy({
    bool? loading,
    List<File>? files,
    EventColor? color,
    String? description,
  }) {
    return EventScreenState(
      loading: loading ?? this.loading,
      files: files ?? this.files,
    );
  }
}
