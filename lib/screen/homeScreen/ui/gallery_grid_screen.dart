import 'package:bharat_metal_grid/widget/customAppbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../../../app/router/navigation/routes.dart';
import '../../../core/constants/api_constants.dart';
import '../model/galleryListModel.dart';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:typed_data';
import 'package:dio/dio.dart';
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
      appBar: CustomAppBar(
        title: "",
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) async {
              final currentIndex = _pageController.page?.toInt() ?? widget.initialIndex;
              final image = widget.galleryList[currentIndex];
              final imageUrl = "${ApiConstants.baseUrl}${image.images!.first}";

              if (value == "download") {
                await _downloadImage(context, imageUrl);
              } else if (value == "share") {
                await _shareImage(imageUrl);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "download",
                child: Text("Download"),
              ),
              const PopupMenuItem(
                value: "share",
                child: Text("Share"),
              ),
            ],
          ),
        ],
      ),
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
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image_not_supported_outlined,color: Colors.grey,size: 100,);
                },
              ),
            ),
          );
        },
      ),
    );
  }
  Future<void> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      print("Storage permission granted");
    } else {
      print("Permission denied");
    }
  }


  Future<void> _downloadImage(BuildContext context, String url) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      // 🔽 download image bytes
      final response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      Uint8List bytes = Uint8List.fromList(response.data);

      // 🔐 permission
      final permission = await PhotoManager.requestPermissionExtend();

      if (!permission.isAuth) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Permission denied")),
        );
        return;
      }

      // ✅ IMPORTANT: filename dena compulsory hai
      final fileName =
          "BharatMetal_${DateTime.now().millisecondsSinceEpoch}.jpg";

      final result = await PhotoManager.editor.saveImage(
        bytes,
        filename: fileName, // ✅ FIX
        title: fileName,
      );

      Navigator.pop(context);

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Image saved to gallery")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("❌ Failed to save image")),
        );
      }
    } catch (e) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Download failed")),
      );
    }
  }
  Future<void> _shareImage(String url) async {
    try {
      final dio = Dio();

      final dir = await getTemporaryDirectory();
      final filePath = "${dir.path}/share_${DateTime.now().millisecondsSinceEpoch}.jpg";

      await dio.download(url, filePath);

      await Share.shareXFiles(
        [XFile(filePath)],
        text:
        "🚀 Discover Bharat Metal Grid\n\nStay connected with the latest updates from the metal industry.\n\n📲 Download now:\nhttps://play.google.com/store/apps/details?id=com.yourapp"
      );
    } catch (e) {
      print("Share error: $e");
    }
  }
}