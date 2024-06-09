import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bookdf/features/auth/presentation/screens/auth_screen.dart';
import 'package:bookdf/features/book/presentation/widgets/books_category_section.dart';
import 'package:bookdf/states/load_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/dependency_injection/dependency_injection.dart';
import '/providers/auth_repository_provider.dart';
import 'home_page.dart';

@RoutePage()
class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  void initState() {
    super.initState();
    locator<AuthRepositoryProvider>().autologin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthRepositoryProvider>(
        builder: (context, auth, _) {
          final state = auth.state;
          log(state.toString());
          if (state is LoadingState) {
            return const Loading();
          } else if (state is SuccessState) {
            final bool isAuth = state.data as bool;

            if (isAuth) {
              return const HomePage();
            } else {
              return const AuthScreen();
            }
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
