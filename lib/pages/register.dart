import 'package:chat/Widget/customTextField.dart';
import 'package:chat/Widget/custom_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/helper/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Regist extends StatefulWidget {
  //const Regist();
  static String id = 'Regist';

  @override
  State<Regist> createState() => _RegistState();
}

class _RegistState extends State<Regist> {
  String? email, password, username;

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
                const SizedBox(
                  height: 60,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                const SizedBox(
                  height: 60,
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
                      "Register",
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
                    Icons.lock_outline_rounded,
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
                  buttonContent: 'Register',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        isLoading = true;
                        setState(() {});
                        await CreateUser();
                        ShowSnackBar(context,
                            'Your account has been created succesfully ✅');
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          ShowSnackBar(context, 'Weak passowrd');
                        } else if (e.code == 'email-already-in-use') {
                          ShowSnackBar(context,
                              'This account already exists for that email. ⛔');
                        }
                      } catch (e) {
                        ShowSnackBar(context,
                            'There is something went wrong , please try again later !');
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
                      "Already have an account ?\t",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "\t\t\t Sign in",
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

  Future<void> CreateUser() async {
    UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
