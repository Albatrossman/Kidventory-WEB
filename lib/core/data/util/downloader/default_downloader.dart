import 'dart:io';

import 'package:kidventory_flutter/core/data/util/dio_client.dart';
import 'package:kidventory_flutter/core/data/util/downloader/downloader.dart';
import 'package:path_provider/path_provider.dart';

class DefaultDownloader extends Downloader {
  final DioClient client;

  DefaultDownloader(this.client);

  @override
  Future<void> download(url) async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();

      final filePath = '${directory.path}/Template.csv';
      await client.dio.download(url, filePath);
      print('File is downloaded to $filePath');
    } catch (e) {
      print('Error downloading file: $e');
      rethrow;
    }
  }
}
