import 'package:bharat_metal_grid/widget/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/api_constants.dart';
import '../../../widget/commonLoader.dart';
import '../../auth/register/bloc/registerBloc.dart';
import '../../auth/register/bloc/registerEvent.dart';
import '../../auth/register/bloc/registerState.dart';
import '../bloc/directoryBloc.dart';
import '../bloc/directoryEvent.dart';
import '../bloc/directoryState.dart';




/// -------------------- SCREEN --------------------

class DirectoryDetailScreen extends StatefulWidget {
  final String id;


  const DirectoryDetailScreen({super.key,required this.id});

  @override
  State<DirectoryDetailScreen> createState() => _DirectoryDetailScreenState();
}

class _DirectoryDetailScreenState extends State<DirectoryDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DirectoryBloc>().add(FetchDirectoryEvent(context: context,id: widget.id));

  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(  title: "Directory Detail",
        showBackButton: true,
        isHome: false, ),
      body: BlocBuilder<DirectoryBloc,DirectoryState>(
          builder: (context,state) {
            if(state.getDirectoryModel==null){
              return SizedBox(
                  height: height,
                  width: width,
                  child: Center(child: CircularProgressIndicator()));
            }

            final bloc=context.read<RegisterBloc>();
            final user = state.getDirectoryModel!.data!;
            final detail = state.getDirectoryModel!.data!;
            final leadership = detail.leadership ?? [];
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Profile Image
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        "${ApiConstants.baseUrl}${user.profileImage}",
                        height: 110,
                        width: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 55,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Association Name
                  Center(
                    child: Text(
                      user.associationName ?? "Not Available",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// Email
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text("Email"),
                      subtitle: Text(user.email ?? "Not Available"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Mobile
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text("Mobile"),
                      subtitle: Text(user.phoneNumber ?? "Not Available"),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// President Heading
                  const Text(
                    "President",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),

                  const SizedBox(height: 10),

                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Text("Rajesh Kumar"),
                            subtitle: Text("President"),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text("9876543210"),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text("rajesh@gmail.com"),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Members Heading
                  const Text(
                    "Members",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),
                  leadership.isEmpty
                      ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("No Members Found"),
                    ),
                  )
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: leadership.length,
                    itemBuilder: (context, index) {

                      final member = leadership[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: member.profileImg != null &&
                                member.profileImg!.isNotEmpty
                                ? NetworkImage(
                                "${ApiConstants.baseUrl}${member.profileImg}")
                                : null,
                            child: member.profileImg == null
                                ? const Icon(Icons.person)
                                : null,
                          ),

                          title: Text(
                            member.name ?? "N/A",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600),
                          ),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              const SizedBox(height: 5),

                              Text(
                                member.designation ?? "",
                                style: const TextStyle(
                                    color: Colors.blue),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                "Member : ${member.member ?? "N/A"}",
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // ...List.generate(5, (index) {
                  //   return Card(
                  //     margin: const EdgeInsets.only(bottom: 12),
                  //     elevation: 2,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: ListTile(
                  //       leading: CircleAvatar(
                  //         backgroundColor: Colors.blue.shade100,
                  //         child: const Icon(Icons.person),
                  //       ),
                  //       title: Text("Member ${index + 1}"),
                  //       subtitle: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           const SizedBox(height: 5),
                  //           Text("Mobile : 98765432${10 + index}"),
                  //           Text("Email : member${index + 1}@gmail.com"),
                  //         ],
                  //       ),
                  //     ),
                  //   );
                  // }),
                ],
              ),
            );
        }
      ),
    );
  }

  /// -------------------- CARD UI --------------------

}
