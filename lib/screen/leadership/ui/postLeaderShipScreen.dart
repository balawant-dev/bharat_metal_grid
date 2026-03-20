import 'dart:io';
import 'package:bharat_metal_grid/app/router/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widget/customAppbar.dart';
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

  final List<String> designationList = [
    "President",
    "Vice-President",
    "Secretary",
    "Treasurer"
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
    if (nameController.text.isEmpty ||
        selectedDesignation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields required")),
      );
      return;
    }

    context.read<LeaderShipBloc>().add(
      PostLeaderShipSummitedEvent(
        context: context,
        name: nameController.text,
        designation: selectedDesignation!,
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
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                        image: imageFile != null
                            ? DecorationImage(
                          image: FileImage(imageFile!),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                      child: imageFile == null
                          ? const Icon(Icons.camera_alt, size: 40)
                          : null,
                    ),
                  ),

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
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),

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