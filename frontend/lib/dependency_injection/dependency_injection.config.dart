// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bookdf/providers/auth_repository_provider.dart' as _i7;
import 'package:bookdf/providers/book_respository_provider.dart' as _i5;
import 'package:bookdf/providers/bottom_bar_index_provider.dart' as _i4;
import 'package:bookdf/providers/library_books_provider.dart' as _i3;
import 'package:bookdf/providers/reading_session_respository_provider.dart'
    as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt $initGetIt({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.LibraryBooksProvider>(
        () => _i3.LibraryBooksProvider());
    gh.lazySingleton<_i4.BottomBarIndexProvider>(
        () => _i4.BottomBarIndexProvider());
    gh.lazySingleton<_i5.BookRepositoryProvider>(
        () => _i5.BookRepositoryProvider());
    gh.lazySingleton<_i6.ReadingSessionRepositoryProvider>(
        () => _i6.ReadingSessionRepositoryProvider());
    gh.lazySingleton<_i7.AuthRepositoryProvider>(
        () => _i7.AuthRepositoryProvider());
    return this;
  }
}
