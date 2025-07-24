import 'package:chat/constants.dart';

class MessageModel {
  String message;
  String id;

  MessageModel({required this.message, required this.id});

  factory MessageModel.fromJson(Map<String, dynamic> jsondata) {
    return MessageModel(message: jsondata[Ktext], id: jsondata[KID].toString());
  }
}
