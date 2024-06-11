import 'package:bookdf/dependency_injection/dependency_injection.dart';
import 'package:bookdf/providers/auth_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../features/book/data/respository/reading_session_repository.dart';
import '../states/load_state.dart';

@lazySingleton
class ReadingSessionRepositoryProvider with ChangeNotifier {
  LoadState _state = InitialState();
  LoadState get state => _state;

  void fetchReadingSessions(String jwt) async {
    _setState(LoadingState(), build: false);

    final result =
        await ReadingSessionsRepository.instance.fetchReadingSessions(jwt);

    result.fold(
      (error) => _setState(ErrorState(error)),
      (sessions) => _setState(SuccessState(sessions)),
    );
  }

  Future<void> createSession(String jwt, String bookId, int totalPages) async {
    _setState(LoadingState(), build: false);

    final result = await ReadingSessionsRepository.instance.createSession(
      jwt,
      bookId,
      totalPages,
    );

    result.fold(
      (error) => _setState(ErrorState(error)),
      (sessions) {
        locator<AuthRepositoryProvider>().addReadingSession(bookId);
        _setState(SuccessState(sessions));
      },
    );
  }

  Future<void> updateSession(
    String jwt,
    String sessionId,
    int currentPage,
  ) async {
    _setState(LoadingState(), build: false);

    final result = await ReadingSessionsRepository.instance.updateSession(
      jwt,
      sessionId,
      currentPage,
    );

    result.fold(
      (error) => _setState(ErrorState(error)),
      (updatedSessions) {
        _setState(SuccessState(updatedSessions));
      },
    );
  }

  void _setState(LoadState newState, {bool build = true}) {
    _state = newState;
    if (build) {
      notifyListeners();
    }
  }
}
