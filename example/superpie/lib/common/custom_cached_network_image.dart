import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedNetworkImage extends StatefulWidget {
  const CustomCachedNetworkImage({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
    this.nullChild,
    this.imageBuilder,
    this.errorWidget,
    this.placeholder,
    this.fit,
    this.alignment,
  });

  final String? imageUrl;
  final double? height;
  final double? width;
  final Widget? nullChild;
  final Widget? imageBuilder;
  final Widget? errorWidget;
  final Widget? placeholder;
  final BoxFit? fit;
  final Alignment? alignment;

  @override
  State<CustomCachedNetworkImage> createState() =>
      _CustomCachedNetworkImageState();
}

class _CustomCachedNetworkImageState extends State<CustomCachedNetworkImage> {
  @override
  Widget build(BuildContext context) {
    if (widget.imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: widget.imageUrl ?? "",
        height: widget.height,
        width: widget.width,
        fit: widget.fit ?? BoxFit.cover,
        alignment: widget.alignment ?? Alignment.center,
        imageBuilder: (context, imageProvider) =>
            widget.imageBuilder ??
            Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: imageProvider,
                  opacity: 1,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.blue,
          highlightColor: Colors.blueAccent,
          period: const Duration(milliseconds: 1500),
          child: widget.placeholder ??
              Container(
                height: widget.height,
                width: widget.width,
                color: Colors.white,
              ),
        ),
        errorWidget: (context, url, error) =>
            widget.errorWidget ??
            Container(
              height: widget.height,
              width: widget.width,
              color: Colors.white,
            ),
      );
    } else {
      return widget.nullChild ??
          Container(
            height: widget.height,
            width: widget.width,
            color: Colors.white,
          );
    }
  }
}
