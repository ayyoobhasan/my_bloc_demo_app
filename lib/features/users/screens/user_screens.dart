

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util/constants.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';
import '../data/model/user_model.dart';


class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>()..add(FetchUsers());

    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text(user.name ?? ""),
                  subtitle: Text(user.email ?? ""),
                  onTap: () async {
                    final updatedUser = await Navigator.pushNamed(
                      context,
                      detailsScreenRoute,
                      arguments: {'user': user},
                    );
                    if (updatedUser != null && updatedUser is User) {
                      context.read<UserBloc>().add(UpdateUserInList(updatedUser));
                    }
                  },
                );
              },
            );
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("Press button to load users"));
        },
      ),
    );
  }
}
