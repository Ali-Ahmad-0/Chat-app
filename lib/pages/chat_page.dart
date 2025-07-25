import 'package:chat/Widget/chat_bubble.dart';
import 'package:chat/Widget/message_model.dart';
import 'package:chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  static String id = 'chat page';

  const ChatPage({super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(Kmessage);
  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(Kcreate, descending: false).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messageList = [];
          List<String> messageTimes = []; // List to store message times

          for (var doc in snapshot.data!.docs) {
            var data = doc.data() as Map<String, dynamic>;
            messageList.add(MessageModel.fromJson(data));

            // Convert Firestore Timestamp to a readable format
            // Safely check if createdAt is not null before converting
            // Timestamp? timestamp = data[Kcreate] as Timestamp?;
            DateTime dateTime = data[Kcreate].toDate() ?? DateTime.now();
            String formattedTime = "${dateTime.hour}:${dateTime.minute}";
            messageTimes.add(formattedTime);
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 50,
                  ),
                  const Text(
                    'Chat',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'pacifico'),
                  )
                ],
              ),
            ),
            body: Stack(
              children: [
                Image.asset(
                  'assets/images/doodle-seo-icons-backgrround-business-backdrop-hand-drow-sketchy-pattern-notepaper-wallpaper-background-vector-45587472.webp',
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        reverse: false,
                        controller: _scrollController,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return messageList[index].id == email
                              ? ChatBubble(
                                  isSender: false,
                                  email: email.toString(),
                                  messageModel: messageList[index],
                                  messageId: snapshot.data!.docs[index]
                                      .id, // Pass the message ID
                                  messageTime: messageTimes[index],
                                )
                              : ChatBubble(
                                  email: email.toString(),
                                  isSender: true,
                                  messageModel: messageList[index],
                                  messageId: snapshot.data!.docs[index]
                                      .id, // Pass the message ID
                                  messageTime: messageTimes[index],
                                );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: TextField(
                        controller: controller,
                        onSubmitted: (data) {
                          messages.add({
                            'text': data,
                            'createdAt': FieldValue
                                .serverTimestamp(), // Use server timestamp
                            'id': email
                          });

                          // _scrollController.animateTo(0,
                          //     duration: const Duration(seconds: 1),
                          //     curve: Curves.ease);

                          controller.clear();
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (controller.text.isNotEmpty) {
                                messages.add({
                                  'text': controller.text,
                                  'createdAt': FieldValue
                                      .serverTimestamp(), // Use server timestamp
                                });
                                _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.ease);

                                controller.clear();
                              } else {}
                            },
                            child: Icon(
                              Icons.send_rounded,
                              color: kPrimaryColor,
                            ),
                          ),
                          hintText: 'Write a message ...',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
                  const SizedBox(height: 75),
                  const Text(
                    'Loading...',
                    style: TextStyle(fontSize: 40, fontFamily: 'pacifico'),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
