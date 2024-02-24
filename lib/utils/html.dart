import 'package:fast_gbk/fast_gbk.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

extension AsyncHtml on Future<Response> {
  Future<Document> html() async {
    return parse(gbk.decode((await this).bodyBytes));
  }
}
