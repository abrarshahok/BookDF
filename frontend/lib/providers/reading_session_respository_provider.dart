import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../states/load_state.dart';
import '/features/book/data/respository/reading_session_repository.dart';

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

  void _setState(LoadState newState, {bool build = true}) {
    _state = newState;
    if (build) {
      notifyListeners();
    }
  }
}
