import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_app/features/users/bloc/login_bloc.dart';

import '../bloc/login_even.dart';
import '../bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userC = TextEditingController();
  TextEditingController pswC = TextEditingController();

  late LoginUserBloc userBloc;

  @override
  void initState() {
    userBloc = context.read<LoginUserBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LoginUserBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginUserLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Login success: ${state.loginData.username}")),
              );
            } else if (state is LoginUserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: ${state.message}")),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                // ✅ Your form always stays visible
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: userC,
                        decoration: InputDecoration(
                          hintText: "user id",
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: pswC,
                        decoration: InputDecoration(
                          hintText: "Password",
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                               // "username": "michaelw",
                               // "password": "michaelwpass",
                          userBloc.add(LoginButtonClicked(
                            userId: userC.text,
                            password: pswC.text,
                          ));
                        },
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                ),

                // ✅ Loader overlay only when state is Loading
                if (state is LoginUserLoading)
                  Container(
                    color: Colors.black.withValues(alpha: 0.3),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (state is LoginUserError)
                  Container(
                    color: Colors.black.withValues(alpha: 0.3),
                    child: const Center(
                      child: Text("Error"),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

