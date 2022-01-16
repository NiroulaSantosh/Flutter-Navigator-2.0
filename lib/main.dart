import 'package:flutter/material.dart';
import 'package:navigator_2/model.dart';
import 'package:navigator_2/router_delegate.dart';
import 'package:navigator_2/router_information_parser.dart';

void main() => runApp(const BookApp());

class BookApp extends StatefulWidget {
  const BookApp({Key? key}) : super(key: key);

  @override
  _BookAppState createState() => _BookAppState();
}

class _BookAppState extends State<BookApp> {
  // Book? _selectedBook;
  // bool show404 = false;

  // final List<Book> bookList = [
  //   Book('Left Hand of Darkness', 'Ursula K. Le Guin'),
  //   Book('Too Like the Lightning', 'Ada Palmer'),
  //   Book('Kindred', 'Octavia E. Butler'),
  // ];

  final BookRouterDelegate _routerDelegate = BookRouterDelegate();
  final BookRouteInformationParser _routeInformationParser =
      BookRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Book App',
      routeInformationParser: _routeInformationParser,
      routerDelegate: _routerDelegate,
    );

    // MaterialApp(

    //   title: 'Books App',
    //   home: Navigator(
    //     pages: [
    //       MaterialPage(
    //         child: BookListScreen(
    //           books: bookList,
    //           onTapped: _handelBookTapped,
    //         ),
    //         key: const ValueKey('BookListPage'),
    //       ),
    //       if (show404)
    //         const MaterialPage(
    //           child: UnknowScreen(),
    //           key: ValueKey('unknowscreen'),
    //         )
    //       else if (_selectedBook != null)
    //         MaterialPage(
    //           child: BookDetailsScreen(book: _selectedBook!),
    //           key: ValueKey(_selectedBook),
    //         )
    //     ],
    //     onPopPage: (router, result) {
    //       if (!router.didPop(result)) {
    //         return false;
    //       }
    //       setState(() {
    //         _selectedBook = null;
    //       });
    //       return true;
    //     },
    //   ),
    // );
  }

  // void _handelBookTapped(Book book) {
  //   setState(() {
  //     _selectedBook = book;
  //   });
  // }
}

class BookListScreen extends StatelessWidget {
  const BookListScreen({Key? key, required this.books, required this.onTapped})
      : super(key: key);
  final ValueChanged<Book> onTapped;
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for (var book in books)
            ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => onTapped(book),
            ),
        ],
      ),
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);
  final Book book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: ListTile(
        title: Text(book.author),
      ),
    );
  }
}

class UnknowScreen extends StatelessWidget {
  const UnknowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Text('404 Not found!'),
    );
  }
}
