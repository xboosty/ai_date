import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
// import 'package:mime/mime.dart';

Future<List<MultipartFile>> convertFileListToMultipartFileList(
    List<File?> fileList) async {
  List<MultipartFile> multipartFiles = [];

  for (var file in fileList) {
    if (file != null) {
      String fileName = file.path.split('/').last;
      MultipartFile multipartFile = await MultipartFile.fromFile(file.path,
          filename: fileName,
          contentType: MediaType('image', 'jpeg'),
          headers: {
            "type": ["image/jpeg"],
          });
      multipartFiles.add(multipartFile);
    }
  }

  return multipartFiles;
}
