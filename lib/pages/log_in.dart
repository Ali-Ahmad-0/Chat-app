import 'package:chat/Widget/customTextField.dart';
import 'package:chat/Widget/custom_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/helper/showSnackBar.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  static String id = 'login page';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email, password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                // ignore: prefer_const_constructors
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                const SizedBox(
                  height: 75,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Scholar app",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: 'Pacifico'),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 50,
                ),
                const Row(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                  ],
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
                      isLoading = true;
                      setState(() {});
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email!, password: password!);

                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ShowSnackBar(context,
                              'This user is not exist , Try to sign up ⛔');
                        } else if (e.code == 'wrong-password') {
                          ShowSnackBar(context, 'Wrong password ⛔');
                        }
                      } catch (e) {
                        ShowSnackBar(context,
                            'There is something went wrong , please try again later !');
                        print(e);
                      }
                      isLoading = false;
                      setState(() {});
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
    );
  }
}
