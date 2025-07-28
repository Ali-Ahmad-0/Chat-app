import 'package:chat/Widget/customTextField.dart';
import 'package:chat/Widget/custom_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/cubits/login_cubit/login_cubit.dart';
import 'package:chat/helper/showSnackBar.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatelessWidget {
  static String id = 'login page';
  @override
  String? email, password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginFailure) {
          ShowSnackBar(context, state.errorMesage);
          isLoading = false;
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 60,
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    "Scholar chat",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'pacifico'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white, fontSize: 23, fontFamily: 'times'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    secured: false,
                    onChanged: (value) {
                      email = value;
                    },
                    textHint: 'Email',
                    icon: const Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    sufIcon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                    ),
                    secured: true,
                    onChanged: (value) {
                      password = value;
                    },
                    textHint: 'Password',
                    icon: const Icon(
                      Icons.lock_outline,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonContent: 'Login',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context)
                            .loginUser(email: email!, password: password!);
                      } else {}
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account ?\t",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Regist.id);
                        },
                        child: const Text(
                          "\t\t\tRegister",
                          style: TextStyle(
                              color: Color.fromARGB(255, 136, 229, 255)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
