import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../repo/cmsRepo.dart';

import 'complaint_event.dart';
import 'complaint_state.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  final ComplaintRepo repo=ComplaintRepo();

  ComplaintBloc() : super(const ComplaintState()) {
    on<SubmitComplaintEvent>(_submitComplaint);
  }

  Future<void> _submitComplaint(
      SubmitComplaintEvent event, Emitter<ComplaintState> emit) async {
    String? emailError;
    String? mobileError;
    String? remarkError;

    // 🔴 Validation
    if (event.email.isEmpty) {
      emailError = "Email is required";
    } else if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$')
        .hasMatch(event.email)) {
      emailError = "Enter valid email";
    }

    if (event.mobile.isEmpty) {
      mobileError = "Mobile number is required";
    } else if (event.mobile.length != 10) {
      mobileError = "Enter valid 10 digit number";
    }

    if (event.remark.isEmpty) {
      remarkError = "Remark is required";
    }

    if (emailError != null ||
        mobileError != null ||
        remarkError != null) {
      emit(state.copyWith(
        emailError: emailError,
        mobileError: mobileError,
        remarkError: remarkError,
      ));
      return;
    }

    emit(state.copyWith(
      isLoading: true,
      emailError: null,
      mobileError: null,
      remarkError: null,
    ));

    try {
      await repo.createComplaintApi(
        context: event.context,
        email: event.email,
        mobileNumber: event.mobile,
        remark: event.remark,
      );

      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
      ));
    } on DioException catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.message ?? "Something went wrong",
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}