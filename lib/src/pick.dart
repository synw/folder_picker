import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'ls.dart';

/// The action to be executed after the folder is picked
typedef Future<void> AfterPickedAction(BuildContext context, Directory folder);

class _FolderPickerState extends State<FolderPicker> {
  _FolderPickerState({@required this.action, @required this.currentDirectory}) {
    try {
      ls(currentDirectory.parent);
    } catch (e) {
      currentDirectory = rootDirectory;
    }
  }

  final textControllerName = new TextEditingController(text: "New Folder");
  final AfterPickedAction action;
  Directory rootDirectory;

  Directory currentDirectory;
  Widget bodyList;

  List<ListTile> _getDirs(BuildContext context) {
    var tiles = <ListTile>[];
    List<Directory> dirs = ls(currentDirectory);
    dirs.forEach((dir) {
      tiles.add(ListTile(
          leading: IconButton(
              icon: const Icon(Icons.folder, color: Colors.yellow),
              onPressed: () => setState(() => currentDirectory = dir)),
          title: GestureDetector(
              onTap: () => setState(() => currentDirectory = dir),
              child: Text(basename(dir.path))),
          trailing: IconButton(
              icon: const Icon(Icons.check_circle),
              onPressed: () {
                Navigator.of(context).pop();
                action(context, dir);
              })));
    });
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    bodyList = ListView(children: _getDirs(context));
    return Scaffold(
      appBar: AppBar(
        leading: rootDirectory != currentDirectory
            ? IconButton(
                icon: Icon(Icons.arrow_upward),
                onPressed: () {
                  try {
                    ls(currentDirectory.parent);
                    setState(() => currentDirectory = currentDirectory.parent);
                  } catch (e) {
                    rootDirectory =
                        currentDirectory; //Don't set state so the up
                                          //arrow doesn't dissapear
                  }
                },
              )
            : null,
        title: const Text("..", textScaleFactor: 1.5),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.create_new_folder),
            onPressed: () {
              return showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Create Folder'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          TextFormField(
                            autofocus: false,
                            controller: textControllerName,
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: const Text('Create'),
                        onPressed: () {
                          Directory(currentDirectory.path +
                                  "/" +
                                  textControllerName.text)
                              .create(recursive: true)
                              .then((Directory directory) {
                            print(directory.path);
                            setState(() {
                              bodyList = ListView(children: _getDirs(context));
                            });
                          });

                          Navigator.of(context).pop();
                          textControllerName.text = "New Folder";
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: bodyList,
    );
  }
}

/// The folder picker page
class FolderPicker extends StatefulWidget {
  /// Main constructor
  FolderPicker({@required this.action, @required this.currentDirectory});

  /// The action to execute after the file is picked
  final AfterPickedAction action;

  /// The directory to start browsing from
  final Directory currentDirectory;

  @override
  _FolderPickerState createState() =>
      _FolderPickerState(action: action, currentDirectory: currentDirectory);
}
