import 'package:example/data/books_data.dart';
import 'package:example/mobile/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../data/books_data.dart';

class BookListPage extends StatefulWidget {
  BookListPage(final String id);

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {

  List<Book> bookList;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => downloadBooks());
  }

  //Simulates the download from the backend, shouldnt be done again after pressing the back button
  Future<List<Book>> downloadBooks() async{
    await Future.delayed(Duration(seconds: 3));
    bookList = BooksDB().books;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(bookList != null) {
      return ListView(
        children: bookList
            .map((book) =>
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(book.name),
                subtitle: Text(book.genre),
                onTap: () {
                  // context.router.push(BookDetailsRoute(id: book.id));
                  BookDetailsRoute(id: book.id).show(context);
                },
              ),
            ))
            .toList(),
      );
    }
    else {
      return Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
