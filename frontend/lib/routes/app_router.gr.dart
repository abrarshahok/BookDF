// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:bookdf/features/auth/presentation/screens/auth_screen.dart'
    as _i3;
import 'package:bookdf/features/book/data/models/book.dart' as _i12;
import 'package:bookdf/features/book/presentation/screens/book_details_screen.dart'
    as _i4;
import 'package:bookdf/features/book/presentation/screens/book_pdf_view_screen.dart'
    as _i5;
import 'package:bookdf/features/book/presentation/screens/book_reviews_screen.dart'
    as _i6;
import 'package:bookdf/features/book/presentation/screens/search_books_screen.dart'
    as _i8;
import 'package:bookdf/features/home/presentation/screens/app_screen.dart'
    as _i2;
import 'package:bookdf/features/home/presentation/screens/home_page.dart'
    as _i7;
import 'package:bookdf/features/library/presentation/screens/add_book_screen.dart'
    as _i1;
import 'package:bookdf/features/profile/presentation/screen/user_profile_screen.dart'
    as _i9;
import 'package:flutter/material.dart' as _i11;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    AddBookRoute.name: (routeData) {
      final args = routeData.argsAs<AddBookRouteArgs>(
          orElse: () => const AddBookRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddBookScreen(
          key: args.key,
          book: args.book,
        ),
      );
    },
    AppRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AppScreen(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AuthScreen(),
      );
    },
    BookDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<BookDetailsRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.BookDetailsScreen(
          key: args.key,
          book: args.book,
        ),
      );
    },
    BookPdfViewRoute.name: (routeData) {
      final args = routeData.argsAs<BookPdfViewRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.BookPdfViewScreen(
          key: args.key,
          path: args.path,
          bookName: args.bookName,
          sessionId: args.sessionId,
          currentPage: args.currentPage,
        ),
      );
    },
    BookReviewsRoute.name: (routeData) {
      final args = routeData.argsAs<BookReviewsRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.BookReviewsScreen(
          key: args.key,
          bookId: args.bookId,
          bookTitle: args.bookTitle,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomePage(),
      );
    },
    SearchBooksRoute.name: (routeData) {
      final args = routeData.argsAs<SearchBooksRouteArgs>(
          orElse: () => const SearchBooksRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.SearchBooksScreen(key: args.key),
      );
    },
    UserProfileRoute.name: (routeData) {
      final args = routeData.argsAs<UserProfileRouteArgs>(
          orElse: () => const UserProfileRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.UserProfileScreen(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AddBookScreen]
class AddBookRoute extends _i10.PageRouteInfo<AddBookRouteArgs> {
  AddBookRoute({
    _i11.Key? key,
    _i12.Book? book,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          AddBookRoute.name,
          args: AddBookRouteArgs(
            key: key,
            book: book,
          ),
          initialChildren: children,
        );

  static const String name = 'AddBookRoute';

  static const _i10.PageInfo<AddBookRouteArgs> page =
      _i10.PageInfo<AddBookRouteArgs>(name);
}

class AddBookRouteArgs {
  const AddBookRouteArgs({
    this.key,
    this.book,
  });

  final _i11.Key? key;

  final _i12.Book? book;

  @override
  String toString() {
    return 'AddBookRouteArgs{key: $key, book: $book}';
  }
}

/// generated route for
/// [_i2.AppScreen]
class AppRoute extends _i10.PageRouteInfo<void> {
  const AppRoute({List<_i10.PageRouteInfo>? children})
      : super(
          AppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AuthScreen]
class AuthRoute extends _i10.PageRouteInfo<void> {
  const AuthRoute({List<_i10.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.BookDetailsScreen]
class BookDetailsRoute extends _i10.PageRouteInfo<BookDetailsRouteArgs> {
  BookDetailsRoute({
    _i11.Key? key,
    required _i12.Book book,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          BookDetailsRoute.name,
          args: BookDetailsRouteArgs(
            key: key,
            book: book,
          ),
          initialChildren: children,
        );

  static const String name = 'BookDetailsRoute';

  static const _i10.PageInfo<BookDetailsRouteArgs> page =
      _i10.PageInfo<BookDetailsRouteArgs>(name);
}

class BookDetailsRouteArgs {
  const BookDetailsRouteArgs({
    this.key,
    required this.book,
  });

  final _i11.Key? key;

  final _i12.Book book;

  @override
  String toString() {
    return 'BookDetailsRouteArgs{key: $key, book: $book}';
  }
}

/// generated route for
/// [_i5.BookPdfViewScreen]
class BookPdfViewRoute extends _i10.PageRouteInfo<BookPdfViewRouteArgs> {
  BookPdfViewRoute({
    _i11.Key? key,
    required String path,
    required String bookName,
    required String sessionId,
    required int currentPage,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          BookPdfViewRoute.name,
          args: BookPdfViewRouteArgs(
            key: key,
            path: path,
            bookName: bookName,
            sessionId: sessionId,
            currentPage: currentPage,
          ),
          initialChildren: children,
        );

  static const String name = 'BookPdfViewRoute';

  static const _i10.PageInfo<BookPdfViewRouteArgs> page =
      _i10.PageInfo<BookPdfViewRouteArgs>(name);
}

class BookPdfViewRouteArgs {
  const BookPdfViewRouteArgs({
    this.key,
    required this.path,
    required this.bookName,
    required this.sessionId,
    required this.currentPage,
  });

  final _i11.Key? key;

  final String path;

  final String bookName;

  final String sessionId;

  final int currentPage;

  @override
  String toString() {
    return 'BookPdfViewRouteArgs{key: $key, path: $path, bookName: $bookName, sessionId: $sessionId, currentPage: $currentPage}';
  }
}

/// generated route for
/// [_i6.BookReviewsScreen]
class BookReviewsRoute extends _i10.PageRouteInfo<BookReviewsRouteArgs> {
  BookReviewsRoute({
    _i11.Key? key,
    required String bookId,
    required String bookTitle,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          BookReviewsRoute.name,
          args: BookReviewsRouteArgs(
            key: key,
            bookId: bookId,
            bookTitle: bookTitle,
          ),
          initialChildren: children,
        );

  static const String name = 'BookReviewsRoute';

  static const _i10.PageInfo<BookReviewsRouteArgs> page =
      _i10.PageInfo<BookReviewsRouteArgs>(name);
}

class BookReviewsRouteArgs {
  const BookReviewsRouteArgs({
    this.key,
    required this.bookId,
    required this.bookTitle,
  });

  final _i11.Key? key;

  final String bookId;

  final String bookTitle;

  @override
  String toString() {
    return 'BookReviewsRouteArgs{key: $key, bookId: $bookId, bookTitle: $bookTitle}';
  }
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SearchBooksScreen]
class SearchBooksRoute extends _i10.PageRouteInfo<SearchBooksRouteArgs> {
  SearchBooksRoute({
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          SearchBooksRoute.name,
          args: SearchBooksRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SearchBooksRoute';

  static const _i10.PageInfo<SearchBooksRouteArgs> page =
      _i10.PageInfo<SearchBooksRouteArgs>(name);
}

class SearchBooksRouteArgs {
  const SearchBooksRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'SearchBooksRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.UserProfileScreen]
class UserProfileRoute extends _i10.PageRouteInfo<UserProfileRouteArgs> {
  UserProfileRoute({
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          UserProfileRoute.name,
          args: UserProfileRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const _i10.PageInfo<UserProfileRouteArgs> page =
      _i10.PageInfo<UserProfileRouteArgs>(name);
}

class UserProfileRouteArgs {
  const UserProfileRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'UserProfileRouteArgs{key: $key}';
  }
}
