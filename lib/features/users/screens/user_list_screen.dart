

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_bloc_app/features/users/pagination_bloc/user_list_bloc.dart';

import '../pagination_bloc/pagination_event.dart';
import '../pagination_bloc/pagination_user_state.dart';





class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();
  late UserListBloc userBloc;

  @override
  void initState() {
    super.initState();

    userBloc = BlocProvider.of<UserListBloc>(context);
    userBloc.add(FetchUsers(1));

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final currentState = userBloc.state;
      if (currentState is UserListLoaded &&
          currentState.hasMore &&
          !currentState.isLoadingMore) {
        userBloc.add(FetchUsers(currentState.page + 1));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pagination with BLoC")),
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state is UserListInitial || state is UserListLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserListError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          if (state is UserListLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.avatar),
                          ),
                          title: Text("${user.firstName} ${user.lastName}"),
                          subtitle: Text(user.email),
                        ),
                      );
                    },
                  ),
                ),
                if (state.isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}


/*class _UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();
  late UserListBloc userBloc;

  @override
  void initState() {
    super.initState();

    userBloc = BlocProvider.of<UserListBloc>(context);
    userBloc.add(FetchUsers(1));

    _scrollController.addListener(_onScroll);
  }


  //     this.isLoadingMore = false,
  //     this.isFirstFetch = false,
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      final currentState = userBloc.state;
      if (currentState is UserListData && currentState.hasMore && !currentState.isLoadingMore) {
        userBloc.add(FetchUsers(currentState.page + 1));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pagination with BLoC")),
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state is UserListError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          if (state is UserListData) {
            if (state.isFirstFetch) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: ListTile(
                          leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
                          title: Text("${user.firstName} ${user.lastName}"),
                          subtitle: Text(user.email),
                        ),
                      );
                    },
                  ),
                ),
                if (state.isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}*/

