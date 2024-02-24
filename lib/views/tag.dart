import 'package:beauty/network/tag.dart';
import 'package:beauty/views/album.dart';
import 'package:beauty/views/error.dart';
import 'package:beauty/views/loading.dart';
import 'package:beauty/widgets/bold_text.dart';
import 'package:beauty/widgets/reload_button.dart';
import 'package:flutter/material.dart';

class TagViewState extends State<TagView> {
  late Stream<Tag> _stream;
  List<Tag> tags = [];
  dynamic error;

  @override
  void initState() {
    super.initState();
    reset();
  }

  void reset() {
    _stream =
        getTags().handleError((error) => setState(() => this.error = error));
    _stream.listen((tag) => setState(() => tags.add(tag)));
    tags = [];
    error = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TagViewBar(),
      body: buildTagViewBody(context),
      floatingActionButton: ReloadButton(
        () => setState(reset),
      ),
    );
  }

  Widget buildTagViewBody(BuildContext context) {
    if (error != null) {
      return ErrorView(error);
    }

    if (tags.isEmpty) {
      return const LoadingView();
    }

    return ListView.builder(
      itemCount: tags.length,
      itemBuilder: (context, index) {
        return TagWidget(tag: tags[index]);
      },
    );
  }
}

class TagView extends StatefulWidget {
  const TagView({super.key});

  @override
  State<StatefulWidget> createState() {
    return TagViewState();
  }
}

class TagViewBar extends AppBar {
  TagViewBar({super.key})
      : super(
          title: const BoldText(text: "标签"),
          centerTitle: true,
        );
}

class TagWidget extends StatelessWidget {
  const TagWidget({super.key, required this.tag});

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AlbumView(tag: tag),
          ));
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  tag.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text("${tag.count} 套"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
