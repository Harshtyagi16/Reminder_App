import "package:flutter/material.dart";
import 'package:one_page_to_another_page/model/todo.dart';
import 'package:one_page_to_another_page/screens/AddTodo.dart';
import 'package:one_page_to_another_page/screens/category.dart';

import 'package:one_page_to_another_page/widgets/todo_item.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  createAlertDailog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Your tag"),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () {
                    Provider.of<ToDoController>(context, listen: false)
                        .tagName(tagName: customController.text);
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    // final todosList = Provider.of<ToDoController>(context).todoList;
    final todo = Provider.of<ToDoController>(context);
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => AddTodoPage())));
                  },
                  icon: Icon(Icons.add))
            ],
            backgroundColor: Colors.green,
            title: SearchBox(),
          ),
          drawer: Drawer(
              child: isLoading
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          Provider.of<ToDoController>(context).tag.length,
                      itemBuilder: (context, i) {
                        return Card(
                          child: Row(
                            children: [
                              MaterialButton(
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                onPressed: () async {
                                  todo.clearTagLst();

                                  for (int j = 0;
                                      j < todo.todoList.length;
                                      j++) {
                                    if (todo.todoList[j].allTags
                                        .contains(todo.tag[i])) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await todo.addSortTag(
                                          todo: todo.todoList[j]);
                                      setState(() {
                                        isLoading = false;
                                      });

                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Category()));
                                    } else {
                                      print('nhi hai');
                                    }
                                  }
                                  // if (todo.tag.contains(todo.tag[i])) {
                                  //   print('hai na bhai');
                                  // } else {
                                  //   print('Nhi hai bhai');
                                  // }
                                },
                                child: Text(Provider.of<ToDoController>(context)
                                    .tag[i]),
                              ),
                            ],
                          ),
                        );
                      })),
          body: Container(
              child: Container(
            color: Colors.white,
            child: Column(children: [
              Container(
                height: 360,
                width: double.infinity,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: todo.todoList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ToDoItem(
                        todo: todo.todoList[index],
                      );
                    }),
              ),
              Divider(),
              Row(children: [
                Expanded(
                  child: MaterialButton(
                    color: Colors.amber,
                    onPressed: () {
                      createAlertDailog(context);
                    },
                    child: Text('add tag'),
                  ),
                )
              ]),
              Divider(),
              Consumer<ToDoController>(builder: (context, tagListC, _) {
                return Container(
                    height: 140,
                    width: double.infinity,
                    color: Colors.blueAccent,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: tagListC.tag.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: Row(
                              children: [
                                Text(tagListC.tag[i]),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      tagListC.deleteTag(i);
                                    },
                                    icon: Icon(Icons.delete))
                              ],
                            ),
                          );
                        }));
              }),
            ]),
          ))),
    );
  }

  Widget SearchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(20),
      ),
      // ignore: prefer_const_constructors
      child: TextField(
        // onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            maxWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
        ),
      ),
    );
  }
}
