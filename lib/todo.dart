import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String title ;
  DateTime createdAt;
  bool isDone = false;
  DocumentReference documentReference;

  Todo(DocumentSnapshot doc) {
    this.documentReference = doc.reference;
    this.title = doc.data()['title'];
    final Timestamp timestamp = doc.data()['createdAt'];
    this.createdAt = timestamp.toDate();
  }
}