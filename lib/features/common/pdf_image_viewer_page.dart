import 'dart:io';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FileViewerPage extends StatelessWidget {
  final String appBarName;
  final String fileUrl;

  const FileViewerPage({
    Key? key,
    required this.appBarName,
    required this.fileUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, appBarName),
      body: Center(
        child: getFileWidget(context, fileUrl),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => downloadFile(fileUrl),
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.file_download,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget getFileWidget(BuildContext context, String fileUrl) {
    String extension = fileUrl.split('.').last.toLowerCase();
    if (extension == 'pdf') {
      return FutureBuilder(
        future: getPdf(fileUrl),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return PDFView(filePath: snapshot.data!);
          }
          return const Text('Error loading PDF');
        },
      );
    } else if (extension == 'jpg' ||
        extension == 'jpeg' ||
        extension == 'png') {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: Image.network(
          fileUrl,
          fit: BoxFit.contain,
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: Text(
          'Unsupported file type: $extension',
          style: const TextStyle(fontSize: 18),
        ),
      );
    }
  }

  Future<String> getPdf(String url) async {
    var response = await http.get(Uri.parse(url));
    final document = await savePdf(response.bodyBytes);
    return document.path;
  }

  Future<File> savePdf(List<int> pdfBytes) async {
    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.pdf';
    final pdfFile = File(tempDocumentPath);
    await pdfFile.writeAsBytes(pdfBytes, flush: true);
    return pdfFile;
  }

  Future<void> downloadFile(String url) async {
    var urlLink = Uri.parse(url);
    // ignore: deprecated_member_use
    await launch(urlLink.toString());
  }
}
