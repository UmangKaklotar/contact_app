import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Contact Details.dart';

import 'Global Var.dart';

class Call extends StatefulWidget {
  const Call({Key? key}) : super(key: key);

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  String call = "All";
  @override
  Widget build(BuildContext context) {
    List recentCall = Global.call.reversed.toList();
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded,
            color: (Global.isDark == true) ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: (Global.isDark == true) ? const Color(0xff000000) : const Color(0xffFEFFFE),
        title: Container(
          height: 35,
          width: 180,
          decoration: BoxDecoration(
            color: (Global.isDark == true) ? const Color(0xff1C1C1F) : const Color(0xffEEEEEE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const SizedBox(width: 2.5),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      call = "All";
                    });
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: (Global.isDark == true)
                          ? (call == "All") ? const Color(0xff5A5A5F) : Colors.transparent
                          : (call == "All") ? const Color(0xffFEFFFE) : Colors.transparent,
                    ),
                    alignment: Alignment.center,
                    child: Text("All",
                      style: TextStyle(
                        fontFamily: 'Iphone',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 16,
                        color: (Global.isDark == true) ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      call = "Missed";
                    });
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: (Global.isDark == true)
                          ? (call == "Missed") ? const Color(0xff5A5A5F) : Colors.transparent
                          : (call == "Missed") ? const Color(0xffFEFFFE) : Colors.transparent,
                    ),
                    alignment: Alignment.center,
                    child: Text("Missed",
                      style: TextStyle(
                        fontFamily: 'Iphone',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 16,
                        color: (Global.isDark == true) ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 2.5),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: (call == 'All')
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 54),
              child: Text("Recents",
                style: TextStyle(
                  fontFamily: 'Iphone',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 35,
                  color: (Global.isDark == true) ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.only(left: 54),
              height: 1,
              color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
            ),
            ...recentCall.map((e){
              return GestureDetector(
                onTap: () async {
                  await FlutterPhoneDirectCaller.callNumber(e['number']);
                  setState(() {
                    final DateTime _time = DateTime.now();
                    Global.call.add({
                      'name': e['name'],
                      'number': e['number'],
                      'time': '${_time.hour}:${_time.minute} ${(_time.hour >= 12) ? 'PM' : 'AM'}',
                      'index': e['index']
                    });
                  });
                },
                child: Slidable(
                  key: UniqueKey(),
                  startActionPane: ActionPane(
                    // key: UniqueKey(),
                    motion: const ScrollMotion(),
                    extentRatio: 0.2,
                    dismissible: DismissiblePane(onDismissed: () async {
                      await FlutterPhoneDirectCaller.callNumber(e['number']);
                      setState(() {
                        final DateTime _time = DateTime.now();
                        Global.call.add({
                          'name': e['name'],
                          'number': e['number'],
                          'time': '${_time.hour}:${_time.minute} ${(_time.hour >= 12) ? 'PM' : 'AM'}',
                          'index': e['index']
                        });
                      });
                    }),
                    children: [
                      SlidableAction(
                        onPressed: (val) async {
                          await FlutterPhoneDirectCaller.callNumber(e['number']);
                          setState(() {
                            final DateTime _time = DateTime.now();
                            Global.call.add({
                              'name': e['name'],
                              'number': e['number'],
                              'time': '${_time.hour}:${_time.minute} ${(_time.hour >= 12) ? 'PM' : 'AM'}',
                              'index': e['index']
                            });
                          });
                        },
                        backgroundColor: const Color(0xff30D158),
                        foregroundColor: Colors.white,
                        icon: CupertinoIcons.phone_fill,
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    // key: ValueKey(e),
                    motion: const ScrollMotion(),
                    extentRatio: 0.2,
                    dismissible: DismissiblePane(onDismissed: () {
                      Global.call.remove(e);
                    }),
                    children: [
                      SlidableAction(
                        onPressed: (val){
                          setState(() {
                            Global.call.remove(e);
                          });
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 65,
                    width: _width,
                    // color: Colors.grey.shade100,
                    child: Row(
                      children: [
                        const SizedBox(width: 15),
                        Align(
                          alignment: const Alignment(0,-0.5),
                          child: Icon(CupertinoIcons.phone_fill_arrow_up_right,
                            color: (Global.isDark == true) ? const Color(0xff444447) : const Color(0xffC4C4C6),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e['name'],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Iphone',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                        color: (Global.isDark == true) ? Colors.white : Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(e['number'],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Iphone',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                        color: (Global.isDark == true) ? const Color(0xff95959B) : const Color(0xff838387),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(e['time'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Iphone',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                    color: (Global.isDark == true) ? const Color(0xff95959B) : const Color(0xff838387),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactDetails(index: e['index'])));
                                  },
                                  child: const Icon(CupertinoIcons.info_circle,
                                    size: 28,
                                    color: Color(0xff0983FE),
                                  ),
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 54),
              child: Text("Recents",
                style: TextStyle(
                  fontFamily: 'Iphone',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 35,
                  color: (Global.isDark == true) ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.only(left: 54),
              height: 1,
              color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
            ),
            SizedBox(
              height: 65,
              width: _width,
              // color: Colors.grey.shade100,
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Align(
                    alignment: const Alignment(0,-0.5),
                    child: Icon(CupertinoIcons.phone_fill_arrow_down_left,
                      color: (Global.isDark == true) ? const Color(0xff444447) : const Color(0xffC4C4C6),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: (Global.isDark == true) ? Colors.grey.shade800 : const Color(0xffDADBDC),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Umang Kaklotar",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Iphone',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text("+91 8469186173",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Iphone',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  color: (Global.isDark == true) ? const Color(0xff95959B) : const Color(0xff838387),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text("2:19 PM",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Iphone',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              color: (Global.isDark == true) ? const Color(0xff95959B) : const Color(0xff838387),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(CupertinoIcons.info_circle,
                            size: 28,
                            color: Color(0xff0983FE),
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: (Global.isDark == true) ? const Color(0xff000000) : const Color(0xffFEFFFE),
    );
  }
}
