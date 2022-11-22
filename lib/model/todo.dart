import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ToDo {
  int? id;
  String todoText;
  bool isDone;
  //String tag;
  List<String> allTags;

  // DateTime date;
  // List<String> tagL;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
    //required this.tag,
    required this.allTags,

    // required this.date,
    // required this.tagL,
  });
}

class ToDoController with ChangeNotifier {
  List<ToDo> todoList = [
    // ToDo(
    //     id: 1,
    //     todoText: "Read a book for 15 mins",
    //     isDone: true,
    //     allTags: ['1tag', '2tag']),
  ];

  List<String> tag = [];
  List<ToDo> sortTag = [];

  void clearTagLst() {
    sortTag.clear();
    notifyListeners();
  }

  Future<void> addSortTag({required ToDo todo}) async {
    sortTag.add(todo);
    notifyListeners();
  }

  void tagName({required String tagName}) {
    tag.add(tagName);
    notifyListeners();
  }

  void deleteTag(int index) {
    tag.removeAt(index);
    notifyListeners();
  }

  void addItems(
      {required String toDO, required int id, required List<String> tagList}) {
    todoList.add(ToDo(id: id, todoText: toDO, allTags: tagList));
    notifyListeners();
  }

  void deleteItems({required ToDo todo}) {
    todoList.remove(todo);
    notifyListeners();
  }
}
