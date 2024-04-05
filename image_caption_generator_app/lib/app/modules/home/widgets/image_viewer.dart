import 'package:flutter/material.dart';

class ImageViewerPage extends StatelessWidget {
  final String imageViewUrl;

  const ImageViewerPage({super.key, required this.imageViewUrl});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(maxScale: 5.0, child: Image.network(imageViewUrl));
  }
}
