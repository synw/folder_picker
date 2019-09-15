# Folder picker

[![pub package](https://img.shields.io/pub/v/folder_picker.svg)](https://pub.dartlang.org/packages/folder_picker)

A directory picker for Flutter

## Usage

   ```dart
   import 'package:folder_picker/folder_picker.dart';

   Navigator.of(context).push<FolderPicker>(
      MaterialPageRoute(
         builder: (BuildContext context) {
            return FolderPicker(
               rootDirectory: externalDirectory, /// a [Directory] object
               action: (BuildContext context, Directory folder) async {
                 print("Picked folder $folder");
               });
   }));
   ```

## Permissions

   ```xml
   <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
   ```
