/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folder_picker/folder_picker.dart';

void main() async {
  final directory = await Directory.systemTemp.createTemp();

  testWidgets('Pick', (WidgetTester tester) async {
    // Build the Widget
    await tester.pumpWidget(FolderPicker(
      rootDirectory: directory,
      action: (context, folder) {
        print("PICKED $folder");
      },
    ));
    await tester.tap(find.byType(ListTile).first);
  });
}*/
