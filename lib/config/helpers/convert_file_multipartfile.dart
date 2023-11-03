import 'dart:io';
import 'package:dio/dio.dart';

Future<List<MultipartFile>> convertFileListToMultipartFileList(
    List<File?> fileList) async {
  List<MultipartFile> multipartFiles = [];

  for (var file in fileList) {
    if (file != null) {
      String fileName = file.path.split('/').last;
      MultipartFile multipartFile =
          await MultipartFile.fromFile(file.path, filename: fileName);
      multipartFiles.add(multipartFile);
    }
  }

  return multipartFiles;
}
