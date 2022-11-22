import 'package:flutter/material.dart';
import 'package:one_page_to_another_page/model/todo.dart';
import 'package:provider/provider.dart';
import '../screens/homepage.dart';

class Category extends StatefulWidget {
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool done = false;

  @override
  Widget build(BuildContext context) {
    final sortC = Provider.of<ToDoController>(context).sortTag;
    return Scaffold(
      body: ListView.builder(
          itemCount: sortC.length,
          itemBuilder: (context, i) {
            return Container(
              child: Column(
                children: [
                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 165, 231, 167),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.only(top: 20),
                    child: ListTile(
                      leading: IconButton(
                        onPressed: () {
                          setState(() {
                            done = !done;
                          });
                        },
                        icon: Icon(
                          done
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: Colors.blue,
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      title: Column(
                        children: [
                          Text(
                            sortC[i].todoText,
                            style: TextStyle(
                              fontSize: 20,
                              decoration:
                                  done ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          Text("Data & Time"),
                          Wrap(
                            children: sortC[i].allTags.map((e) {
                              return Chip(label: Text(e));
                            }).toList(),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        color: Colors.red,
                        // iconSize: 18,
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Provider.of<ToDoController>(context, listen: false)
                          //     .deleteItems(todo: widget.todo);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
