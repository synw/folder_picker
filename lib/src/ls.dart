import 'dart:io';

/// List the directories in a folder
List<Directory> ls(Directory dir) {
  final content = dir.listSync()..sort((a, b) => a.path.compareTo(b.path));
  final dirs = <Directory>[];
  content.forEach((item) {
    if (item is Directory) {
      dirs.add(Directory(item.path));
    }
  });
  return dirs;
}
