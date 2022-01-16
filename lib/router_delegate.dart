import 'package:flutter/material.dart';
import 'package:navigator_2/main.dart';
import 'package:navigator_2/model.dart';
import 'package:navigator_2/router_path.dart';

class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  bool show404 = false;
  Book? _selectedBook;

  final GlobalKey<NavigatorState> navigatorKey;

  List<Book> books = [
    Book('Left Hand of Darkness', 'Ursula K. Le Guin'),
    Book('Too Like the Lightning', 'Ada Palmer'),
    Book('Kindred', 'Octavia E. Butler'),
  ];

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  void _handleTaapped(Book book) {
    _selectedBook = book;
    notifyListeners();
  }

  BookRoutePath get currentConfiguration {
    if (show404) {
      return BookRoutePath.unknown();
    }
    return _selectedBook == null
        ? BookRoutePath.home()
        : BookRoutePath.details(books.indexOf(_selectedBook!));
  }

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: BookListScreen(
            books: books,
            onTapped: _handleTaapped,
          ),
        ),
        if (show404)
          const MaterialPage(
            child: UnknowScreen(),
            key: ValueKey('unknowscreen'),
          )
        else if (_selectedBook != null)
          MaterialPage(
            child: BookDetailsScreen(book: _selectedBook!),
            key: ValueKey(_selectedBook),
          )
      ],
      onPopPage: (router, result) {
        if (!router.didPop(result)) {
          return false;
        }
        _selectedBook = null;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<bool> popRoute() {
    // TODO: implement popRoute
    throw UnimplementedError();
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath path) async {
    // if (path.isUnknow == true) {
    //   _selectedBook = null;
    //   show404 = true;
    //   return;
    // }

    if (path.isDetailPage) {
      if (path.id == null || path.id! < 0 || path.id! > books.length - 1) {
        show404 = true;
        return;
      }
      _selectedBook = books[path.id!];
    } else {
      _selectedBook = null;
    }
    show404 = false;
  }
}
