import 'package:flutter/material.dart';
import 'package:navigator_2/router_path.dart';

class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');

    // handle '/'.
    if (uri.pathSegments.isEmpty) {
      return BookRoutePath.home();
    }

    // handle '/book/:id'.

    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'book') {
        return BookRoutePath.unknown();
      }
      var id = int.tryParse(uri.pathSegments[1]);

      if (id == null) {
        return BookRoutePath.unknown();
      }

      return BookRoutePath.details(id);
    }

    // handle unknow route.
    return BookRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(BookRoutePath path) {
    if (path.isUnknow == true) {
      return const RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return const RouteInformation(location: '/');
    }

    if (path.isDetailPage) {
      return RouteInformation(location: '/book/${path.id}');
    }

    return null;
  }
}
