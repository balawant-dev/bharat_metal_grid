

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/color_resource.dart';
import '../../../core/constants/api_constants.dart';
import '../../../widget/customAppbar.dart';
import '../bloc/postBloc.dart';
import '../bloc/postEvent.dart';
import '../bloc/postState.dart';

class PostDetailScreen extends StatefulWidget {
  final String id;
  const PostDetailScreen({super.key, required this.id});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  int currentImageIndex = 0;
  bool isLiked = false;
  bool isDisliked = false;
  int likeCount = 0;
  int dislikeCount = 0;

  @override
  void initState() {
    super.initState();
    context
        .read<PostBloc>()
        .add(FetchPostDetailEvent(context: context, id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Posts Detail"),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state.detailLoading || state.postDetailModel == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final post = state.postDetailModel!.data;
          if (post == null) {
            return const Center(child: Text("Post not found"));
          }

          final images = post.image ?? [];

          // initialize counts once
          likeCount = post.like ?? 0;
          dislikeCount = post.dislike ?? 0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child:Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorResource.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                  // BoxShadow(
                  //   color: Colors.black.withOpacity(0.1),
                  //   blurRadius: 6,
                  //   spreadRadius: 1,
                  //   offset: const Offset(0, 3),
                  // ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🔹 MULTIPLE IMAGE SLIDER
                  if (images.isNotEmpty)
                    Column(
                      children: [
                        SizedBox(
                          height: 250,
                          child: PageView.builder(
                            itemCount: images.length,
                            onPageChanged: (index) {
                              setState(() {
                                currentImageIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  "${ApiConstants.baseUrl}${images[index]}",
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.broken_image,
                                      size: 100),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 8),

                        /// 🔹 Indicator Dots
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            images.length,
                                (index) => Container(
                              margin:
                              const EdgeInsets.symmetric(horizontal: 4),
                              width: currentImageIndex == index ? 12 : 8,
                              height: currentImageIndex == index ? 12 : 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentImageIndex == index
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 16),

                  /// 🔹 TITLE
                  Text(
                    post.title ?? "No Title",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  /// 🔹 DESCRIPTION
                  Text(
                    post.description ?? "No Description",
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 16),

                  /// 🔹 DATE
                  Text(
                    "Posted on: ${formatDate(state.postDetailModel!.data!.createdAt)}",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 24),

                  /// 🔹 LIKE / DISLIKE SECTION
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      /// 👍 LIKE
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.thumb_up,
                              size: 32,
                              color:
                              isLiked ? Colors.blue : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                if (!isLiked) {
                                  likeCount++;
                                  if (isDisliked) {
                                    dislikeCount--;
                                    isDisliked = false;
                                  }
                                  isLiked = true;
                                } else {
                                  likeCount--;
                                  isLiked = false;
                                }
                              });

                              _react(context, post.sId ?? "", "like");
                            },
                          ),
                          Text(likeCount.toString()),
                        ],
                      ),

                      /// 👎 DISLIKE
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.thumb_down,
                              size: 32,
                              color: isDisliked
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                if (!isDisliked) {
                                  dislikeCount++;
                                  if (isLiked) {
                                    likeCount--;
                                    isLiked = false;
                                  }
                                  isDisliked = true;
                                } else {
                                  dislikeCount--;
                                  isDisliked = false;
                                }
                              });

                              _react(context, post.sId ?? "", "dislike");
                            },
                          ),
                          Text(dislikeCount.toString()),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _react(BuildContext context, String postId, String type) {
    if (postId.isEmpty) return;

    context.read<PostBloc>().add(
      ReactToPostEvent(
        context: context,
        postId: postId,
        reactionType: type,
      ),
    );
  }
  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "N/A";

    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
    } catch (e) {
      return date;
    }
  }
}