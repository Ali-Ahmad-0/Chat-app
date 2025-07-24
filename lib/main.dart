import 'package:chat/firebase_options.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/log_in.dart';
import 'package:chat/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Chat());
}

class Chat extends StatelessWidget {
  const Chat({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
      Login.id: (context) =>  Login(),
      Regist.id: (context) =>  Regist(),
      ChatPage.id: (context) => const  ChatPage(),
    },
     initialRoute: Login.id,
     debugShowCheckedModeBanner: false);
  }
}
