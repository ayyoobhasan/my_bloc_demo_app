


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_app/features/users/screens/login_screen.dart';
import 'package:my_bloc_app/features/users/screens/user_list_screen.dart';
import 'package:my_bloc_app/util/constants.dart';

import 'features/users/bloc/login_bloc.dart';
import 'features/users/bloc/user_details_bloc.dart';
import 'features/users/data/model/user_model.dart';
import 'features/users/data/repositories/user_repo.dart';
import 'features/users/pagination_bloc/user_list_bloc.dart';
import 'features/users/screens/detail_screen.dart';
import 'features/users/screens/splash_screen.dart';
import 'features/users/screens/user_screens.dart';


class NavigationRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreenRoute:

        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case loginScreenRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => LoginUserBloc(UserRepository()),
            child: LoginScreen(), // pass User here
          ),
        );

      case userListRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => UserListBloc(UserRepository()),
            child: UserListScreen(), // pass User here
          ),
        );

      case userScreenRoute:
        return MaterialPageRoute(builder: (_) => const UserScreen());

      case detailsScreenRoute:
        final args = settings.arguments as Map<String, dynamic>;
        final User user = args['user'] as User; // ✅ cast to User
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => UserDetailBloc(),
            child: UserDetailScreen(user: user), // pass User here
          ),
        );


      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Route not found")),
          ),
        );
    }
  }
}
