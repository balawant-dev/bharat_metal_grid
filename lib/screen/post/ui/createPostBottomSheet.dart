import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widget/custom_image_picker.dart';
import '../bloc/postBloc.dart';
import '../bloc/postEvent.dart';
import '../bloc/postState.dart';
class CreatePostBottomSheet extends StatefulWidget {
  const CreatePostBottomSheet({super.key});

  @override
  State<CreatePostBottomSheet> createState() => _CreatePostBottomSheetState();
}

class _CreatePostBottomSheetState extends State<CreatePostBottomSheet> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        if (state.createSuccess) {
          context.pop();
          // Navigator.pop(context);
          _clearFields();
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Create New Post", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.black)),              const SizedBox(height: 10),
              const Text("Banner Image", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black)),
              const SizedBox(height: 5),
              CustomImagePicker(
                shape: ImageShape.rectangle,
                width: double.infinity,
                height: 160,
                ratioX: 16,
                ratioY: 9,
                onImageSelected: (file) {
                  _selectedImage = file;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                onChanged: (_) {
                  context.read<PostBloc>().add(ClearPostMessageEvent());
                },
                decoration: const InputDecoration(labelText: "Title", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descController,
                maxLines: 4,
                onChanged: (_) {
                  context.read<PostBloc>().add(ClearPostMessageEvent());
                },
                decoration: const InputDecoration(labelText: "Description", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              // if (_selectedImage != null)
              //   Image.file(_selectedImage!, height: 120, fit: BoxFit.cover),
              // const SizedBox(height: 8),
              // OutlinedButton.icon(
              //   onPressed: () async {
              //     final picker = ImagePicker();
              //     final picked = await picker.pickImage(source: ImageSource.gallery);
              //     if (picked != null) {
              //       setState(() => _selectedImage = File(picked.path));
              //       context.read<PostBloc>().add(ClearPostMessageEvent());
              //     }
              //     // if (picked != null) setState(() => _selectedImage = File(picked.path));
              //   },
              //   icon: const Icon(Icons.image),
              //   label: const Text("Pick Image"),
              // ),
              const SizedBox(height: 16),
              if (state.displayMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: Text(
                      state.displayMessage!,
                      key: ValueKey(state.displayMessage),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: state.messageColor ?? Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                "Note: All fields are mandatory, including title, description, and banner image.",
                style: TextStyle(
                  color: Color(0xFFFF0000), // Pure Red
                  fontSize: 12,
                  fontWeight: FontWeight.w400,fontStyle: FontStyle.italic,

                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: state.isCreating
                    ? null
                    : () {
                  context.read<PostBloc>().add(
                    CreatePostEvent(
                      context: context,
                      title: _titleController.text.trim(),
                      description: _descController.text.trim(),
                      imageFile: _selectedImage,
                    ),
                  );
                  // context.pop();
                },
                child: state.isCreating
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text("Create Post"),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void _clearFields() {
    _titleController.clear();
    _descController.clear();
    setState(() => _selectedImage = null);
  }
}