# Folder picker

[![pub package](https://img.shields.io/pub/v/folder_picker.svg)](https://pub.dartlang.org/packages/folder_picker)

A directory picker for Flutter

## Usage

A picker page is available as well as a standalone widget.

   ```dart
   import 'package:folder_picker/folder_picker.dart';

   Navigator.of(context).push<FolderPickerPage>(
      MaterialPageRoute(
         builder: (BuildContext context) {
            return FolderPickerPage(
               rootDirectory: externalDirectory, /// a [Directory] object
               action: (BuildContext context, Directory folder) async {
                 print("Picked folder $folder");
               });
   }));
   ```

To allow directory creation:

   ```dart
   final controller = FilexController(path: externalDirectory.path);
   FolderPicker(
      rootDirectory: externalDirectory,
      controller: controller
      // ...
   )
   ```

And then use the controller when you want to create a directory:

   ```dart
   controller.createDirectory(name); // name is a String
   ```

To get just the widget and not a full page use `FolderPicker`

## Parameters

- **rootDirectory** `Directory` *required*: the top level directory to start from
- **action** `AfterPickedAction` *required*: the action to perform after picking
- **compact**: `bool` *default* `false`: use compact display
- **pickerIcon**: `Icon`: the icon to use for the picker
- **controller**: `FilexController` the file explorer controller used to create directories

## Permissions

   ```xml
   <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
   ```
