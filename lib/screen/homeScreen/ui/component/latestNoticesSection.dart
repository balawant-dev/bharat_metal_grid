import 'package:flutter/material.dart';

import '../../../../app/router/navigation/nav.dart';
import '../../../../app/router/navigation/routes.dart';
import '../../../../app/theme/color_resource.dart';
import '../../../../widget/custom_text.dart';
import '../../../../widget/primary_button.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
class LatestNoticesSection extends StatefulWidget {
  final String image;
  final String title;
  final String des;
  final String id;
  final String pdfFile;

  const LatestNoticesSection({
    super.key,
    required this.title,
    required this.image,
    required this.des,
    required this.id,
    required this.pdfFile,
  });

  @override
  State<LatestNoticesSection> createState() => _LatestNoticesSectionState();
}

class _LatestNoticesSectionState extends State<LatestNoticesSection> {

  @override
  Widget build(BuildContext context) {
    print("PDF File is>>> ${widget.pdfFile}");
    return GestureDetector(
      onTap: () {
        Nav.push(context, Routes.latestNoticeDetail, extra: widget.id);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        height: 253,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFD5E3FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.image,
                width: MediaQuery.of(context).size.width,
                height: 107,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRCb10k2bY_-5v9N86eUeAkXO6UNvZUQ2wmzvyXWzLas5wgketI',
                    width: MediaQuery.of(context).size.width,
                    height: 107,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ColorResource.black,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  width: 63,
                  height: 18,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF241A30),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF310E54),
                      ),
                      borderRadius: BorderRadius.circular(44),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon/trending_up.png',
                        height: 14,
                        width: 14,
                      ),
                      CustomText(
                        'Popular',
                        size: 10,
                        weight: FontWeight.w500,
                        color: ColorResource.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              widget.des,
              maxLines: 2,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorResource.black,
              ),
            ),
            SizedBox(height: 5),
            CommonAppButton(
              text: 'Download Pdf',
              fontWeight: FontWeight.w500,
              onPressed: () {
                print("jab ham List par download kiya ");
                downloadAndOpenPdf(widget.pdfFile);
                print("jab ham List par download kiya2 ");
              },
            ),
          ],
        ),
      ),
    );
  }
}Future<void> downloadAndOpenPdf(String url) async {
  try {

    var status = await Permission.manageExternalStorage.request();

    if (!status.isGranted) {
      print("Permission not granted");
      return;
    }

    Directory dir = await getTemporaryDirectory();

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    String filePath = "${dir.path}/$fileName.pdf";

    print("Downloading from: $url");

    await Dio().download(
      url,
      filePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          print("Downloading ${(received / total * 100).toStringAsFixed(0)}%");
        }
      },
    );

    print("PDF saved at $filePath");

    await OpenFilex.open(filePath);

  } catch (e) {
    print("Download error: $e");
  }
}