class BookRoutePath {
  final int? id;
  final bool? isUnknow;

  BookRoutePath.home()
      : id = null,
        isUnknow = false;

  BookRoutePath.details(this.id) : isUnknow = false;

  BookRoutePath.unknown()
      : id = null,
        isUnknow = true;

  bool get isHomePage => id == null;
  bool get isDetailPage => id != null;
}
