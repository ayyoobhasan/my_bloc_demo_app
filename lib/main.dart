import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_app/util/constants.dart';

import 'features/users/bloc/user_bloc.dart';
import 'features/users/data/repositories/user_repo.dart';
import 'navigation_router.dart';


void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc(UserRepository())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      initialRoute: splashScreenRoute,
      onGenerateRoute: NavigationRouter.generateRoute,
    );
  }
}
