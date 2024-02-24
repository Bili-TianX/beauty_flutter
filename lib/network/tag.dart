import 'dart:async';
import 'dart:developer';

import 'package:beauty/utils/constant.dart';
import 'package:beauty/utils/string.dart';
import 'package:fast_gbk/fast_gbk.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

@immutable
class Tag {
  const Tag({required this.id, required this.name, required this.count});

  final int id;
  final String name;
  final int count;

  factory Tag.parse(Element element) {
    final a = element.querySelector('a')!;
    final span = element.querySelector('span')!;

    return Tag(
      id: findNumbers(a.attributes["href"]!).last,
      name: a.text,
      count: findNumbers(span.text).first,
    );
  }
}

Stream<Tag> getTags() async* {
  log("getTags");
  final response = await get(Uri.https(host, "ku/tag"));
  final html = parse(gbk.decode(response.bodyBytes));
  for (var element in html.querySelectorAll("div.main li")) {
    yield Tag.parse(element);
  }
}
