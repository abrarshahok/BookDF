import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:auto_route/auto_route.dart';
import '/dependency_injection/dependency_injection.dart';
import '/features/auth/data/respository/auth_respository.dart';
import '../../../../providers/reading_session_respository_provider.dart';
import '/components/custom_app_top_bar.dart';

@RoutePage()
class BookPdfViewScreen extends StatefulWidget {
  final String path;
  final String bookName;
  final String sessionId;
  final int currentPage;

  const BookPdfViewScreen({
    super.key,
    required this.path,
    required this.bookName,
    required this.sessionId,
    required this.currentPage,
  });

  @override
  State<BookPdfViewScreen> createState() => _BookPdfViewScreenState();
}

class _BookPdfViewScreenState extends State<BookPdfViewScreen> {
  late int _currentPage;
  late int _initialPage;

  @override
  void initState() {
    super.initState();
    _fetchInitialSession();
  }

  void _fetchInitialSession() async {
    _currentPage = widget.currentPage;
    _initialPage = _currentPage;
    log(_initialPage.toString());
  }

  void _onPageChanged(int? page, int? total) {
    _initialPage = _currentPage;
    _currentPage = page!;
    _updateSession();
  }

  void _updateSession() async {
    final jwt = AuthRepository.instance.jwt!;
    final provider = locator<ReadingSessionRepositoryProvider>();
    if (!(_currentPage <= _initialPage)) {
      await provider.updateSession(jwt, widget.sessionId, _currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        showLeadingButton: true,
        title: widget.bookName,
      ),
      body: PDFView(
        filePath: widget.path,
        defaultPage: _currentPage,
        enableSwipe: true,
        fitEachPage: true,
        swipeHorizontal: true,
        fitPolicy: FitPolicy.BOTH,
        onPageChanged: _onPageChanged,
      ),
    );
  }
}
