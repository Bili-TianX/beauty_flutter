import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class MyImage extends StatefulWidget {
  final String imageUrl;

  const MyImage({super.key, required this.imageUrl});

  @override
  MyImageState createState() => MyImageState();
}

class MyImageState extends State<MyImage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ExtendedImageSlidePage(
      child: ExtendedImage.network(
        widget.imageUrl,
        mode: ExtendedImageMode.gesture,
        clearMemoryCacheWhenDispose: true,
        compressionRatio: 1,
        cache: true,
      ),
    );
  }
}
