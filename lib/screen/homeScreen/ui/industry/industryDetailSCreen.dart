import 'package:bharat_metal_grid/screen/homeScreen/bloc/homeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../widget/commonLoader.dart';
import '../../../../widget/customAppbar.dart';
import '../../bloc/homeBloc.dart';
import '../../bloc/homeEvent.dart';
import '../component/latestNoticesSection.dart';
class IndustryDetailScreen extends StatefulWidget {
  final String id;
  const IndustryDetailScreen({super.key, required this.id});

  @override
  State<IndustryDetailScreen> createState() => _IndustryDetailScreenState();
}

class _IndustryDetailScreenState extends State<IndustryDetailScreen> {

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(
      FetchIndustryNewsDetailEvent(
        context: context,
        id: widget.id,
      ),
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
          if (state.industryNewsDetailModel == null ||
              state.industryNewsDetailModel!.data == null) {
            return SizedBox(
                height: height,
                width: width,
                child: Center(child: const AppMetalLoader()));;
          }

          final data = state.industryNewsDetailModel!.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// 🔹 Cover Image
                // Container(
                //   height: 220,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: NetworkImage(
                //         "${ApiConstants.baseUrl}${data.coverImage}",
                //       ),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),

                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "${ApiConstants.baseUrl}${data.coverImage}",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
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

                const SizedBox(height: 16),

                /// 🔹 Content Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Title
                      Text(
                        data.title ?? "",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 8),

                      /// Read time & Date
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            data.readTime ?? "2 min read",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
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

                      /// Short Description (Highlighted)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          data.shortDescription ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Full Content
                      Text(
                        data.content ?? "",
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
