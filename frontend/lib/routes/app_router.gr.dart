// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:bookdf/features/auth/presentation/screens/auth_screen.dart'
    as _i2;
import 'package:bookdf/features/book/data/models/book.dart' as _i8;
import 'package:bookdf/features/book/presentation/screens/book_detail_screen.dart'
    as _i3;
import 'package:bookdf/features/book/presentation/screens/book_pdf_view_screen.dart'
    as _i4;
import 'package:bookdf/features/home/presentation/screens/app_screen.dart'
    as _i1;
import 'package:bookdf/features/home/presentation/screens/home_page.dart'
    as _i5;
import 'package:flutter/material.dart' as _i7;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    AppRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AppScreen(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AuthScreen(),
      );
    },
    BookDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<BookDetailsRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.BookDetailsScreen(
          key: args.key,
          book: args.book,
        ),
      );
    },
    BookPdfViewRoute.name: (routeData) {
      final args = routeData.argsAs<BookPdfViewRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.BookPdfViewScreen(
          key: args.key,
          path: args.path,
          bookName: args.bookName,
          currentPage: args.currentPage,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AppScreen]
class AppRoute extends _i6.PageRouteInfo<void> {
  const AppRoute({List<_i6.PageRouteInfo>? children})
      : super(
          AppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AuthScreen]
class AuthRoute extends _i6.PageRouteInfo<void> {
  const AuthRoute({List<_i6.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BookDetailsScreen]
class BookDetailsRoute extends _i6.PageRouteInfo<BookDetailsRouteArgs> {
  BookDetailsRoute({
    _i7.Key? key,
    required _i8.Book book,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          BookDetailsRoute.name,
          args: BookDetailsRouteArgs(
            key: key,
            book: book,
          ),
          initialChildren: children,
        );

  static const String name = 'BookDetailsRoute';

  static const _i6.PageInfo<BookDetailsRouteArgs> page =
      _i6.PageInfo<BookDetailsRouteArgs>(name);
}

class BookDetailsRouteArgs {
  const BookDetailsRouteArgs({
    this.key,
    required this.book,
  });

  final _i7.Key? key;

  final _i8.Book book;

  @override
  String toString() {
    return 'BookDetailsRouteArgs{key: $key, book: $book}';
  }
}

/// generated route for
/// [_i4.BookPdfViewScreen]
class BookPdfViewRoute extends _i6.PageRouteInfo<BookPdfViewRouteArgs> {
  BookPdfViewRoute({
    _i7.Key? key,
    required String path,
    required String bookName,
    int currentPage = 1,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          BookPdfViewRoute.name,
          args: BookPdfViewRouteArgs(
            key: key,
            path: path,
            bookName: bookName,
            currentPage: currentPage,
          ),
          initialChildren: children,
        );

  static const String name = 'BookPdfViewRoute';

  static const _i6.PageInfo<BookPdfViewRouteArgs> page =
      _i6.PageInfo<BookPdfViewRouteArgs>(name);
}

class BookPdfViewRouteArgs {
  const BookPdfViewRouteArgs({
    this.key,
    required this.path,
    required this.bookName,
    this.currentPage = 1,
  });

  final _i7.Key? key;

  final String path;

  final String bookName;

  final int currentPage;

  @override
  String toString() {
    return 'BookPdfViewRouteArgs{key: $key, path: $path, bookName: $bookName, currentPage: $currentPage}';
  }
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
