import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
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
        backgroundColor: Colors.lightGreen,
        title: Text("User"),
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
      body: ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (BuildContext context, int index) {
          QueryDocumentSnapshot userSnapshot = _userList[index];
          Map<String, dynamic>? userData =
              userSnapshot.data() as Map<String, dynamic>?;
          return userData!['rool'] == 'User'
              ? Text('')
              : ListTile(
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData['email'],
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        userData['rool'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.lightGreen,
                            letterSpacing: 2,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(userData['age'],
                          style: TextStyle(fontSize: 22, color: Colors.black)),
                    ],
                  ),
                  trailing: GestureDetector(
                      onTap: () {
                        print('Clicked');
                      },
                      child: Icon(Icons.add)),
                );
        },
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
