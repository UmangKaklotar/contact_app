import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'Edit Contact.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Global Var.dart';

class ContactDetails extends StatefulWidget {
  int index;
  ContactDetails({Key? key, required this.index}) : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_back_ios_rounded,
                            color: Color(0xff0983FE),
                          ),
                          SizedBox(width: 5),
                          Text("Contacts",
                            style: TextStyle(
                              fontFamily: 'Iphone',
                              fontSize: 20,
                              color: Color(0xff0983FE),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => EditContact(edit: widget.index,),),);
                        print(widget.index);
                      },
                      child: const Text("Edit",
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
              ],
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
                    expandedHeight: 130,
                    backgroundColor: (Global.isDark == true) ? const Color(0xff000000) : const Color(0xffF2F2F6),
                    flexibleSpace: CustomizableSpaceBar(
                      builder: (context, scrollingRate) => Column(
                        children: [
                          (Global.contactList[widget.index]['profileImage'] == null)
                              ? CircleAvatar(
                            radius: 55 - 25 * scrollingRate,
                            backgroundColor: const Color(0xff9095A0),
                            // backgroundImage: const AssetImage('build/contact/profile.png'),
                            child: Text(Global.contactList[widget.index]['fName'][0],
                              style: GoogleFonts.fredoka(
                                fontSize: 60 - 30 * scrollingRate,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          )
                              : CircleAvatar(
                            radius: 55 - 25 * scrollingRate,
                            backgroundColor: const Color(0xffA0A6B2),
                            backgroundImage: FileImage(Global.contactList[widget.index]['profileImage']),
                          ),
                          SizedBox(height: 15 - 8 * scrollingRate),
                          SelectableText("${Global.contactList[widget.index]['fName']} ${Global.contactList[widget.index]['lName']}",
                            style: TextStyle(
                              fontSize: 30 - 15 * scrollingRate,
                              fontFamily: 'Iphone',
                              fontWeight: FontWeight.w600,
                              color: (Global.isDark == true) ? Colors.white : Colors.black,
                            ),
                            toolbarOptions: const ToolbarOptions(
                                copy: true,
                                cut: true,
                                paste: true,
                                selectAll: true
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
                        Row(
                          children: [
                            Expanded(
                              child: PopupMenuButton(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: (Global.isDark == true) ? const Color(0xff2A2B2D) : Colors.white,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  height: 65,
                                  decoration: BoxDecoration(
                                    color: (Global.isDark) ? const Color(0xff1C1C1E) : const Color(0xffFEFFFE),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(CupertinoIcons.chat_bubble_fill,
                                        size: 28,
                                        color: Color(0xff0983FE),
                                      ),
                                      Text("Message",
                                        style: TextStyle(
                                          fontFamily: 'Iphone',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff0983FE),
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                itemBuilder: (context) => Global.contactList[widget.index]['phone'].map<PopupMenuItem>((e){
                                  return PopupMenuItem(
                                    child: GestureDetector(
                                      onTap: () async {
                                        final Uri sms = Uri(
                                          scheme: 'sms',
                                          path: '+91$e',
                                        );
                                        await launchUrl(sms);
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 250,
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("+91 $e",
                                              style: TextStyle(
                                                fontFamily: 'Iphone',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.5,
                                                color: (Global.isDark == true) ? Colors.white : Colors.black,
                                              ),
                                            ),
                                            Icon(CupertinoIcons.chat_bubble,
                                              color: (Global.isDark == true) ? Colors.white : Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: PopupMenuButton(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: (Global.isDark == true) ? const Color(0xff2A2B2D) : Colors.white,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  height: 65,
                                  decoration: BoxDecoration(
                                    color: (Global.isDark) ? const Color(0xff1C1C1E) : const Color(0xffFEFFFE),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(CupertinoIcons.phone_fill,
                                        size: 30,
                                        color: Color(0xff0983FE),
                                      ),
                                      Text("Call",
                                        style: TextStyle(
                                          fontFamily: 'Iphone',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff0983FE),
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                itemBuilder: (context) => Global.contactList[widget.index]['phone'].map<PopupMenuItem>((e){
                                  return PopupMenuItem(
                                    child: GestureDetector(
                                      onTap: () async {
                                        await FlutterPhoneDirectCaller
                                            .callNumber('+91$e');
                                        setState(() {
                                          final DateTime _time = DateTime.now();
                                          Global.call.add({
                                            'name': '${Global.contactList[widget.index]['fName']} ${Global.contactList[widget.index]['lName']}',
                                            'number': '+91 $e',
                                            'time': '${_time.hour}:${_time.minute} ${(_time.hour >= 12) ? 'PM' : 'AM'}',
                                            'index': widget.index
                                          });
                                          print(Global.call);
                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 250,
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("+91 $e",
                                              style: TextStyle(
                                                fontFamily: 'Iphone',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.5,
                                                color: (Global.isDark == true) ? Colors.white : Colors.black,
                                              ),
                                            ),
                                            Icon(CupertinoIcons.phone,
                                              color: (Global.isDark == true) ? Colors.white : Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {

                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  height: 65,
                                  decoration: BoxDecoration(
                                    color: (Global.isDark) ? const Color(0xff1C1C1E) : const Color(0xffFEFFFE),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(Icons.video_camera_front_rounded,
                                        size: 30,
                                        color: Color(0xff0983FE),
                                      ),
                                      Text("Video",
                                        style: TextStyle(
                                          fontFamily: 'Iphone',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff0983FE),
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  final Uri mail = Uri(
                                    scheme: 'mailto',
                                    path: Global.contactList[widget.index]['email'],
                                  );
                                  await launchUrl(mail);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  height: 65,
                                  decoration: BoxDecoration(
                                    color: (Global.isDark) ? const Color(0xff1C1C1E) : const Color(0xffFEFFFE),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(CupertinoIcons.mail_solid,
                                        size: 30,
                                        color: Color(0xff0983FE),
                                      ),
                                      Text("Mail",
                                        style: TextStyle(
                                          fontFamily: 'Iphone',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff0983FE),
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          // height: _height / 13,
                          width: _width,
                          decoration: BoxDecoration(
                            color: (Global.isDark) ? const Color(0xff1C1C1E) : const Color(0xffFEFFFE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Mobile",
                                style: TextStyle(
                                  fontFamily: 'Iphone',
                                  color: (Global.isDark == true) ? Colors.white : Colors.black,
                                  fontSize: 18,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              ...Global.contactList[widget.index]['phone'].map((e) {
                                return GestureDetector(
                                  onTap: () async {
                                    await FlutterPhoneDirectCaller.callNumber('+91$e');
                                    setState(() {
                                      final DateTime _time = DateTime.now();
                                      Global.call.add({
                                        'name': '${Global.contactList[widget.index]['fName']} ${Global.contactList[widget.index]['lName']}',
                                        'number': '+91 $e',
                                        'time': '${_time.hour}:${_time.minute} ${(_time.hour >= 12) ? 'PM' : 'AM'}',
                                        'index': widget.index
                                      });
                                      print(Global.call);
                                    });
                                  },
                                  child: Text("\n$e",
                                    style: const TextStyle(
                                      fontFamily: 'Iphone',
                                      color: Color(0xff0983FE),
                                      fontSize: 18,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          // height: _height / 13,
                          width: _width,
                          decoration: BoxDecoration(
                            color: (Global.isDark) ? const Color(0xff1C1C1E) : const Color(0xffFEFFFE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email",
                                style: TextStyle(
                                  fontFamily: 'Iphone',
                                  color: (Global.isDark == true) ? Colors.white : Colors.black,
                                  fontSize: 18,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 15),
                              SelectableText(Global.contactList[widget.index]['email'],
                                style: const TextStyle(
                                  fontFamily: 'Iphone',
                                  color: Color(0xff0983FE),
                                  fontSize: 18,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w600,
                                ),
                                toolbarOptions: const ToolbarOptions(
                                  selectAll: true,
                                  copy: true,
                                  paste: true,
                                  cut: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          // height: _height / 13,
                          width: _width,
                          decoration: BoxDecoration(
                            color: (Global.isDark) ? const Color(0xff1C1C1E) : const Color(0xffFEFFFE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Notes",
                                style: TextStyle(
                                  fontFamily: 'Iphone',
                                  color: (Global.isDark == true) ? Colors.white : Colors.black,
                                  fontSize: 18,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextFormField(
                                style: TextStyle(
                                  fontFamily: 'Iphone',
                                  color: (Global.isDark == true) ? Colors.white : Colors.black,
                                  fontSize: 18,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Notes",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Iphone',
                                    fontSize: 18,
                                    color: (Global.isDark == true) ? const Color(0xffA5A5AC): const Color(0xff838387),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: _width,
                          decoration: BoxDecoration(
                            color: (Global.isDark) ? const Color(0xff1C1C1E) : const Color(0xffFEFFFE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PopupMenuButton(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: (Global.isDark == true) ? const Color(0xff2A2B2D) : Colors.white,
                                child: Container(
                                  width: _width,
                                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 20),
                                  child: const Text("Send Message",
                                    style: TextStyle(
                                      fontFamily: 'Iphone',
                                      color: Color(0xff0983FE),
                                      fontSize: 18,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                itemBuilder: (context) => Global.contactList[widget.index]['phone'].map<PopupMenuItem>((e){
                                  return PopupMenuItem(
                                    child: GestureDetector(
                                      onTap: () async {
                                        final Uri sms = Uri(
                                          scheme: 'sms',
                                          path: '+91$e',
                                        );
                                        await launchUrl(sms);
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 250,
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("+91 $e",
                                              style: TextStyle(
                                                fontFamily: 'Iphone',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.5,
                                                color: (Global.isDark == true) ? Colors.white : Colors.black,
                                              ),
                                            ),
                                            Icon(CupertinoIcons.chat_bubble,
                                              color: (Global.isDark == true) ? Colors.white : Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                  height: 1,
                                  color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Share.share(
                                    "Name\t : ${Global.contactList[widget.index]['fName']} ${Global.contactList[widget.index]['lName']}\nNumber\t : ${Global.contactList[widget.index]['phone'].join(" ")}",
                                    subject: "Demo SMS",
                                  );
                                },
                                child: Container(
                                  width: _width,
                                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 20),
                                  child: const Text("Share Contact",
                                    style: TextStyle(
                                      fontFamily: 'Iphone',
                                      color: Color(0xff0983FE),
                                      fontSize: 18,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                  height: 1,
                                  color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                                ),
                              ),
                              Container(
                                width: _width,
                                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 20),
                                child: const Text("Add to Favourites",
                                  style: TextStyle(
                                    fontFamily: 'Iphone',
                                    color: Color(0xff0983FE),
                                    fontSize: 18,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: _width,
                          decoration: BoxDecoration(
                            color: (Global.isDark) ? const Color(0xff1C1C1E) : const Color(0xffFEFFFE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: _width,
                                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 20),
                                child: const Text("Add to Emergency Contacts",
                                  style: TextStyle(
                                    fontFamily: 'Iphone',
                                    color: Color(0xff0983FE),
                                    fontSize: 18,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: _width,
                          decoration: BoxDecoration(
                            color: (Global.isDark) ? const Color(0xff1C1C1E) : const Color(0xffFEFFFE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: _width,
                                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 20),
                                child: const Text("Share My Location",
                                  style: TextStyle(
                                    fontFamily: 'Iphone',
                                    color: Color(0xff0983FE),
                                    fontSize: 18,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamedAndRemoveUntil(context, 'contact', (route) => false);
                            Global.contactList.remove(Global.contactList[widget.index]);
                          },
                          child: Container(
                            width: _width,
                            decoration: BoxDecoration(
                              color: (Global.isDark) ? const Color(0xff1C1C1E) : const Color(0xffFEFFFE),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: _width,
                                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 20),
                                  child: const Text("Delete Contact",
                                    style: TextStyle(
                                      fontFamily: 'Iphone',
                                      color: Colors.red,
                                      fontSize: 18,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
      backgroundColor: (Global.isDark == true) ? const Color(0xff000000) : const Color(0xffF2F2F6),
    );
  }
}
