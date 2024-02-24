import 'dart:async';
import 'dart:developer';

import 'package:beauty/network/tag.dart';
import 'package:beauty/utils/constant.dart';
import 'package:beauty/utils/html.dart';
import 'package:beauty/utils/string.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

@immutable
class Album {
  const Album({
    required this.tagID,
    required this.id,
    required this.name,
    required this.cover,
    required this.date,
    required this.count,
  });

  final int tagID;
  final int id;
  final String name;
  final String cover;
  final String date;
  final int count;

  factory Album.parse(Element element) {
    var img = element.querySelector('a > img')!;

    var numbers = findNumbers(
      Uri.parse(
        element.querySelector("a")!.attributes["href"]!,
      ).path,
    ).toList();

    return Album(
      tagID: numbers[0],
      id: numbers[1],
      name: img.attributes["alt"]!,
      cover: img.attributes["src"]!,
      date: element.querySelector("span.time")!.text,
      count: findNumbers(
        element.querySelector("span.click")!.text,
      ).first,
    );
  }
}

Stream<Album> getAlbums(Tag tag, int index) async* {
  log("getAlbums");

  final html =
      await get(Uri.https(host, "ku/${tag.id}/list_${tag.id}_$index.html"))
          .html();

  for (var element in html.querySelectorAll("div.list > div")) {
    yield Album.parse(element);
  }
}
