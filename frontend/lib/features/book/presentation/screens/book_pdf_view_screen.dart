import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '/components/custom_app_top_bar.dart';

@RoutePage()
class BookPdfViewScreen extends StatelessWidget {
  final String path;
  final String bookName;
  final int currentPage;

  const BookPdfViewScreen({
    super.key,
    required this.path,
    required this.bookName,
    this.currentPage = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        showLeadingButton: true,
        title: bookName,
      ),
      body: PDFView(
        filePath: path,
        defaultPage: currentPage,
        enableSwipe: true,
        fitEachPage: true,
        swipeHorizontal: true,
        fitPolicy: FitPolicy.BOTH,
        onPageChanged: (page, total) {
          log(page.toString());
        },
      ),
    );
  }
}
