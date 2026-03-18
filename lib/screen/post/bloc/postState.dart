import 'package:equatable/equatable.dart';
import '../model/createOrderModel.dart';
import '../model/getPostModel.dart';
import '../model/membershipAssignmentModel.dart';
import '../model/postDetailModel.dart';

class PostState extends Equatable {
  final bool isLoading;
  final bool detailLoading;
  final bool isCreating;
  final bool createSuccess;
  final String? createMessage;
  final String? createError;
  final String? errorMessage;

  final GetPostModel? getPostModel;
  final PostDetailModel? postDetailModel;
  final MembershipAssignmentModel? membershipAssignmentModel;
  final CreateOrderModel? createOrderModel;

  const PostState({
    this.isLoading = false,
    this.detailLoading = false,
    this.isCreating = false,
    this.createSuccess = false,
    this.createMessage,
    this.createError,
    this.errorMessage,
    this.getPostModel,
    this.postDetailModel,
    this.membershipAssignmentModel,
    this.createOrderModel,
  });

  PostState copyWith({
    bool? isLoading,
    bool? detailLoading,
    bool? isCreating,
    bool? createSuccess,
    String? createMessage,
    String? createError,
    String? errorMessage,
    GetPostModel? getPostModel,
    MembershipAssignmentModel? membershipAssignmentModel,
    PostDetailModel? postDetailModel,
    CreateOrderModel? createOrderModel,
  }) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      detailLoading: detailLoading ?? this.detailLoading,
      isCreating: isCreating ?? this.isCreating,
      createSuccess: createSuccess ?? this.createSuccess,
      createMessage: createMessage ?? this.createMessage,
      createError: createError ?? this.createError,
      errorMessage: errorMessage ?? this.errorMessage,
      getPostModel: getPostModel ?? this.getPostModel,
      postDetailModel: postDetailModel ?? this.postDetailModel,
      membershipAssignmentModel: membershipAssignmentModel ?? this.membershipAssignmentModel,
      createOrderModel: createOrderModel ?? this.createOrderModel,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    detailLoading,
    isCreating,
    createSuccess,
    createMessage,
    createError,
    errorMessage,
    getPostModel,
    postDetailModel,
  ];
}