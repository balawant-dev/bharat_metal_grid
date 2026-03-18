import 'package:bharat_metal_grid/screen/post/ui/postDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/navigation/routes.dart';
import '../../../app/theme/color_resource.dart';
import '../../../core/constants/api_constants.dart';
import '../../../widget/customAppbar.dart';
import '../bloc/postBloc.dart';
import '../bloc/postEvent.dart';
import '../bloc/postState.dart';
import '../repo/postRepo.dart';
import 'createPostBottomSheet.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  bool isLiked = false;
  bool isDisliked = false;
  int likeCount = 0;
  int dislikeCount = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      PostBloc(repo: PostRepo())..add(FetchPostsEvent(context: context)),
      child: Scaffold(
        appBar: CustomAppBar(title: "Posts"),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showCreatePostBottomSheet(context),
          child: const Icon(Icons.add),
        ),
        body: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            if (state.createSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Post created successfully!")),
              );
            }

            // if (state.errorMessage != null &&
            //     state.errorMessage!.isNotEmpty) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text(state.errorMessage!)),
            //   );
            // }
          },
          builder: (context, state) {
            /// 🔹 Loading State
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            /// 🔹 Safe Data Extraction
            final posts = state.getPostModel?.data ?? [];

            /// 🔹 Empty State
            if (posts.isEmpty) {
              return const Center(
                child: Text(
                  "No posts yet",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            /// 🔹 List View
            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<PostBloc>()
                    .add(FetchPostsEvent(context: context));
              },
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];

                  return GestureDetector(
                    onTap: () {
                      if (post.sId != null && post.sId!.isNotEmpty) {
                        context.read<PostBloc>().add(
                          FetchPostDetailEvent(
                            context: context,
                            id: post.sId!,
                          ),
                        );

                        context.push(Routes.postDetail, extra: post.sId);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: ColorResource.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// 🔹 PROFILE ROW
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.grey.shade300,
                                child: Text(
                                  post.postedBy?.name != null &&
                                      post.postedBy!.name!.isNotEmpty
                                      ? post.postedBy!.name![0].toUpperCase()
                                      : "U",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              const SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post.postedBy?.name ?? "No Name",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,color: Colors.black
                                      ),
                                    ),
                                    Text(
                                      post.userType ?? "",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          /// 🔹 TITLE
                          if (post.title != null && post.title!.isNotEmpty)
                            Text(
                              post.title!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54
                              ),
                            ),

                          const SizedBox(height: 8),

                          /// 🔹 IMAGE
                          if (post.image != null && post.image!.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                "${ApiConstants.baseUrl}${post.image!.first}",
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                const Icon(Icons.broken_image, size: 100),
                              ),
                            ),

                          const SizedBox(height: 8),

                          /// 🔹 DESCRIPTION (4 Lines)
                          if (post.description != null && post.description!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.description!,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14),
                                ),

                                /// 🔹 SEE ALL BUTTON
                                if (post.description!.length > 100)
                                  GestureDetector(
                                    onTap: () {
                                      if (post.sId != null &&
                                          post.sId!.isNotEmpty) {
                                        context.read<PostBloc>().add(
                                          FetchPostDetailEvent(
                                            context: context,
                                            id: post.sId!,
                                          ),
                                        );

                                        context.push(Routes.postDetail,
                                            extra: post.sId);
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Text(
                                        "See All",
                                        style: TextStyle(
                                          color: ColorResource.primaryColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12
                                        ),
                                      ),
                                    ),
                                  ),

                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //   children: [
                                //     Row(
                                //       children: [
                                //         Text(post.dislike.toString()),  IconButton(
                                //           icon: Icon(
                                //             Icons.thumb_up,
                                //             size: 22,
                                //             color:
                                //             isLiked ? Colors.blue : Colors.grey,
                                //           ),
                                //           onPressed: () {
                                //             setState(() {
                                //               if (!isLiked) {
                                //                 likeCount++;
                                //                 if (isDisliked) {
                                //                   dislikeCount--;
                                //                   isDisliked = false;
                                //                 }
                                //                 isLiked = true;
                                //               } else {
                                //                 likeCount--;
                                //                 isLiked = false;
                                //               }
                                //             });
                                //
                                //             _react(context, post.sId ?? "", "like");
                                //           },
                                //         ),
                                //       ],
                                //     ),
                                //
                                //     /// 👍 LIKE
                                //
                                //
                                //
                                //     /// 👎 DISLIKE
                                //     Row(
                                //       children: [
                                //         Text(post.dislike.toString()),
                                //         IconButton(
                                //           icon: Icon(
                                //             Icons.thumb_down,
                                //             size: 22,
                                //             color: isDisliked
                                //                 ? Colors.red
                                //                 : Colors.grey,
                                //           ),
                                //           onPressed: () {
                                //             setState(() {
                                //               if (!isDisliked) {
                                //                 dislikeCount++;
                                //                 if (isLiked) {
                                //                   likeCount--;
                                //                   isLiked = false;
                                //                 }
                                //                 isDisliked = true;
                                //               } else {
                                //                 dislikeCount--;
                                //                 isDisliked = false;
                                //               }
                                //             });
                                //
                                //             _react(context, post.sId ?? "", "dislike");
                                //           },
                                //         ),
                                //       ],
                                //     ),
                                //
                                //
                                //   ],
                                // ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),

            );
          },
        ),
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
  void _showCreatePostBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
        BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<PostBloc>(),
        child: const CreatePostBottomSheet(),
      ),
    );
  }
}