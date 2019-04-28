import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:folder_picker/folder_picker.dart';
import 'package:flutter/material.dart';

class _FolderPickerPageState extends State<FolderPickerPage> {
  Directory externalDirectory;
  Directory pickedDirectory;

  @override
  void initState() {
    getExternalStorageDirectory()
        .then((directory) => setState(() => externalDirectory = directory));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: (externalDirectory != null)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        RaisedButton(
                          child:
                              const Text("Pick a folder", textScaleFactor: 1.3),
                          onPressed: () => Navigator.of(context)
                                  .push<FolderPicker>(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return FolderPicker(
                                    rootDirectory: externalDirectory,
                                    action: (BuildContext context,
                                        Directory folder) async {
                                      print("Picked directory $folder");
                                      setState(() => pickedDirectory = folder);
                                    });
                              })),
                        ),
                        (pickedDirectory != null)
                            ? Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Text("${pickedDirectory.path}"),
                              )
                            : const Text('')
                      ])
                : const CircularProgressIndicator()));
  }
}

class FolderPickerPage extends StatefulWidget {
  @override
  _FolderPickerPageState createState() => _FolderPickerPageState();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Folder picker Demo',
      home: FolderPickerPage(),
      theme: ThemeData.dark(),
    );
  }
}

void main() => runApp(MyApp());
