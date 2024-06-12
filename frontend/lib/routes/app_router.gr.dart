// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:bookdf/features/auth/presentation/screens/auth_screen.dart'
    as _i3;
import 'package:bookdf/features/book/data/models/book.dart' as _i10;
import 'package:bookdf/features/book/presentation/screens/book_details_screen.dart'
    as _i4;
import 'package:bookdf/features/book/presentation/screens/book_pdf_view_screen.dart'
    as _i5;
import 'package:bookdf/features/home/presentation/screens/app_screen.dart'
    as _i2;
import 'package:bookdf/features/home/presentation/screens/home_page.dart'
    as _i6;
import 'package:bookdf/features/library/presentation/screens/add_book_screen.dart'
    as _i1;
import 'package:bookdf/features/profile/presentation/screen/user_profile_screen.dart'
    as _i7;
import 'package:flutter/material.dart' as _i9;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    AddBookRoute.name: (routeData) {
      final args = routeData.argsAs<AddBookRouteArgs>(
          orElse: () => const AddBookRouteArgs());
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddBookScreen(
          key: args.key,
          book: args.book,
        ),
      );
    },
    AppRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AppScreen(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AuthScreen(),
      );
    },
    BookDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<BookDetailsRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.BookDetailsScreen(
          key: args.key,
          book: args.book,
        ),
      );
    },
    BookPdfViewRoute.name: (routeData) {
      final args = routeData.argsAs<BookPdfViewRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
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
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomePage(),
      );
    },
    UserProfileRoute.name: (routeData) {
      final args = routeData.argsAs<UserProfileRouteArgs>(
          orElse: () => const UserProfileRouteArgs());
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.UserProfileScreen(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AddBookScreen]
class AddBookRoute extends _i8.PageRouteInfo<AddBookRouteArgs> {
  AddBookRoute({
    _i9.Key? key,
    _i10.Book? book,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          AddBookRoute.name,
          args: AddBookRouteArgs(
            key: key,
            book: book,
          ),
          initialChildren: children,
        );

  static const String name = 'AddBookRoute';

  static const _i8.PageInfo<AddBookRouteArgs> page =
      _i8.PageInfo<AddBookRouteArgs>(name);
}

class AddBookRouteArgs {
  const AddBookRouteArgs({
    this.key,
    this.book,
  });

  final _i9.Key? key;

  final _i10.Book? book;

  @override
  String toString() {
    return 'AddBookRouteArgs{key: $key, book: $book}';
  }
}

/// generated route for
/// [_i2.AppScreen]
class AppRoute extends _i8.PageRouteInfo<void> {
  const AppRoute({List<_i8.PageRouteInfo>? children})
      : super(
          AppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AuthScreen]
class AuthRoute extends _i8.PageRouteInfo<void> {
  const AuthRoute({List<_i8.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.BookDetailsScreen]
class BookDetailsRoute extends _i8.PageRouteInfo<BookDetailsRouteArgs> {
  BookDetailsRoute({
    _i9.Key? key,
    required _i10.Book book,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          BookDetailsRoute.name,
          args: BookDetailsRouteArgs(
            key: key,
            book: book,
          ),
          initialChildren: children,
        );

  static const String name = 'BookDetailsRoute';

  static const _i8.PageInfo<BookDetailsRouteArgs> page =
      _i8.PageInfo<BookDetailsRouteArgs>(name);
}

class BookDetailsRouteArgs {
  const BookDetailsRouteArgs({
    this.key,
    required this.book,
  });

  final _i9.Key? key;

  final _i10.Book book;

  @override
  String toString() {
    return 'BookDetailsRouteArgs{key: $key, book: $book}';
  }
}

/// generated route for
/// [_i5.BookPdfViewScreen]
class BookPdfViewRoute extends _i8.PageRouteInfo<BookPdfViewRouteArgs> {
  BookPdfViewRoute({
    _i9.Key? key,
    required String path,
    required String bookName,
    required String sessionId,
    required int currentPage,
    List<_i8.PageRouteInfo>? children,
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

  static const _i8.PageInfo<BookPdfViewRouteArgs> page =
      _i8.PageInfo<BookPdfViewRouteArgs>(name);
}

class BookPdfViewRouteArgs {
  const BookPdfViewRouteArgs({
    this.key,
    required this.path,
    required this.bookName,
    required this.sessionId,
    required this.currentPage,
  });

  final _i9.Key? key;

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
/// [_i6.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.UserProfileScreen]
class UserProfileRoute extends _i8.PageRouteInfo<UserProfileRouteArgs> {
  UserProfileRoute({
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          UserProfileRoute.name,
          args: UserProfileRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const _i8.PageInfo<UserProfileRouteArgs> page =
      _i8.PageInfo<UserProfileRouteArgs>(name);
}

class UserProfileRouteArgs {
  const UserProfileRouteArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'UserProfileRouteArgs{key: $key}';
  }
}
