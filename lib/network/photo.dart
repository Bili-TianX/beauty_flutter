import 'dart:developer';

import 'package:beauty/network/album.dart';
import 'package:beauty/utils/constant.dart';
import 'package:beauty/utils/html.dart';
import 'package:beauty/utils/string.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart';

Stream<String> getImages(Document html) async* {
  for (var element in html.querySelectorAll("div.content > img")) {
    yield element.attributes["src"]!;
  }
}

Stream<String> getPhotos(Album album) async* {
  log("getPhotos");

  final html =
      await get(Uri.https(host, "ku/${album.tagID}/${album.id}.html")).html();

  yield* getImages(html);

  final count = findNumbers(
    html.querySelectorAll("div.page-list > ul > a").first.text,
  ).first;

  final htmlList = await Future.wait(List.generate(count - 1, (index) {
    return get(Uri.https(
      host,
      "ku/${album.tagID}/${album.id}_${index + 2}.html",
    )).html();
  }));

  for (var html in htmlList) {
    yield* getImages(html);
  }
}
