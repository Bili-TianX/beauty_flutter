import 'dart:async';

import 'package:beauty/network/album.dart';
import 'package:beauty/network/photo.dart';
import 'package:beauty/views/error.dart';
import 'package:beauty/views/loading.dart';
import 'package:beauty/widgets/back_button.dart';
import 'package:beauty/widgets/bold_text.dart';
import 'package:beauty/widgets/image.dart';
import 'package:beauty/widgets/reload_button.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({super.key, required this.album});

  final Album album;

  @override
  State<StatefulWidget> createState() => PhotoViewState();
}

class PhotoViewState extends State<PhotoView> {
  late Stream<String> _stream;
  List<String> photos = [];
  dynamic error;

  @override
  void initState() {
    super.initState();

    reset();
  }

  void reset() {
    _stream = getPhotos(widget.album)
        .handleError((error) => setState(() => this.error = error));
    _stream.listen((photo) => setState(() => photos.add(photo)));

    photos = [];
    error = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GoBackButton(context),
        title: BoldText(text: widget.album.name),
        centerTitle: true,
      ),
      body: buildPhotoViewBody(context),
      floatingActionButton: ReloadButton(() => setState(reset)),
    );
  }

  Widget buildPhotoViewBody(BuildContext context) {
    if (error != null) {
      return ErrorView(error);
    }

    if (photos.isEmpty) {
      return const LoadingView();
    }

    return ExtendedImageGesturePageView.builder(
      itemBuilder: (context, index) {
        return MyImage(imageUrl: photos[index]);
      },
      itemCount: photos.length,
      scrollDirection: Axis.horizontal,
    );
  }
}
