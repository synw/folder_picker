import 'dart:async';
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
    _dirName = basename(rootDirectory.path);
  }

  final AfterPickedAction action;
  final Directory rootDirectory;
  final bool compact;
  FilexController controller;
  Icon pickerIcon;

  String _dirName;
  StreamSubscription<List<DirectoryItem>> _sub;

  @override
  void initState() {
    super.initState();
    _sub = controller.changefeed.listen((_) {
      var n = basename(controller.directory.path);
      if (n == "0") {
        n = "Pick a folder";
      }
      setState(() => _dirName = n);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_dirName),
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

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
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
