import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../providers/book_respository_provider.dart';
import '../providers/auth_repository_provider.dart';
import '/providers/library_books_provider.dart';
import '/dependency_injection/dependency_injection.dart';
import '/providers/bottom_bar_index_provider.dart';
import '/providers/reading_session_respository_provider.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
      create: (context) => locator<AuthRepositoryProvider>()),
  ChangeNotifierProvider(
      create: (context) => locator<BookRepositoryProvider>()),
  ChangeNotifierProvider(
      create: (context) => locator<ReadingSessionRepositoryProvider>()),
  ChangeNotifierProvider(create: (context) => locator<LibraryBooksProvider>()),
  ChangeNotifierProvider(
      create: (context) => locator<BottomBarIndexProvider>()),
];
