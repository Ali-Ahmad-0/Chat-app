  
import 'package:flutter/material.dart';

void ShowSnackBar(BuildContext context, String messaeg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(messaeg)));
  }