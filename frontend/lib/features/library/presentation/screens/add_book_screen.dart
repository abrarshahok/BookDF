// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import '../widgets/custom_dropdown_button_form_field.dart';
import '/components/custom_button.dart';
import '/constants/app_colors.dart';
import '/components/pdf_picker_widget.dart';
import '/constants/app_sizes.dart';
import '/constants/app_font_styles.dart';
import '/providers/library_books_provider.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../../components/image_picker_widget.dart';
import '/states/load_state.dart';

@RoutePage()
class AddBookScreen extends StatelessWidget {
  AddBookScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _genre = 'All';

  final _genres = const [
    'All',
    'Romance',
    'Sci-Fi',
    'Fantasy',
    'Classics',
    'Technology',
    'Education',
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<LibraryBooksProvider>(
      builder: (ctx, provider, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'Add Book',
              style: titleStyle,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImagePickerWidget(
                        onImagePicked: (image) => provider.selectImage(image),
                      ),
                      gapW8,
                      PdfPickerWidget(
                        onPdfPicked: (pdf) => provider.selectPdf(pdf),
                      ),
                    ],
                  ),
                  gapH20,
                  Text(
                    'Book Title',
                    style: secondaryStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  gapH4,
                  CustomTextFormField(
                    controller: _titleController,
                    hintText: 'Enter title here',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the title';
                      }
                      return null;
                    },
                  ),
                  gapH20,
                  Text(
                    'Book Author',
                    style: secondaryStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  gapH4,
                  CustomTextFormField(
                    controller: _authorController,
                    hintText: 'Enter author name here',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the author';
                      }
                      return null;
                    },
                  ),
                  gapH20,
                  Text(
                    'Book Description',
                    style: secondaryStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  gapH4,
                  CustomTextFormField(
                    controller: _descriptionController,
                    hintText: 'Enter description here',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the description';
                      }
                      return null;
                    },
                  ),
                  gapH20,
                  CustomDropdownButtonFormField(
                    initialValue: _genre,
                    labelText: 'Genere',
                    items: _genres,
                    onChanged: (String? genre) {
                      _genre = genre!;
                    },
                    validator: (String? genre) {
                      if (genre == null || genre.isEmpty) {
                        return 'Please select book genere';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 0,
            color: bgColor,
            child: CustomButton(
              label: provider.state is LoadingState ? 'Saving...' : 'Add Book',
              textStyle: buttonStyle,
              borderRadius: 8,
              elevation: 5,
              onPressed: provider.state is LoadingState
                  ? null
                  : () {
                      final isValid = _formKey.currentState!.validate();

                      if (!isValid) {
                        return;
                      }

                      provider.addBook(
                        title: _titleController.text,
                        author: _authorController.text,
                        description: _descriptionController.text,
                        coverImage: provider.coverImage,
                        pdf: provider.pdfFile,
                        genre: _genre,
                        context: context,
                      );
                    },
            ),
          ),
        );
      },
    );
  }
}
