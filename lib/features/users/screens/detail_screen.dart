


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_detail_event.dart';
import '../bloc/user_detail_state.dart';
import '../bloc/user_details_bloc.dart';
import '../data/model/user_model.dart';
class UserDetailScreen extends StatefulWidget {
  final User user;
  const UserDetailScreen({required this.user, Key? key}) : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late TextEditingController nameController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name ?? "name");
    addressController =
        TextEditingController(text: widget.user.address?.street ?? "address");
  }



  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Details")),
      body: BlocProvider(
        create: (_) => UserDetailBloc()..add(FetchUserDetail(widget.user.id)),
        child: BlocConsumer<UserDetailBloc, UserDetailState>(
          listener: (context, state) {
            if (state is UserDetailUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("User Updated Successfully!")),
              );
              Navigator.pop(context, state.updatedUser); // return updated user
            }
            if (state is UserDetailLoaded) {
              // Keep controllers in sync with Bloc state
              nameController.value =
                  TextEditingValue(text: state.user.name ?? "");
              addressController.value =
                  TextEditingValue(text: state.user.address?.street ?? "");
            }
          },
          builder: (context, state) {
            if (state is UserDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UserDetailLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: "Name"),
                      onChanged: (value) {
                        context.read<UserDetailBloc>().add(NameChanged(value));
                      },
                    ),
                    TextField(
                      controller: addressController,
                      decoration: const InputDecoration(labelText: "Address"),
                      onChanged: (value) {
                        context.read<UserDetailBloc>().add(AddressChanged(value));
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: state.isChanged
                          ? () {
                        context.read<UserDetailBloc>().add(
                          UpdateUserDetail(
                            id: widget.user.id,
                            name: nameController.text,
                            address: addressController.text,
                            email: widget.user.email ?? '',
                          ),
                        );
                      }
                          : null, // disable when no changes
                      child: const Text("Update"),
                    ),
                  ],
                ),
              );
            }

            if (state is UserDetailError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}



