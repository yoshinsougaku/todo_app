import 'package:flutter/material.dart';
import 'package:flutter_todo/add/add_model.dart';
import 'package:provider/provider.dart';
import '../main_model.dart';

class AddPage extends StatelessWidget {
  final MainModel model;
  AddPage(this.model);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>.value(
        value: model,
        child: Scaffold(
          appBar: AppBar(
            title: Text('新規追加'),
          ),
          body: Consumer<MainModel>(
              builder: (context, model, child) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "やることを記入"
                      ),
                      onChanged: (text){
                        model.newTodoText = text;
                      },
                    ),
                    SizedBox(height: 16),
                    RaisedButton(child: Text('追加'),
                        onPressed: () async {
                          // firestoreに値を追加
                          await model.add();
                           Navigator.pop(context);
                    }),
                  ],),
                );
              }),
          floatingActionButton: FloatingActionButton(
            tooltip: 'increment',
            onPressed: () {  },
            child: Icon(Icons.add),
          ),
        ),

    );
  }
}