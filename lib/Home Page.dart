import 'dart:io';

import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'Contact Details.dart';

import 'Global Var.dart';

class ContactApp extends StatefulWidget {
  const ContactApp({Key? key}) : super(key: key);

  @override
  State<ContactApp> createState() => _ContactAppState();
}

class _ContactAppState extends State<ContactApp> {
  List alphabetic = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
  cameraImage() async{
    XFile? pic = await ImagePicker().pickImage(source: ImageSource.camera);
    if(pic != null)
    {
      setState(() {
        Global.image = File(pic.path);
      });
    }
  }
  galleryImage() async{
    XFile? pic = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pic != null)
    {
      setState(() {
        Global.image = File(pic.path);
      });
    }
  }
  final searchContact = ValueNotifier<String>('');
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            fontFamily: 'Iphone',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      themeMode: (Global.isDark == true) ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            fontFamily: 'Iphone',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          final iWillPop = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context){
              return AlertDialog(
                title: const Text("Are You Sure to Exit ?"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                actions: [
                  ElevatedButton(
                    child: const Text("Yes"),
                    onPressed: (){Navigator.pop(context,true);},
                  ),
                  TextButton(
                    child: const Text("No"),
                    onPressed: (){Navigator.pop(context,false);},
                  ),
                ],
              );
            }
          );
          return iWillPop;
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(height: 35),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Groups",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff0983FE),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Center(
                        child: Text("Contacts",
                          style: TextStyle(
                            fontFamily: 'Iphone',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  Global.isDark = (Global.isDark == true) ? false : true;
                                });
                              },
                              child: (Global.isDark == true) ? const Icon(Icons.brightness_6_rounded, size: 25) : const Icon(Icons.brightness_7_rounded, size: 25,),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  Global.image = null;
                                  Global.firstName = "";
                                  Global.lastName = "";
                                  Global.email = "";
                                  Global.fName.clear();
                                  Global.lName.clear();
                                  Global.mail.clear();
                                  Global.addPhone = [];
                                  Global.clearAddPhone.clear();
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: (Global.isDark == true) ? const Color(0xff1C1C1E) : const Color(0xffF2F2F6),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(builder: (context,setState) => DraggableScrollableSheet(
                                          initialChildSize: 0.9,
                                          expand: false,
                                          builder: (_, controller) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(15),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: GestureDetector(
                                                            onTap: (){
                                                              Navigator.pop(context);
                                                              Global.image = null;
                                                              Global.firstName = "";
                                                              Global.lastName = "";
                                                              Global.email = "";
                                                              Global.fName.clear();
                                                              Global.lName.clear();
                                                              Global.mail.clear();
                                                              Global.addPhone = [];
                                                              Global.clearAddPhone.clear();
                                                            },
                                                            child: const Text("Cancel",
                                                              style: TextStyle(
                                                                fontFamily: 'Iphone',
                                                                fontSize: 20,
                                                                color: Color(0xff0983FE),
                                                                fontWeight: FontWeight.w600,
                                                                letterSpacing: 0.5,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Center(
                                                          child: Text("New Contact",
                                                            style: TextStyle(
                                                              fontSize: 24,
                                                              fontFamily: 'Iphone',
                                                              color: (Global.isDark == true) ? Colors.white : Colors.black,
                                                              fontWeight: FontWeight.bold,
                                                              letterSpacing: 0.5,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Align(
                                                          alignment: Alignment.centerRight,
                                                          child: GestureDetector(
                                                            onTap: (){
                                                              setState(() {
                                                                if(Global.firstName != "" || Global.lastName != "")
                                                                {
                                                                  Navigator.pushNamedAndRemoveUntil(context, 'contact', (route) => false);
                                                                  Global.contactList.add({
                                                                    'fName': Global.firstName,
                                                                    'lName': Global.lastName,
                                                                    'email': Global.email,
                                                                    'phone': Global.addPhone.toList(),
                                                                    'profileImage': Global.image
                                                                  });
                                                                  print(Global.contactList);
                                                                  Global.image = null;
                                                                  Global.firstName = "";
                                                                  Global.lastName = "";
                                                                  Global.email = "";
                                                                  Global.fName.clear();
                                                                  Global.lName.clear();
                                                                  Global.mail.clear();
                                                                  Global.addPhone = [];
                                                                  Global.clearAddPhone.clear();
                                                                }
                                                              });
                                                            },
                                                            child: Text("Done",
                                                              style: TextStyle(
                                                                fontFamily: 'Iphone',
                                                                fontSize: 20,
                                                                color: (Global.isDark == true)
                                                                    ? (Global.firstName != "" || Global.lastName != "") ? const Color(0xff0A84FE) : const Color(0xff404041)
                                                                    : (Global.firstName != "" || Global.lastName != "") ? const Color(0xff0A84FE) : const Color(0xffBCBCBF),
                                                                fontWeight: FontWeight.bold,
                                                                letterSpacing: 0.5,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Expanded(
                                                  child: CustomScrollView(
                                                    physics: const BouncingScrollPhysics(),
                                                    slivers: [
                                                      SliverAppBar(
                                                        pinned: true,
                                                        elevation: 0,
                                                        leading: Container(),
                                                        expandedHeight: 210,
                                                        backgroundColor: (Global.isDark == true) ? const Color(0xff1C1C1E) : const Color(0xffF2F2F6),
                                                        flexibleSpace: CustomizableSpaceBar(
                                                          builder: (context, scrollingRate) => Column(
                                                            children: [
                                                              (Global.image == null)
                                                                  ? CircleAvatar(
                                                                radius: 85 - 50 * scrollingRate,
                                                                backgroundColor: const Color(0xffA0A6B2),
                                                                backgroundImage: const AssetImage('build/contact/profile.png'),
                                                              )
                                                                  : CircleAvatar(
                                                                radius: 85 - 50 * scrollingRate,
                                                                backgroundImage: FileImage(Global.image!),
                                                              ),
                                                              SizedBox(height: 10 - 10 * scrollingRate),
                                                              GestureDetector(
                                                                onTap: (){
                                                                  setState(() {
                                                                    showModalBottomSheet(
                                                                      isScrollControlled: true,
                                                                      backgroundColor: (Global.isDark == true) ? const Color(0xff1C1C1E) : const Color(0xffF2F2F6),
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(20),
                                                                      ),
                                                                      context: context,
                                                                      builder: (context){
                                                                        return DraggableScrollableSheet(
                                                                            maxChildSize: 1,
                                                                            minChildSize: 0.1,
                                                                            initialChildSize: 0.2,
                                                                            expand: false,
                                                                            builder: (_, controller) {
                                                                              return Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  GestureDetector(
                                                                                    onTap: (){
                                                                                      setState(() {
                                                                                        Navigator.pop(context);
                                                                                        Global.image = null;
                                                                                      });
                                                                                    },
                                                                                    child: const Text("Delete Photo",
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Iphone',
                                                                                        color: Colors.red,
                                                                                        fontSize: 22,
                                                                                        letterSpacing: 0.5,
                                                                                        fontWeight: FontWeight.w600,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    height: 1,
                                                                                    color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                                                                                  ),
                                                                                  GestureDetector(
                                                                                    onTap: (){
                                                                                      setState(() {
                                                                                        Navigator.pop(context);
                                                                                        cameraImage();
                                                                                      });
                                                                                    },
                                                                                    child: const Text("Take Photo",
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Iphone',
                                                                                        color: Color(0xff0983FE),
                                                                                        fontSize: 22,
                                                                                        letterSpacing: 0.5,
                                                                                        fontWeight: FontWeight.w600,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    height: 1,
                                                                                    color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                                                                                  ),
                                                                                  GestureDetector(
                                                                                    onTap: (){
                                                                                      setState(() {
                                                                                        Navigator.pop(context);
                                                                                        galleryImage();
                                                                                      });
                                                                                    },
                                                                                    child: const Text("Choose Photo",
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Iphone',
                                                                                        color: Color(0xff0983FE),
                                                                                        fontSize: 22,
                                                                                        letterSpacing: 0.5,
                                                                                        fontWeight: FontWeight.w600,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            }
                                                                        );
                                                                      },
                                                                    );
                                                                  });
                                                                },
                                                                child: Text("Add Photo",
                                                                  style: TextStyle(
                                                                    color: const Color(0xff0983FE),
                                                                    fontFamily: 'Iphone',
                                                                    fontSize: 16 - 25 * scrollingRate,
                                                                    fontWeight: FontWeight.w600,
                                                                    letterSpacing: 0.5,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SliverAnimatedList(
                                                        initialItemCount: 1,
                                                        itemBuilder: (context, i, _) => Column(
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Container(
                                                              color: (Global.isDark) ? const Color(0xff2C2C2E) : const Color(0xffFEFFFE),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    height: 1,
                                                                    color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                                                                  ),
                                                                  TextFormField(
                                                                    keyboardType: TextInputType.name,
                                                                    controller: Global.fName,
                                                                    style: TextStyle(
                                                                      color: (Global.isDark == true) ? Colors.white : Colors.black,
                                                                      fontSize: 18,
                                                                      fontFamily: "Iphone",
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                    decoration: InputDecoration(
                                                                      border: InputBorder.none,
                                                                      hintText: "First name",
                                                                      hintStyle: TextStyle(
                                                                        fontFamily: 'Iphone',
                                                                        fontSize: 18,
                                                                        color: (Global.isDark == true) ? const Color(0xffA5A5AC): const Color(0xff838387),
                                                                        fontWeight: FontWeight.w700,
                                                                        letterSpacing: 1,
                                                                      ),
                                                                      suffix: GestureDetector(
                                                                        onTap: (){
                                                                          setState(() {
                                                                            Global.fName.clear();
                                                                            Global.firstName = "";
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                          margin: const EdgeInsets.symmetric(horizontal: 15),
                                                                          height: 20,
                                                                          width: 20,
                                                                          decoration: BoxDecoration(
                                                                            color: (Global.isDark == true) ? const Color(0xff8E8E93) : const Color(0xff8E8E93),
                                                                            shape: BoxShape.circle,
                                                                          ),
                                                                          child: Icon(
                                                                            Icons.close_rounded,
                                                                            size: 15,
                                                                            color: (Global.isDark == true) ? const Color(0xff2C2C2E) : const Color(0xffFEFFFE),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      contentPadding: const EdgeInsets.only(left: 15),
                                                                    ),
                                                                    onChanged: (value){
                                                                      setState(() {
                                                                        Global.firstName = value;
                                                                        print(Global.firstName);
                                                                      });
                                                                    },
                                                                  ),
                                                                  Container(
                                                                    margin: const EdgeInsets.only(left: 15),
                                                                    height: 1,
                                                                    color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                                                                  ),
                                                                  TextFormField(
                                                                    keyboardType: TextInputType.name,
                                                                    controller: Global.lName,
                                                                    style: TextStyle(
                                                                      color: (Global.isDark == true) ? Colors.white : Colors.black,
                                                                      fontSize: 18,
                                                                      fontFamily: "Iphone",
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                    decoration: InputDecoration(
                                                                      border: InputBorder.none,
                                                                      hintText: "Last name",
                                                                      hintStyle: TextStyle(
                                                                        fontFamily: 'Iphone',
                                                                        fontSize: 18,
                                                                        color: (Global.isDark == true) ? const Color(0xffA5A5AC): const Color(0xff838387),
                                                                        fontWeight: FontWeight.w700,
                                                                        letterSpacing: 1,
                                                                      ),
                                                                      suffix: GestureDetector(
                                                                        onTap: (){
                                                                          setState(() {
                                                                            Global.lName.clear();
                                                                            Global.lastName = "";
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                          margin: const EdgeInsets.symmetric(horizontal: 15),
                                                                          height: 20,
                                                                          width: 20,
                                                                          decoration: BoxDecoration(
                                                                            color: (Global.isDark == true) ? const Color(0xff8E8E93) : const Color(0xff8E8E93),
                                                                            shape: BoxShape.circle,
                                                                          ),
                                                                          child: Icon(
                                                                            Icons.close_rounded,
                                                                            size: 15,
                                                                            color: (Global.isDark == true) ? const Color(0xff2C2C2E) : const Color(0xffFEFFFE),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      contentPadding: const EdgeInsets.only(left: 15),
                                                                    ),
                                                                    onChanged: (value){
                                                                      setState(() {
                                                                        Global.lastName = value;
                                                                        print(Global.lastName);
                                                                      });
                                                                    },
                                                                  ),
                                                                  Container(
                                                                    margin: const EdgeInsets.only(left: 15),
                                                                    height: 1,
                                                                    color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                                                                  ),
                                                                  TextFormField(
                                                                    controller: Global.mail,
                                                                    keyboardType: TextInputType.emailAddress,
                                                                    style: TextStyle(
                                                                      color: (Global.isDark == true) ? Colors.white : Colors.black,
                                                                      fontSize: 18,
                                                                      fontFamily: "Iphone",
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                    decoration: InputDecoration(
                                                                      border: InputBorder.none,
                                                                      hintText: "Email",
                                                                      hintStyle: TextStyle(
                                                                        fontFamily: 'Iphone',
                                                                        fontSize: 18,
                                                                        color: (Global.isDark == true) ? const Color(0xffA5A5AC): const Color(0xff838387),
                                                                        fontWeight: FontWeight.w700,
                                                                        letterSpacing: 1,
                                                                      ),
                                                                      suffix: GestureDetector(
                                                                        onTap: (){
                                                                          setState(() {
                                                                            Global.mail.clear();
                                                                            Global.email = "";
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                          margin: const EdgeInsets.only(left: 15),
                                                                          height: 20,
                                                                          width: 20,
                                                                          decoration: BoxDecoration(
                                                                            color: (Global.isDark == true) ? const Color(0xff8E8E93) : const Color(0xff8E8E93),
                                                                            shape: BoxShape.circle,
                                                                          ),
                                                                          child: Icon(
                                                                            Icons.close_rounded,
                                                                            size: 15,
                                                                            color: (Global.isDark == true) ? const Color(0xff2C2C2E) : const Color(0xffFEFFFE),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                                                                    ),
                                                                    onChanged: (value){
                                                                      setState(() {
                                                                        Global.email = value;
                                                                        print(Global.email);
                                                                      });
                                                                    },
                                                                  ),
                                                                  Container(
                                                                    height: 1,
                                                                    color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(height: 40),
                                                            Container(
                                                              color: (Global.isDark) ? const Color(0xff2C2C2E) : const Color(0xffFEFFFE),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    height: 1,
                                                                    color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                                                                  ),
                                                                  for(int i = 0 ; i < Global.addPhone.length ; i++) Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap: (){
                                                                              setState(() {
                                                                                Global.addPhone.remove(Global.addPhone[i]);
                                                                                Global.clearAddPhone.removeAt(i);
                                                                                print(Global.addPhone);
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                              margin: const EdgeInsets.symmetric(horizontal: 15),
                                                                              height: 26,
                                                                              width: 26,
                                                                              decoration: const BoxDecoration(
                                                                                color: Colors.red,
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: const Icon(Icons.remove, size: 22, color: Colors.white,),
                                                                            ),
                                                                          ),
                                                                          const Text("Mobile",
                                                                            style: TextStyle(
                                                                              color: Colors.blue,
                                                                              fontSize: 18,
                                                                              fontFamily: 'Iphone',
                                                                              letterSpacing: 0.5,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                          Icon(Icons.keyboard_arrow_right_rounded,
                                                                            size: 28,
                                                                            color: (Global.isDark) ? const Color(0xff656569) : const Color(0xffC4C4C6),
                                                                          ),
                                                                          Expanded(
                                                                            child: TextFormField(
                                                                              controller: Global.clearAddPhone[i],
                                                                              keyboardType: TextInputType.number,
                                                                              style: const TextStyle(
                                                                                color: Colors.blue,
                                                                                fontSize: 18,
                                                                                fontFamily: "Iphone",
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                suffix: GestureDetector(
                                                                                  onTap: (){
                                                                                    setState(() {
                                                                                      Global.clearAddPhone[i].clear();
                                                                                      Global.addPhone[i] = "";
                                                                                      print(Global.addPhone);
                                                                                    });
                                                                                  },
                                                                                  child: Container(
                                                                                    margin: const EdgeInsets.symmetric(horizontal: 15),
                                                                                    height: 20,
                                                                                    width: 20,
                                                                                    decoration: BoxDecoration(
                                                                                      color: (Global.isDark == true) ? const Color(0xff8E8E93) : const Color(0xff8E8E93),
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                    child: Icon(
                                                                                      Icons.close_rounded,
                                                                                      size: 15,
                                                                                      color: (Global.isDark == true) ? const Color(0xff2C2C2E) : const Color(0xffFEFFFE),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                hintText: "Phone",
                                                                                hintStyle: TextStyle(
                                                                                  fontFamily: 'Iphone',
                                                                                  fontSize: 18,
                                                                                  color: (Global.isDark == true) ? const Color(0xffA5A5AC): const Color(0xff838387),
                                                                                  fontWeight: FontWeight.w600,
                                                                                  letterSpacing: 1,
                                                                                ),
                                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                              ),
                                                                              onChanged: (value){
                                                                                setState(() {
                                                                                  Global.addPhone[i] = value;
                                                                                  print(Global.addPhone);
                                                                                });
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Container(
                                                                        margin: const EdgeInsets.only(left: 15),
                                                                        height: 1,
                                                                        color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.symmetric(vertical: 11),
                                                                    child: Row(
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap: (){
                                                                            setState(() {
                                                                              Global.addPhone.add("");
                                                                              Global.clearAddPhone.add(TextEditingController());
                                                                              print(Global.addPhone);
                                                                            });
                                                                          },
                                                                          child: Container(
                                                                            margin: const EdgeInsets.symmetric(horizontal: 15),
                                                                            height: 26,
                                                                            width: 26,
                                                                            decoration: const BoxDecoration(
                                                                              color: Color(0xff30D158),
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            child: const Icon(Icons.add, size: 22, color: Colors.white,),
                                                                          ),
                                                                        ),
                                                                        Text("Add Phone",
                                                                          style: TextStyle(
                                                                            color: (Global.isDark == true) ? Colors.white : Colors.black,
                                                                            fontSize: 18,
                                                                            fontFamily: 'Iphone',
                                                                            letterSpacing: 0.5,
                                                                            fontWeight: FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: 1,
                                                                    color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        );
                                      }
                                  );
                                });
                              },
                              child: const Icon(Icons.add,
                                size: 32,
                                color: Color(0xff0983FE),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  height: 45,
                  width: _width,
                  decoration: BoxDecoration(
                    color: (Global.isDark == true) ? const Color(0xff1C1C1E) : const Color(0xffEEEEEF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(Icons.search_rounded,
                          color: (Global.isDark == true) ? const Color(0xffA5A5AC): const Color(0xff818185),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(
                            color: (Global.isDark == true) ? Colors.white : Colors.black,
                            fontSize: 18,
                            fontFamily: "Iphone",
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            hintStyle: TextStyle(
                              fontFamily: 'Iphone',
                              fontSize: 20,
                              color: (Global.isDark == true) ? const Color(0xffA5A5AC): const Color(0xff818185),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 11.5),
                          ),
                          onChanged: (val){
                            setState(() {
                              searchContact.value = val;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 1,
                  color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 40,
                              backgroundColor: Color(0xffA0A6B2),
                              backgroundImage: AssetImage('build/contact/U.png'),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Umang Kaklotar",
                                  style: TextStyle(
                                    fontSize: 25,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text("My Card",
                                  style: TextStyle(
                                    color: Color(0xff87878D),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Container(
                          height: 1,
                          color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                        ),
                        (searchContact.value.isEmpty)
                          ? (Global.contactList.isNotEmpty)
                            ? Column(
                          children: [
                            for(int i = 0 ; i < alphabetic.length ; i++)
                              ...Global.contactList.map((e){
                                if(alphabetic[i] == e['fName'][0].toString().toUpperCase())
                                {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          print(Global.contactList);
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactDetails(index: Global.contactList.indexOf(e)),),);
                                        },
                                        child: Slidable(
                                          key: ValueKey(e),
                                          endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            extentRatio: 0.2,
                                            dragDismissible: true,
                                            dismissible: DismissiblePane(onDismissed: () {
                                              setState(() {
                                                Global.contactList.remove(e);
                                              });
                                            }),
                                            children: [
                                              SlidableAction(
                                                onPressed: (val){
                                                  setState(() {
                                                    Global.contactList.remove(e);
                                                  });
                                                },
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                                label: 'Delete',
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                            width: _width,
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Text("${e['fName']} ${e['lName']}",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 1,
                                        color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                                      ),
                                    ],
                                  );
                                }
                                return Container();
                              }).toList(),
                          ],
                        )
                            : Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: _height / 4),
                          child: Text("No Contact",
                            style: TextStyle(
                              color: (Global.isDark == true) ? const Color(0xffA5A5AC): const Color(0xff838387),
                              fontSize: 25,
                            ),
                          ),
                        )
                          : Column(
                          children: [
                            for(int i = 0 ; i < alphabetic.length ; i++)
                              ...Global.contactList.map((e){
                                if(alphabetic[i] == e['fName'][0].toString().toUpperCase())
                                {
                                  if(e['fName'].toString().toUpperCase().contains(searchContact.value.toUpperCase())) {
                                    return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          print(Global.contactList);
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactDetails(index: Global.contactList.indexOf(e)),),);
                                        },
                                        child: Slidable(
                                          key: ValueKey(e),
                                          endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            extentRatio: 0.2,
                                            dragDismissible: true,
                                            dismissible: DismissiblePane(onDismissed: () {
                                              setState(() {
                                                Global.contactList.remove(e);
                                              });
                                            }),
                                            children: [
                                              SlidableAction(
                                                onPressed: (val){
                                                  setState(() {
                                                    Global.contactList.remove(e);
                                                  });
                                                },
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                                label: 'Delete',
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                            width: _width,
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Text("${e['fName']} ${e['lName']}",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 1,
                                        color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                                      ),
                                    ],
                                  );
                                  }
                                }
                                return Container();
                              }).toList(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Text("${Global.contactList.length} Contacts",
                  style: TextStyle(
                    color: (Global.isDark == true) ? const Color(0xffA5A5AC): const Color(0xff838387),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(CupertinoIcons.circle_grid_3x3_fill,
              color: Colors.white,
            ),
            backgroundColor: const Color(0xff0983FE),
            onPressed: (){
              Navigator.of(context).pushNamed('call');
            },
          ),
          backgroundColor: (Global.isDark == true) ? Colors.black : const Color(0xffFEFFFE),
        ),
      ),
    );
  }
}
