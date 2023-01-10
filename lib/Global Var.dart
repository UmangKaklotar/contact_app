import 'dart:io';

import 'package:flutter/cupertino.dart';

class Global
{
  // Theme Mode
  static bool isDark = false;

  // Profile Image
  static File? image;

  // Add Phone Number Details
  static String firstName = "", lastName = "", email = "";
  static List<Map<String,dynamic>> contactList = [];
  static List<String> addPhone = [];
  static List<Map<String,dynamic>> call = [];

  // Controller
  static TextEditingController fName = TextEditingController();
  static TextEditingController lName = TextEditingController();
  static TextEditingController mail = TextEditingController();
  static List<TextEditingController> clearAddPhone = <TextEditingController>[];
}

