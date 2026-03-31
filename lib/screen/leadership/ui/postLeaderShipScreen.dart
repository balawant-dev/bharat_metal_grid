import 'dart:io';
import 'package:bharat_metal_grid/app/router/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widget/customAppbar.dart';
import '../../../widget/custom_image_picker.dart';
import '../../../widget/motionToastHelper.dart';
import '../bloc/leaderShipBloc.dart';
import '../bloc/leaderShipEvent.dart';
import '../bloc/leaderShipState.dart';

class PostLeaderShipScreen extends StatefulWidget {
  const PostLeaderShipScreen({super.key});

  @override
  State<PostLeaderShipScreen> createState() =>
      _PostLeaderShipScreenState();
}

class _PostLeaderShipScreenState
    extends State<PostLeaderShipScreen> {
  final TextEditingController nameController = TextEditingController();

  String? selectedDesignation;
  File? imageFile;
  final TextEditingController otherDesignationController = TextEditingController();
  final List<String> designationList = [
    "President",
    "Vice-President",
    "Secretary",
    "Treasurer",
    "Other"
  ];

  Future<void> pickImage() async {
    final picked =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  void submit() {
    if (imageFile == null) {
      ToastHelper.show(
        context,
        message:  "Add profile image",
        type: ToastType.warning,
      );
      return;
    }
    if (nameController.text.isEmpty) {
      ToastHelper.show(
        context,
        message:"Enter name",
        type: ToastType.warning,
      );
      return;
    }

    if (selectedDesignation == null) {
      ToastHelper.show(
        context,
        message: "Select designation",
        type: ToastType.warning,
      );
      return;
    }


    String finalDesignation = selectedDesignation!;

    if (selectedDesignation == "Other") {
      if (otherDesignationController.text.isEmpty) {
        ToastHelper.show(
          context,
          message: "Enter designation",
          type: ToastType.warning,
        );
        return;
      }
      finalDesignation = otherDesignationController.text;
    }

    context.read<LeaderShipBloc>().add(
      PostLeaderShipSummitedEvent(
        context: context,
        name: nameController.text,
        designation: finalDesignation,
        // designation: selectedDesignation!,
        profileImg: imageFile,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Leadership"),
      // appBar: AppBar(title: const Text("Add Leadership")),
      body: BlocListener<LeaderShipBloc, LeaderShipState>(
        listener: (context, state) {

          // ❌ ERROR CASE
          if (!state.isLoading && state.errorMessage != null) {
            ToastHelper.show(
              context,
              message: state.errorMessage!,
              type: ToastType.error,
            );
          }

          // ✅ SUCCESS CASE
          if (!state.isLoading && state.successMessage != null) {
            ToastHelper.show(
              context,
              message: state.successMessage!,
              type: ToastType.success,
            );

            // ✅ GET API HIT
            context.read<LeaderShipBloc>().add(
              FetchLeaderShipEvent(context: context),
            );

            // ✅ POP SCREEN

            context.pushReplacement(Routes.home);
            // ✅ RESET STATE (optional but recommended)
            context.read<LeaderShipBloc>().add(const ResetLeaderShipEvent());
          }
        },
        child: BlocBuilder<LeaderShipBloc, LeaderShipState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // 👇 IMAGE PICKER
                  CustomImagePicker(
                    ratioX: 1,
                    ratioY: 1, // square crop

                    onImageSelected: (file) {
                      imageFile = file;
                    },
                  ),
                  // GestureDetector(
                  //   onTap: pickImage,
                  //   child: Container(
                  //     height: 120,
                  //     width: 120,
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey.shade200,
                  //       shape: BoxShape.circle,
                  //       image: imageFile != null
                  //           ? DecorationImage(
                  //         image: FileImage(imageFile!),
                  //         fit: BoxFit.cover,
                  //       )
                  //           : null,
                  //     ),
                  //     child: imageFile == null
                  //         ? const Icon(Icons.camera_alt, size: 40)
                  //         : null,
                  //   ),
                  // ),

                  const SizedBox(height: 20),

                  // 👇 NAME FIELD
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 👇 DROPDOWN
                  DropdownButtonFormField<String>(
                    value: selectedDesignation,
                    hint: const Text("Select Designation"),
                    items: designationList
                        .map(
                          (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDesignation = value;

                        // reset manual field when not "Other"
                        if (value != "Other") {
                          otherDesignationController.clear();
                        }
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),


                  if (selectedDesignation == "Other") ...[
                    const SizedBox(height: 20),

                    TextField(
                      controller: otherDesignationController,
                      decoration: const InputDecoration(
                        labelText: "Enter Designation",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                  const SizedBox(height: 30),

                  // 👇 BUTTON
                  state.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: submit,
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}