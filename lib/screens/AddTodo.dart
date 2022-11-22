import "package:flutter/material.dart";
import 'package:one_page_to_another_page/model/todo.dart';
import 'package:one_page_to_another_page/screens/homepage.dart';
import 'package:provider/provider.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({
    super.key,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  String? tagName;
  List<String> taglst = [];

  TextEditingController _title = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tag = Provider.of<ToDoController>(context).tag;
    int id = DateTime.now().millisecondsSinceEpoch.toInt();

    return Scaffold(
      body: Form(
        child: Container(
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "create",
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "New ToDo List",
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Task titles",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.5,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xff2a2e3d),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: _title,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter title';
                          }
                          return null;
                        },
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Task Title",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Descriptions",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.5,
                        letterSpacing: 0.2,
                      ),
                    ),
                    description(),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Tags",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.5,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Wrap(
                        children: tag.asMap().entries.map((e) {
                      return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            print(e.value);

                            tagName = e.value;
                            taglst.add(e.value);
                          },
                          child: Chip(
                            label: Text(e.value),
                          ));
                    }).toList()),
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                        left: 100,
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            Provider.of<ToDoController>(context, listen: false)
                                .addItems(
                                    toDO: _title.text.trim(),
                                    id: id,
                                    tagList: taglst);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 155,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Description",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            contentPadding: EdgeInsets.only(
              left: 20,
              right: 20,
            )),
      ),
    );
  }
}
