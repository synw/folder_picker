import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:filex/filex.dart';
import 'picker.dart';

class _FolderPickerPageState extends State<FolderPickerPage> {
  _FolderPickerPageState(
      {@required this.action,
      @required this.rootDirectory,
      this.controller,
      this.compact = false,
      this.pickerIcon =
          const Icon(Icons.check_circle, color: Colors.grey, size: 20.0)}) {
    controller ??= FilexController(path: rootDirectory.path);
  }

  final AfterPickedAction action;
  final Directory rootDirectory;
  final bool compact;
  FilexController controller;
  Icon pickerIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(basename(controller.directory.path)),
      ),
      body: FolderPicker(
        action: action,
        rootDirectory: rootDirectory,
        controller: controller,
        compact: compact,
        pickerIcon: pickerIcon,
      ),
    );
  }
}

class FolderPickerPage extends StatefulWidget {
  FolderPickerPage(
      {@required this.action,
      @required this.rootDirectory,
      this.controller,
      this.compact = false,
      this.pickerIcon =
          const Icon(Icons.check_circle, color: Colors.grey, size: 20.0)});

  final AfterPickedAction action;
  final Directory rootDirectory;
  final bool compact;
  final FilexController controller;
  final Icon pickerIcon;

  @override
  _FolderPickerPageState createState() => _FolderPickerPageState(
      action: action,
      rootDirectory: rootDirectory,
      controller: controller,
      compact: compact,
      pickerIcon: pickerIcon);
}
