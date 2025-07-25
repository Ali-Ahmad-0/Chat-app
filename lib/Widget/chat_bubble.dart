import 'dart:ui';

import 'package:chat/Widget/message_model.dart';
import 'package:chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key,
      required this.email,
      required this.messageModel,
      required this.messageId, // Add this line
      required this.messageTime,
      required this.isSender});

  final MessageModel messageModel;
  final String messageId; // Add this line
  final String messageTime;
  final bool isSender;
  final String email;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Stack(
              children: [
                // Blurred background
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                      color: const Color.fromARGB(255, 39, 53, 29)
                          .withOpacity(0.3)),
                ),
                // Alert Dialog
                AlertDialog(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: const Text(
                    'Delete Message',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: const Text(
                    'Are you sure you want to delete this message?',
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Delete the message from Firestore
                        FirebaseFirestore.instance
                            .collection(Kmessage)
                            .doc(messageId)
                            .delete();
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('Delete',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          constraints: BoxConstraints(
            minWidth: 50,
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSender ? Color(0xFF4A6FA5) : Color(0xFF2E3A59),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                email,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                softWrap: true,
              ),
              Text(
                messageModel.message,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                softWrap: true,
              ),
              Text(
                messageTime,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
