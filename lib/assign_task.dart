import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class AssignTask extends StatefulWidget {
  List<QueryDocumentSnapshot> userData = [];
  AssignTask({super.key, required this.userData});

  @override
  State<AssignTask> createState() => _AssignTaskState();
}

class _AssignTaskState extends State<AssignTask> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assign Task',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Task Description'),
            ),

            SizedBox(
              height: 80,
            ),

            TextButton(
                onPressed: () {
                  print(widget.userData);
                },
                child: Text('Hai'))
            // DropdownButton<String>(
            //   value: dropdownValue,
            //   icon: const Icon(Icons.arrow_downward),
            //   elevation: 16,
            //   style: const TextStyle(color: Colors.deepPurple),
            //   underline: Container(
            //     height: 2,
            //     color: Colors.deepPurpleAccent,
            //   ),
            //   onChanged: (String? value) {
            //     // This is called when the user selects an item.
            //     setState(() {
            //       dropdownValue = value!;
            //     });
            //   },
            //   items: widget.userData.map<DropdownMenuItem<String>>((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value.,
            //       child: Text(value),
            //     );
            //   } as DropdownMenuItem<String> Function(QueryDocumentSnapshot<Object?> e)).toList(),
            // ),
            // DropdownMenu(dropdownMenuEntries: )
          ],
        ),
      ),
    );
  }
}
