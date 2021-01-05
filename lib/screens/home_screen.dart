// ignore: unused_import
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:searchfunc/models/task.dart';

import '../services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = List();
  List<Task> filteredTaks = List();
  @override
  void initState() {
    super.initState();
    Services.getTasks().then((tasksFromServer) {
      tasks = tasksFromServer;
      filteredTaks = tasks;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: "Search Task",
              ),
              onChanged: (string) {
                setState(() {
                  filteredTaks = tasks
                      .where((u) =>
                          (u.text.toLowerCase().contains(string.toLowerCase())))
                      .toList();
                });
              },
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTaks.length,
                itemBuilder: (context, index) {
                  return tasks.length == 0
                      ? Center(child: CircularProgressIndicator())
                      : Card(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filteredTaks[index].text,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  filteredTaks[index].isComplete.toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
