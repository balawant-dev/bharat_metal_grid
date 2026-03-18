import 'package:bharat_metal_grid/screen/post/bloc/postEvent.dart';
import 'package:bharat_metal_grid/screen/post/bloc/postState.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


import '../repo/postRepo.dart';


class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepo _repo;

  PostBloc({required PostRepo repo})
      : _repo = repo,
        super(const PostState()) {
    on<ResetPostEvent>(_onReset);
    on<FetchPostsEvent>(_onFetchPosts);
    on<FetchPostDetailEvent>(_onFetchPostDetail);
    on<CreatePostEvent>(_onCreatePost);
    on<ReactToPostEvent>(_onReactToPost);
    on<MembershipAssignmentEvent>(_onFetchMembershipAssignment);
    on<CreateOrderEvent>(_onCreateOrder);
  }

  Future<void> _onCreateOrder(
      CreateOrderEvent event,
      Emitter<PostState> emit,
      ) async {
    emit(state.copyWith(isCreating: true, createError: null, createSuccess: false));

    try {
      final response = await _repo.createOrderApi(
        context: event.context,
        membershipPlanID: event.membershipPlanID,

      );

      if (response.success == true) {
        print("Sab Kuchh done dsfadfsd 🤦‍♀️🤦‍♀️🤦‍♀️🤦‍♀️");
        emit(state.copyWith(
          isCreating: false,
          createSuccess: true,
          createMessage: "Order created successfully",
        ));
        // Auto refresh list
        // add(FetchPostsEvent(context: event.context));
      } else {
        emit(state.copyWith(
          isCreating: false,
          createError: "Failed to create order",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isCreating: false,
        createError: e.toString(),
      ));
    }
  }
  Future<void> _onReset(
      ResetPostEvent event,
      Emitter<PostState> emit,
      ) async {
    emit(const PostState());
  }

  Future<void> _onFetchPosts(
      FetchPostsEvent event,
      Emitter<PostState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final response = await _repo.getPostApi(context: event.context);

      if (response.success == true && response.data != null) {
        print("✔✔✔✔🙌🙌🙌🙌🙌🙌🙌");
        emit(state.copyWith(
          isLoading: false,
          getPostModel: response,
          // posts: response, // ← assuming you change model to List<Data>
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: "Failed to load posts",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }  Future<void> _onFetchMembershipAssignment(
      MembershipAssignmentEvent event,
      Emitter<PostState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final response = await _repo.getMembershipAssignmentApi(context: event.context);

      if (response.success == true && response.data != null) {
        print("✔✔✔✔🙌🙌🙌🙌🙌🙌🙌😎😎");
        emit(state.copyWith(
          isLoading: false,
          membershipAssignmentModel: response,
          // posts: response, // ← assuming you change model to List<Data>
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: "Failed to load posts getMembershipAssignmentApi",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onFetchPostDetail(
      FetchPostDetailEvent event,
      Emitter<PostState> emit,
      ) async {
    emit(state.copyWith(detailLoading: true, errorMessage: null));

    try {
      final response = await _repo.getPostDetailApi(
        context: event.context,
        id: event.id,
      );

      if (response.success == true) {
        print("✅ DETAIL API SUCCESS");

        emit(state.copyWith(
          detailLoading: false,
          postDetailModel: response, // ✅ CORRECT FIELD NAME
        ));
        print("✅ DETAIL API SUCCESS2");
      } else {
        emit(state.copyWith(
          detailLoading: false,
          errorMessage: "Failed to load post detail",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        detailLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onCreatePost(
      CreatePostEvent event,
      Emitter<PostState> emit,
      ) async {
    emit(state.copyWith(isCreating: true, createError: null, createSuccess: false));

    try {
      final response = await _repo.createPost(
        context: event.context,
        title: event.title,
        description: event.description,
        profileImage: event.imageFile!,
      );

      if (response.success == true) {
        print("Sab Kuchh done hai 🤦‍♀️🤦‍♀️🤦‍♀️🤦‍♀️");
        emit(state.copyWith(
          isCreating: false,
          createSuccess: true,
          createMessage: "Post created successfully",
        ));
        // Auto refresh list
        add(FetchPostsEvent(context: event.context));
      } else {
        emit(state.copyWith(
          isCreating: false,
          createError: "Failed to create post",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isCreating: false,
        createError: e.toString(),
      ));
    }
  }

  Future<void> _onReactToPost(
      ReactToPostEvent event,
      Emitter<PostState> emit,
      ) async {
    try {
      final response = await _repo.postReactionApi(
        context: event.context,
        id: event.postId,
        type: event.reactionType, // "like", "dislike", etc.
      );

      if (response.success == true) {
        // You can either refresh whole list or update only selected post
        if (state.postDetailModel != null && state.postDetailModel!.data!.sId == event.postId) {
          // optimistic or refresh detail
          add(FetchPostDetailEvent(context: event.context, id: event.postId));
        } else {
          add(FetchPostsEvent(context: event.context));
        }
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: "Reaction failed: $e"));
    }
  }
}