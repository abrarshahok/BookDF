import 'package:bookdf/dependency_injection/dependency_injection.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '/features/book/data/models/reading_session.dart';
import '/providers/reading_session_respository_provider.dart';
import '/features/auth/data/respository/auth_respository.dart';

import '../../../../states/load_state.dart';
import '/constants/app_font_styles.dart';
import '/constants/app_sizes.dart';
import 'package:flutter/material.dart';

import 'books_category_section.dart';
import 'continue_reading_book_container.dart';

class ContinueReadingSection extends StatefulWidget {
  const ContinueReadingSection({super.key});

  @override
  State<ContinueReadingSection> createState() => _ContinueReadingSectionState();
}

class _ContinueReadingSectionState extends State<ContinueReadingSection> {
  @override
  void initState() {
    super.initState();
    final jwt = AuthRepository.instance.jwt;
    locator<ReadingSessionRepositoryProvider>().fetchReadingSessions(jwt!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<ReadingSessionRepositoryProvider>(
        builder: (context, provider, child) {
          final state = provider.state;
          if (state is LoadingState) {
            return const Loading();
          } else if (state is SuccessState) {
            final sessions = state.data as List<ReadingSession>;
            if (sessions.isEmpty) {
              return const SizedBox();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gapH20,
                Text(
                  'Continue Reading',
                  style: titleStyle,
                ),
                gapH12,
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sessions.length,
                    itemBuilder: (context, index) {
                      return ContinueReadingBookContainer(
                        readingSession: sessions[index],
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is ErrorState) {
            return CustomErrorWidget(errorMessage: state.errorMessage);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
