import 'dart:io';
import 'package:flutter/material.dart';
import 'package:filex/filex.dart';

/// The action to be executed after the folder is picked
typedef AfterPickedAction = Future<void> Function(
    BuildContext context, Directory folder);

class _FolderPickerState extends State<FolderPicker> {
  _FolderPickerState(
      {required this.action,
      required this.rootDirectory,
      this.controller,
      this.compact = false,
      this.pickerIcon =
          const Icon(Icons.check_circle, color: Colors.grey, size: 20.0)}) {
    controller ??= FilexController(path: rootDirectory.path);
  }

  final AfterPickedAction action;
  final Directory rootDirectory;
  final bool compact;
  FilexController? controller;
  Icon pickerIcon;

  @override
  Widget build(BuildContext context) {
    return Filex(
        controller: controller!,
        compact: compact,
        showOnlyDirectories: true,
        directoryTrailingBuilder: (context, folder) {
          return GestureDetector(
              onTap: () => action(context, folder.item as Directory),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 3.0, 0),
                  child: pickerIcon));
        });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}

class FolderPicker extends StatefulWidget {
  FolderPicker(
      {required this.action,
      required this.rootDirectory,
      this.controller,
      this.compact = false,
      this.pickerIcon =
          const Icon(Icons.check_circle, color: Colors.grey, size: 20.0)});

  final AfterPickedAction action;
  final Directory rootDirectory;
  final bool compact;
  final FilexController? controller;
  final Icon pickerIcon;

  @override
  _FolderPickerState createState() => _FolderPickerState(
      rootDirectory: rootDirectory, action: action, controller: controller);
}
