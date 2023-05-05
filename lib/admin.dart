import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management/assign_task.dart';

import 'view_task.dart';
import 'login.dart';

class Teacher extends StatefulWidget {
  const Teacher({super.key});

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  List<QueryDocumentSnapshot> _userList = [];

  @override
  void initState() {
    super.initState();
    _getUserList();
  }

  Future<void> _getUserList() async {
    QuerySnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      _userList = userSnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Admin'),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 130,
                  color: Colors.lightGreen,
                  child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Text(
                        'Assign Task',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        log(_userList[3].toString(), name: "Check This");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AssignTask(
                                      userData: _userList,
                                    )));
                      }),
                ),
              ),
            ),
            Container(
              child: Text(
                'User',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            Expanded(
                child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemCount: _userList.length,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot userSnapshot = _userList[index];
                  Map<String, dynamic>? userData =
                      userSnapshot.data() as Map<String, dynamic>?;
                  return userData!['rool'] == 'Admin'
                      ? Text('')
                      : ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewTask()));
                                },
                                child: Text(
                                  userData['email'],
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
