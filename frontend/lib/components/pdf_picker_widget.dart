import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:path/path.dart' as path;
import '/constants/app_colors.dart';
import '/constants/app_font_styles.dart';
import '../constants/app_sizes.dart';
import 'custom_button.dart';

class PdfPickerWidget extends StatefulWidget {
  const PdfPickerWidget({super.key, required this.onPdfPicked, this.pdfName});
  final Function(File) onPdfPicked;
  final String? pdfName;
  @override
  State<PdfPickerWidget> createState() => _PdfPickerWidgetState();
}

class _PdfPickerWidgetState extends State<PdfPickerWidget> {
  File? pickedPdfFile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        children: [
          Container(
            height: 120,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color: secondaryColor,
              ),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p4),
            child: Text(
              pickedPdfFile != null
                  ? path.basename(pickedPdfFile!.path)
                  : widget.pdfName ?? 'No File',
              style: secondaryStyle.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          gapH12,
          CustomButton(
            borderRadius: 8,
            height: 40,
            elevation: 5,
            color: pickedPdfFile != null ? wrong : secondaryColor,
            label: pickedPdfFile != null ? 'Reselect' : 'Choose Pdf',
            leadingIcon: IconlyLight.document,
            onPressed: _pickPdf,
          ),
        ],
      ),
    );
  }

  void _pickPdf() async {
    String? filePath = await FlutterDocumentPicker.openDocument();
    if (filePath != null) {
      setState(() {
        pickedPdfFile = File(filePath);
      });
      widget.onPdfPicked(pickedPdfFile!);
    }
  }
}
