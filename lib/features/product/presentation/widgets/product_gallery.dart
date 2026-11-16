import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/widgets/network_image_box.dart';

/// Swipeable image gallery. The first image carries the Hero animation
/// coming from the product card.
class ProductGallery extends StatefulWidget {
  const ProductGallery({super.key, required this.images, required this.heroTag});

  final List<String> images;
  final String heroTag;

  @override
  State<ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final urls = widget.images.isEmpty ? const [''] : widget.images;
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: urls.length,
          itemBuilder: (_, i) {
            final image = NetworkImageBox(url: urls[i], width: double.infinity);
            return i == 0 ? Hero(tag: widget.heroTag, child: image) : image;
          },
        ),
        if (urls.length > 1)
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: urls.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 3,
                  activeDotColor: scheme.primary,
                  dotColor: Colors.white70,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
