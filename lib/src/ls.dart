import 'dart:io';

List<Directory> ls(Directory dir) {
  List<FileSystemEntity> content = dir.listSync()
    ..sort((a, b) => a.path.compareTo(b.path));
  var dirs = <Directory>[];
  content.forEach((item) {
    if (item is Directory) dirs.add(Directory(item.path));
  });
  return dirs;
}
