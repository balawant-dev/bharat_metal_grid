import 'package:bharat_metal_grid/app/router/navigation/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

import '../../../app/theme/color_resource.dart'; // primaryColor = Color(0xFF1135A4)
import '../bloc/gemini_bloc.dart';
import '../bloc/gemini_event.dart';
import '../bloc/gemini_state.dart';

class GeminiAiScreen extends StatefulWidget {
  const GeminiAiScreen({super.key});

  @override
  State<GeminiAiScreen> createState() => _GeminiAiScreenState();
}

class _GeminiAiScreenState extends State<GeminiAiScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  Future<void> _confirmClearChat() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Clear Conversation",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
        ),
        content: const Text(
          "This will delete the entire chat history. Are you sure?",
          style: TextStyle(color: Colors.black54),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel", style: TextStyle(color: Colors.black54)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              "Clear",
              style: TextStyle(color: ColorResource.primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      context.read<GeminiBloc>().add(ClearChatEvent());
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     // extendBodyBehindAppBar: true,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(68),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2D5FC0),
                    Color(0xFF062E7E),
                  ],
                ),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
                border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.12))),
              ),
              child: SafeArea(
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: GestureDetector(
                    onTap: (){
                      Nav.pop(context);
                    },
                      child: Icon(Icons.arrow_back_ios, color: ColorResource.white,)),
                  centerTitle: true,
                  title: const Text(
                    "AI Agent",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 26),
                      tooltip: 'Clear Chat',
                      onPressed: _confirmClearChat,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      body: BlocConsumer<GeminiBloc, GeminiState>(
        listener: (context, state) {
          if (state.messages.isNotEmpty) _scrollToBottom();
        },
        builder: (context, state) {
          return Padding(
     padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                Expanded(
                  child: state.messages.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          size: 70,
                          color: ColorResource.primaryColor.withOpacity(0.9),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Talk to AI Agent",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Ask anything – quick facts to deep ideas",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                      : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final msg = state.messages[index];
                      final isUser = msg["role"] == "user";
                      return Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.78,
                          ),
                          child: isUser
                              ? _userMessage(msg["content"] ?? "")
                              : _botMessage(msg["content"] ?? ""),
                        ),
                      );
                    },
                  ),
                ),

                if (state.isLoading)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Gemini is thinking...",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation(ColorResource.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),

                _buildInputArea(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _userMessage(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorResource.primaryColor,
            const Color(0xFF0F2A8A),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(1),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorResource.primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          height: 1.45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _botMessage(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9), // light gray-blueish white
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
          bottomLeft: Radius.circular(1),
          bottomRight: Radius.circular(24),
        ),
        border: Border.all(
          color: ColorResource.primaryColor.withOpacity(0.25),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SelectableText(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 15.8,
          height: 1.48,
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
              color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(28),
                  // border: Border.all(
                  //   color: ColorResource.primaryColor.withOpacity(0.3),
                  //   width: 1.4,
                  // ),
                ),
                child: TextFormField(
                  controller: _controller,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16.2,
                  ),
                  maxLines: 5,
                  minLines: 1,
                  cursorColor: ColorResource.primaryColor,
                  decoration: InputDecoration(
                    hintText: "Message Gemini...",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 8, top: 4),
                      child: Icon(
                        Icons.auto_awesome_outlined,
                        color: ColorResource.primaryColor,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorResource.primaryColor,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2D5FC0),
                    Color(0xFF062E7E),
                  ],
                ),
              ),
              child: IconButton(
                padding: const EdgeInsets.all(14),
                icon: const Icon(Icons.send_rounded, color: Colors.white, size: 26),
                onPressed: () {
                  final text = _controller.text.trim();
                  if (text.isEmpty) return;

                  context.read<GeminiBloc>().add(SendMessageEvent(text));
                  _controller.clear();
                  _scrollToBottom();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}