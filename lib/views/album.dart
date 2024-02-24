import 'package:beauty/network/album.dart';
import 'package:beauty/network/tag.dart';
import 'package:beauty/views/error.dart';
import 'package:beauty/views/loading.dart';
import 'package:beauty/views/photo.dart';
import 'package:beauty/widgets/bold_text.dart';
import 'package:beauty/widgets/image.dart';
import 'package:beauty/widgets/reload_button.dart';
import 'package:beauty/widgets/back_button.dart';
import 'package:flutter/material.dart';

class AlbumViewState extends State<AlbumView> {
  late Stream<Album> _stream;
  List<Album> albums = [];
  dynamic error;
  int index = 1;

  @override
  void initState() {
    super.initState();
    reset();
  }

  void reset() {
    _stream = getAlbums(widget.tag, index)
        .handleError((error) => setState(() => this.error = error));
    _stream.listen((album) => setState(() => albums.add(album)));

    albums = [];
    error = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GoBackButton(context),
        title: BoldText(text: widget.tag.name),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: index > 1
                ? () => setState(
                      () {
                        index--;
                        reset();
                      },
                    )
                : null,
            icon: const Icon(Icons.navigate_before),
          ),
          Text("$index"),
          IconButton(
            onPressed: () => setState(
              () {
                index++;
                reset();
              },
            ),
            icon: const Icon(Icons.navigate_next),
          ),
        ],
      ),
      body: buildAlbumViewBody(context),
      floatingActionButton: ReloadButton(
        () => setState(reset),
      ),
    );
  }

  Widget buildAlbumViewBody(BuildContext context) {
    if (error != null) {
      return ErrorView(error);
    }

    if (albums.isEmpty) {
      return const LoadingView();
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        return AlbumWidget(album: albums[index]);
      },
      itemCount: albums.length,
    );
  }
}

class AlbumView extends StatefulWidget {
  const AlbumView({super.key, required this.tag});

  final Tag tag;

  @override
  State<StatefulWidget> createState() => AlbumViewState();
}

class AlbumWidget extends StatelessWidget {
  const AlbumWidget({super.key, required this.album});

  final Album album;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PhotoView(album: album),
        )),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  album.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text("${album.date} | ${album.count} 张"),
                MyImage(imageUrl: album.cover),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
