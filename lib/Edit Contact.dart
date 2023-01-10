import 'dart:io';

import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'Contact Details.dart';

import 'Global Var.dart';

class EditContact extends StatefulWidget {
  int edit;
  EditContact({Key? key, required this.edit}) : super(key: key);

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {

  @override
  void initState(){
    super.initState();
    print(Global.contactList[widget.edit]);
    Global.fName.text = Global.contactList[widget.edit]['fName'];
    Global.lName.text = Global.contactList[widget.edit]['lName'];
    Global.mail.text = Global.contactList[widget.edit]['email'];

    Global.firstName = Global.contactList[widget.edit]['fName'];
    Global.lastName = Global.contactList[widget.edit]['lName'];
    Global.email = Global.contactList[widget.edit]['email'];
    Global.addPhone = Global.contactList[widget.edit]['phone'];
    Global.image = Global.contactList[widget.edit]['profileImage'];

    for(int i = 0 ; i < Global.addPhone.length ; i++)
      {
        Global.clearAddPhone.add(TextEditingController());
        Global.clearAddPhone[i].text = Global.contactList[widget.edit]['phone'][i];
      }
  }

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
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
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
                        setState(() {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => ContactDetails(index: widget.edit),),
                          );
                          print(Global.addPhone);
                          print(Global.clearAddPhone);
                        });
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
                    child: Text("Edit Contact",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Iphone',
                        color: (Global.isDark == true) ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w700,
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
                          Navigator.of(context).pushNamedAndRemoveUntil('contact', (route) => false);
                          for(int i = 0 ; i < Global.call.length ; i++)
                            {
                              if('${Global.contactList[widget.edit]['fName']} ${Global.contactList[widget.edit]['lName']}' == Global.call[i]['name'])
                                {
                                  Global.call[i]['name'] = "${Global.firstName} ${Global.lastName}";
                                }
                            }
                          Global.contactList[widget.edit] = {
                            'fName': Global.firstName,
                            'lName': Global.lastName,
                            'email': Global.email,
                            'phone': Global.addPhone.toList(),
                            'profileImage': Global.image
                          };
                          print(Global.contactList[widget.edit]);
                          print(Global.contactList);
                          Global.image = null;
                          Global.fName.clear();
                          Global.lName.clear();
                          Global.mail.clear();
                          Global.addPhone.clear();
                          Global.clearAddPhone.clear();
                        });
                      },
                      child: Text("Done",
                        style: TextStyle(
                          fontFamily: 'Iphone',
                          fontSize: 20,
                          color: (Global.isDark == true)
                              ? (Global.firstName != "" || Global.lastName != "" || Global.email != "" || Global.addPhone.isNotEmpty) ? const Color(0xff0A84FE) : const Color(0xff404041)
                              : (Global.firstName != "" || Global.lastName != "" || Global.email != "" || Global.addPhone.isNotEmpty) ? const Color(0xff0A84FE) : const Color(0xffBCBCBF),
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
                  expandedHeight: 170,
                  backgroundColor: (Global.isDark == true) ? const Color(0xff1C1C1E) : const Color(0xffF2F2F6),
                  flexibleSpace: CustomizableSpaceBar(
                    builder: (context, scrollingRate) => Column(
                      children: [
                        (Global.image == null)
                            ? CircleAvatar(
                          radius: 85 - 50 * scrollingRate,
                          backgroundColor: const Color(0xff9095A0),
                          // backgroundImage: const AssetImage('build/contact/profile.png'),
                          child: Text(Global.contactList[widget.edit]['fName'][0],
                            style: GoogleFonts.fredoka(
                              fontSize: 90 - 60 * scrollingRate,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
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
                                        // initialValue: Global.addPhone[i].toString(),
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
      ),
      backgroundColor: (Global.isDark == true) ? const Color(0xff1C1C1E) : const Color(0xffF2F2F6),
    );
  }
}
