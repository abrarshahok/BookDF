import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:bookdf/providers/auth_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconly/iconly.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import '../../../../components/custom_border_button.dart';
import '../../../../components/custom_button.dart';
import '../../../../providers/reading_session_respository_provider.dart';
import '../../../../states/load_state.dart';
import '../../../../utils/save_base64_pdf.dart';
import '../../../auth/data/respository/auth_respository.dart';
import '../../../book/data/models/reading_session.dart';
import '../../../book/data/respository/reading_session_repository.dart';
import '/components/custom_memory_image.dart';
import '/constants/app_colors.dart';
import '/constants/app_font_styles.dart';
import '/constants/app_sizes.dart';
import '/features/book/data/models/book.dart';
import '/components/confirmation_dialogue.dart';
import '/components/custom_icon_button.dart';
import '/dependency_injection/dependency_injection.dart';
import '/providers/library_books_provider.dart';
import '/routes/app_router.gr.dart';

class LibraryBookContainer extends StatefulWidget {
  const LibraryBookContainer({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  State<LibraryBookContainer> createState() => _LibraryBookContainerState();
}

class _LibraryBookContainerState extends State<LibraryBookContainer> {
  Color? dominantColor;
  bool isLoading = false;
  late Uint8List bytes;

  @override
  void initState() {
    super.initState();
    _updatePalette();
  }

  Future<void> _updatePalette() async {
    isLoading = true;
    bytes = base64Decode(widget.book.coverImage!.split(',').last);
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      MemoryImage(bytes),
    );

    if (mounted) {
      setState(() {
        dominantColor = paletteGenerator.dominantColor?.color ??
            secondaryAccentColor.withOpacity(0.5);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(BookDetailsRoute(book: widget.book)),
      key: widget.key,
      child: Container(
        height: 144,
        width: 290,
        key: ValueKey(widget.book.id!),
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 144,
              width: 100,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isLoading ? secondaryAccentColor : dominantColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: isLoading
                  ? null
                  : CustomMemoryImage(
                      imageString: widget.book.coverImage!,
                      height: 100,
                      width: 100,
                      cacheKey: widget.book.coverImage!,
                    ),
            ),
            gapW12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.book.title!,
                    style: titleStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.book.author!,
                    style: secondaryStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Consumer<AuthRepositoryProvider>(builder: (ctx, provider, _) {
                    final currentReadings =
                        AuthRepository.instance.currentUser!.currentReadings!;
                    bool isBookInCurrentReading =
                        currentReadings.contains(widget.book.id);
                    return Row(
                      children: [
                        if (isBookInCurrentReading)
                          CustomBorderButton(
                            label: 'Continue Reading',
                            height: 29,
                            width: 120,
                            borderRadius: 8,
                            onPressed: () =>
                                _openPdfScreen(isBookInCurrentReading, context),
                          )
                        else
                          CustomButton(
                            label: 'Read',
                            height: 29,
                            width: 80,
                            borderRadius: 8,
                            onPressed: () =>
                                _openPdfScreen(isBookInCurrentReading, context),
                          ),
                        gapW8,
                        CustomButton(
                          label: 'Edit',
                          height: 29,
                          width: 70,
                          borderRadius: 8,
                          onPressed: () {
                            context.router
                                .push(AddBookRoute(book: widget.book));
                          },
                        ),
                        const Spacer(),
                        CustomIconButton(
                          onTap: () {
                            ConfirmationDialogue(
                              context: context,
                              onTapPrimary: () {
                                final libraryProvider =
                                    locator<LibraryBooksProvider>();
                                libraryProvider.deleteBook(
                                  widget.book.id!,
                                  context,
                                );
                                context.router.maybePop();
                              },
                              onTapSecondary: () {
                                context.router.maybePop();
                              },
                              title: 'Are you sure?',
                              subtitle: 'Do you want to delete book?',
                              buttonTextSecondary: 'Cancel',
                              buttonTextPrimary: 'I Confirm!',
                              textAlign: TextAlign.left,
                            ).show();
                          },
                          icon: IconlyBold.delete,
                          iconColor: wrong,
                        )
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openPdfScreen(bool isBookInCurrentReading, BuildContext context) {
    final book = widget.book;

    final fileName = book.title!.replaceAll(' ', '-') + book.id!;
    final base64Pdf = book.pdf!.data!.split(',').last;

    saveBase64Pdf(base64Pdf, fileName).then((path) {
      if (isBookInCurrentReading) {
        final currentBookSession = ReadingSessionsRepository
            .instance.readingSessions
            .firstWhere((session) => session.bookId == book.id);
        return context.router.push(BookPdfViewRoute(
          path: path,
          bookName: book.title!,
          currentPage: currentBookSession.currentPage,
          sessionId: currentBookSession.id,
        ));
      } else {
        final provider = locator<ReadingSessionRepositoryProvider>();
        return provider.createSession(book.id!, book.pages!).then((value) {
          final state = provider.state;
          if (state is SuccessState) {
            final sessions = state.data as List<ReadingSession>;
            final session = sessions.first;
            return context.router.push(BookPdfViewRoute(
              path: path,
              bookName: book.title!,
              sessionId: session.id,
              currentPage: session.currentPage,
            ));
          } else if (state is ErrorState) {
            log(state.errorMessage);
          }
        });
      }
    }).catchError((err) {
      log(err.toString());
      throw err;
    });
  }
}
