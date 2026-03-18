import 'package:bharat_metal_grid/widget/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/navigation/routes.dart';
import '../../../core/constants/api_constants.dart';
import '../model/galleryListModel.dart';

class GalleryGridScreen extends StatelessWidget {
  final List<GalleryData> galleryList;

  const GalleryGridScreen({
    super.key,
    required this.galleryList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Gallery"),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: galleryList.length,
        itemBuilder: (context, index) {
          final image = galleryList[index];

          return GestureDetector(
            onTap: () {
              context.push(
                Routes.fullGallery,
                extra: {
                  'list': galleryList, // poora list
                  'index': index,      // jo image click hua
                },
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "${ApiConstants.baseUrl}${image.images!.first}",
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}




class FullGalleryView extends StatefulWidget {
  final List<GalleryData> galleryList;
  final int initialIndex;

  const FullGalleryView({
    super.key,
    required this.galleryList,
    required this.initialIndex,
  });

  @override
  State<FullGalleryView> createState() => _FullGalleryViewState();
}

class _FullGalleryViewState extends State<FullGalleryView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.initialIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(title: ""),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.galleryList.length,
        itemBuilder: (context, index) {
          final image = widget.galleryList[index];

          return InteractiveViewer(
            child: Center(
              child: Image.network(
                "${ApiConstants.baseUrl}${image.images!.first}",
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}