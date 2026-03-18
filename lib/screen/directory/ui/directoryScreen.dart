// import 'package:bharat_metal_grid/widget/customAppbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../core/constants/api_constants.dart';
// import '../../../widget/commonLoader.dart';
// import '../../auth/register/bloc/registerBloc.dart';
// import '../../auth/register/bloc/registerEvent.dart';
// import '../../auth/register/bloc/registerState.dart';
//
//
//
//
// /// -------------------- SCREEN --------------------
//
// class DirectoryScreen extends StatefulWidget {
//
//
//   const DirectoryScreen({super.key});
//
//   @override
//   State<DirectoryScreen> createState() => _DirectoryScreenState();
// }
//
// class _DirectoryScreenState extends State<DirectoryScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<RegisterBloc>().add(AllAssociationEvent(context: context));
//
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: CustomAppBar(  title: "Directory",
//         showBackButton: true,
//         isHome: true, ),
//       body: BlocBuilder<RegisterBloc,RegisterState>(
//           builder: (context,state) {
//             if(state.getAllAssociationModel==null){
//               return SizedBox(
//                   height: height,
//                   width: width,
//                   child: Center(child: CircularProgressIndicator()));
//             }
//
//             final bloc=context.read<RegisterBloc>();
//             return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: state.getAllAssociationModel!.data!.length,
//             itemBuilder: (context, index) {
//               final user = state.getAllAssociationModel!.data![index];
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 16),
//                 padding: const EdgeInsets.all(14),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.shade300,
//                       blurRadius: 8,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//
//                     /// Profile Image
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(40), // circle effect
//                       child: Image.network(
//                         "${ApiConstants.baseUrl}${user.profileImage}",
//                         height: 64,
//                         width: 64,
//                         fit: BoxFit.cover,
//
//                         /// Loading Placeholder
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return Container(
//                             height: 64,
//                             width: 64,
//                             alignment: Alignment.center,
//                             child: const CircularProgressIndicator(strokeWidth: 2),
//                           );
//                         },
//
//                         /// Error Builder
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             height: 64,
//                             width: 64,
//                             color: Colors.grey.shade200,
//                             alignment: Alignment.center,
//                             child: const Icon(
//                               Icons.person,
//                               size: 30,
//                               color: Colors.grey,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//
//                     const SizedBox(width: 16),
//
//                     /// User Details
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//
//                           /// Name
//                           Text(
//                             user.associationName??"Not Available",
//                             style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black
//                             ),
//                           ),
//
//                           const SizedBox(height: 6),
//
//                           /// Mobile
//                           Row(
//                             children: [
//                               const Icon(Icons.phone, size: 16, color: Colors.grey),
//                               const SizedBox(width: 6),
//                               Text(
//                                 user.phoneNumber??"Not Available",
//                                 style: const TextStyle(color: Colors.grey),
//                               ),
//                             ],
//                           ),
//
//                           const SizedBox(height: 4),
//
//                           /// Email
//                           Row(
//                             children: [
//                               const Icon(Icons.email, size: 16, color: Colors.grey),
//                               const SizedBox(width: 6),
//                               Expanded(
//                                 child: Text(
//                                   user.email??"Not Available",
//                                   style: const TextStyle(color: Colors.grey),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         }
//       ),
//     );
//   }
//
//   /// -------------------- CARD UI --------------------
//
// }



import 'package:bharat_metal_grid/widget/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/api_constants.dart';
import '../../auth/register/bloc/registerBloc.dart';
import '../../auth/register/bloc/registerEvent.dart';
import '../../auth/register/bloc/registerState.dart';

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({super.key});

  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {

  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredList = [];

  @override
  void initState() {
    super.initState();
    context.read<RegisterBloc>().add(AllAssociationEvent(context: context));
  }

  void _filterList(List<dynamic> originalList, String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredList = originalList;
      });
    } else {
      setState(() {
        _filteredList = originalList.where((user) {
          final name = user.associationName?.toLowerCase() ?? "";
          final email = user.email?.toLowerCase() ?? "";
          final phone = user.phoneNumber?.toLowerCase() ?? "";
          return name.contains(query.toLowerCase()) ||
              email.contains(query.toLowerCase()) ||
              phone.contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  Future<void> _makeCall(String phone) async {
    final Uri url = Uri.parse("tel:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri url = Uri.parse("mailto:$email");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(
        title: "Directory",
        showBackButton: true,
        isHome: true,
      ),
      body: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {

          if (state.getAllAssociationModel == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final originalList = state.getAllAssociationModel!.data!;
          _filteredList = _filteredList.isEmpty ? originalList : _filteredList;

          return Column(
            children: [

              /// 🔍 Search Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    _filterList(originalList, value);
                  },
                  decoration: InputDecoration(
                    hintText: "Search by name, email, phone...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              /// 📋 List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filteredList.length,
                  itemBuilder: (context, index) {
                    final user = _filteredList[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [

                          /// Profile Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.network(
                              "${ApiConstants.baseUrl}${user.profileImage}",
                              height: 64,
                              width: 64,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 64,
                                  width: 64,
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.person),
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 16),

                          /// Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  user.associationName ?? "Not Available",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black
                                  ),
                                ),

                                const SizedBox(height: 6),

                                /// Phone
                                GestureDetector(
                                  onTap: () {
                                    if (user.phoneNumber != null) {
                                      _makeCall(user.phoneNumber!);
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.phone,
                                          size: 16, color: Colors.black),
                                      const SizedBox(width: 6),
                                      Text(
                                        user.phoneNumber ?? "Not Available",
                                        style: const TextStyle(
                                          color: Colors.black,
                                       //   decoration:
                                      //    TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 4),

                                /// Email
                                GestureDetector(
                                  onTap: () {
                                    if (user.email != null) {
                                      _sendEmail(user.email!);
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.email,
                                          size: 16, color: Colors.black),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          user.email ?? "Not Available",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            // decoration:
                                            // TextDecoration.underline,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}