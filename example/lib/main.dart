import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission/permission.dart';
import 'package:folder_picker/folder_picker.dart';
import 'package:flutter/material.dart';

class _FolderPickerDemoState extends State<FolderPickerDemo> {
  Directory externalDirectory;
  Directory pickedDirectory;

  Future<void> getPermissions() async {
    final permissions =
        await Permission.getPermissionsStatus([PermissionName.Storage]);
    var request = true;
    switch (permissions[0].permissionStatus) {
      case PermissionStatus.allow:
        request = false;
        break;
      case PermissionStatus.always:
        request = false;
        break;
      default:
    }
    if (request) {
      await Permission.requestPermissions([PermissionName.Storage]);
    }
  }

  Future<void> getStorage() async {
    final directory = await getExternalStorageDirectory();
    setState(() => externalDirectory = directory);
  }

  Future<void> init() async {
    await getPermissions();
    await getStorage();
  }

  @override
  void initState() {
    super.initState();
    init();
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
                              .push<FolderPickerPage>(MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return FolderPickerPage(
                                rootDirectory: externalDirectory,
                                action: (BuildContext context,
                                    Directory folder) async {
                                  print("Picked directory $folder");
                                  setState(() => pickedDirectory = folder);
                                  Navigator.of(context).pop();
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

class FolderPickerDemo extends StatefulWidget {
  @override
  _FolderPickerDemoState createState() => _FolderPickerDemoState();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Folder picker Demo',
      home: FolderPickerDemo(),
      theme: ThemeData.dark(),
    );
  }
}

void main() => runApp(MyApp());
