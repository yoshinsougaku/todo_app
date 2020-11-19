import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo/main_model.dart';

import 'add/add_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todoアプリ',
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel()..getTodoListRealtime(),
        child: Consumer<MainModel>(
            builder: (context, model, child) {
              final todoList = model.todoList;
              final isActive = model.checkShouldActiveCompletebutton();

              return Scaffold(
              appBar: AppBar(
                title: Text('Todoアプリ'),
                actions: [
                  FlatButton(onPressed: isActive  ? () async {
                    await model.deleteCheckedItems();
                  } : null,
                    child: Text('完了',
                    style: TextStyle(
                      color: isActive  ? Colors.white : Colors.white.withOpacity(0.5)
                    ),),
                  )
                ],
              ),
              body: ListView(
            children: todoList.map((todo) => CheckboxListTile(
                        title:  Text(todo.title),
                        value: todo.isDone,
                        onChanged: (bool value) {
                          todo.isDone = !todo.isDone;
                          model.reload();
                        },
                      ),
                      ).toList(),
                    ),


              floatingActionButton: Consumer<MainModel>(
                  builder: (context, model, child) {
                  return FloatingActionButton(
                    onPressed: () async{
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddPage(model),
                          fullscreenDialog: true
                        ),
                      );
                    },
                    child: Icon(Icons.add),
                  );
                }
              ),

            );
          }
        ),
    );
  }
}