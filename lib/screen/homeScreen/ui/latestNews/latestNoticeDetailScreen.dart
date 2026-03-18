import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../widget/commonLoader.dart';
import '../../../../widget/customAppbar.dart';
import '../../bloc/homeBloc.dart';
import '../../bloc/homeEvent.dart';
import '../../bloc/homeState.dart';
import '../component/latestNoticesSection.dart';

class LatestNoticeDetailScreen extends StatefulWidget {
  final String id;

  const LatestNoticeDetailScreen({super.key, required this.id});

  @override
  State<LatestNoticeDetailScreen> createState() =>
      _LatestNoticeDetailScreenState();
}

class _LatestNoticeDetailScreenState extends State<LatestNoticeDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(
      FetchLatestNoticesDetailEvent(context: context, id: widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CustomAppBar(title: "Detail"),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.latestNoticesDetailModel == null ||
              state.latestNoticesDetailModel!.data == null) {
            return SizedBox(
              height: height,
              width: width,
              child: const Center(child: AppMetalLoader()),
            );
          }

          final data = state.latestNoticesDetailModel!.data!;

          return SingleChildScrollView(
            child: AnimationLimiter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 600),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 400,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    /// 🔹 Cover Image
                    FadeInAnimation(
                      child: SlideAnimation(
                        verticalOffset: -40,
                        child: Image.network(
                          "${ApiConstants.baseUrl}${data.coverImage}",
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRCb10k2bY_-5v9N86eUeAkXO6UNvZUQ2wmzvyXWzLas5wgketI',
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🔹 Title + Popular Badge
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  data.title ?? "",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              if (data.isPopular == true)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    "POPULAR",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          /// 🔹 Date
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                data.createdAt?.substring(0, 10) ?? "",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          /// 🔹 Short Description
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              data.shortDescription ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          /// 🔹 PDF Button
                          if (data.pdfFile != null &&
                              data.pdfFile!.isNotEmpty)
                            SlideAnimation(
                              verticalOffset: 20,
                              child: FadeInAnimation(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () { print("jab ham dtail par download kiya ");
                                      downloadAndOpenPdf("${ApiConstants.baseUrl}${data.pdfFile}");
                                    print("jab ham dtail par download kiya2 ");
                                      // TODO: PDF open / download logic
                                    },
                                    icon:
                                    const Icon(Icons.picture_as_pdf),
                                    label: const Text(
                                        "View / Download PDF"),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
