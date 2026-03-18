import 'dart:async';
import 'dart:io';
import 'package:bharat_metal_grid/widget/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:dropdown_search/dropdown_search.dart';

import '../../../../app/router/navigation/nav.dart';
import '../../../../app/router/navigation/routes.dart';
import '../../../../app/theme/color_resource.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../widget/commonLoader.dart';
import '../../../../widget/customAppbar.dart';
import '../../../../widget/customTextField.dart';
import '../../auth/register/bloc/registerBloc.dart';
import '../../auth/register/bloc/registerState.dart';
import '../../settings/appSettings/appSettings.dart';
import '../bloc/profileBloc.dart';
import '../bloc/profileEvent.dart';
import '../bloc/profileState.dart';



class ProfileMemberScreen extends StatefulWidget {


  const ProfileMemberScreen({super.key});
  @override
  State<ProfileMemberScreen> createState() => _ProfileMemberScreenState();
}

class _ProfileMemberScreenState extends State<ProfileMemberScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String? selectedGender;
  String? selectedState;
  String? selectedLanguage;

  // Controllers for Organization Details
  final orgTypeController = TextEditingController();
  final orgNameController = TextEditingController();
  final parentOrgController = TextEditingController();
  final postalAddressController = TextEditingController();
  final dateIncorporationController = TextEditingController();
  final orgContactController = TextEditingController();
  final orgEmailController = TextEditingController();
  final natureOrgController = TextEditingController();
  final panController = TextEditingController();
  final gstController = TextEditingController();
  final designation = TextEditingController();





  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfileMemberEvent(context: context));

  }

  final List<String> selectedAssociations = [];
  final List<String> selectedAssociationNames = [];

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  /// 📸 Pick Image
  Future<void> pickImage(ImageSource source) async {
    final XFile? picked =
    await _picker.pickImage(source: source, imageQuality: 80);

    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }
  void showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  String dateIncorporationApi = "";


  Future<void> pickDate({
    required TextEditingController controller,
    required Function(String apiDate) onApiDate,
  }) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      // UI → dd/MM/yyyy
      String uiDate =
          "${pickedDate.day.toString().padLeft(2, '0')}/"
          "${pickedDate.month.toString().padLeft(2, '0')}/"
          "${pickedDate.year}";

      // API → yyyy-MM-dd
      String apiDate =
          "${pickedDate.year}-"
          "${pickedDate.month.toString().padLeft(2, '0')}-"
          "${pickedDate.day.toString().padLeft(2, '0')}";

      setState(() {
        controller.text = uiDate;
      });

      onApiDate(apiDate);
    }
  }
  @override
  void dispose() {
    // Dispose all controllers
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    orgTypeController.dispose();
    orgNameController.dispose();
    parentOrgController.dispose();
    postalAddressController.dispose();
    dateIncorporationController.dispose();
    orgContactController.dispose();
    orgEmailController.dispose();
    natureOrgController.dispose();
    panController.dispose();
    gstController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: "Member Profile",showBackButton: true,),
      body: BlocConsumer<ProfileBloc,ProfileState>(
          listener: (context, state) {
            if (state is ProfileState) {
              final  data = state.getProfileMemberModel!.data!;

              /// BASIC DETAILS
              nameController.text = data.fullName ?? "";
              emailController.text = data.email ?? "";
              phoneController.text = data.phoneNumber ?? "";
              selectedGender = data.gender;
              selectedState = data.state;
              selectedLanguage = data.preferredLanguage;

              /// PROFILE IMAGE (API)
              // if (data.profileImage != null && data.profileImage!.isNotEmpty) {
              //   selectedImage = File("${ApiConstants.baseUrl}${data.profileImage}");
              // }

              /// ORGANIZATION DETAILS
              if (data.organization != null) {
                final org = data.organization!;

                orgTypeController.text = org.type ?? "";
                orgNameController.text = org.name ?? "";
                parentOrgController.text = org.parentOrganizationName ?? "";
                postalAddressController.text = org.postalAddress ?? "";
                orgEmailController.text = org.emailId ?? "";
                natureOrgController.text = org.natureOfOrganization ?? "";
                panController.text = org.panNumber ?? "";
                gstController.text = org.gstNumber ?? "";

                /// DATE
                // if (org.dateOfIncorporation != null) {
                //   dateIncorporationApi = org.dateOfIncorporation!;
                //   dateIncorporationController.text =
                //       formatUiDate(org.dateOfIncorporation!);
                // }

                /// ASSOCIATIONS (IDs)
                selectedAssociations.clear();
                selectedAssociationNames.clear();


              }

              setState(() {});
            }
          },

          builder: (context,state) {
          if(state.getProfileMemberModel==null){
            return SizedBox(
              height: height,
                width: width,
                child: Center(child: const AppMetalLoader(
                  text: "Loading profile data...",
                )));
          }

          final bloc=context.read<RegisterBloc>();
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
              GestureDetector(
              onTap: showImagePicker,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: selectedImage != null
                          ? Image.file(
                        selectedImage!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                          : Image.network(
                        "${ApiConstants.baseUrl}${AppSettings.userProfileImage}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/icon/profileAvatar.png",
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),

                  // CircleAvatar(
                  //   backgroundColor: ColorResource.white,
                  //   radius: 50,
                  //   backgroundImage: selectedImage != null
                  //       ? FileImage(selectedImage!)
                  //       : const AssetImage("assets/icon/profileAvatar.png") as ImageProvider,
                  // ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: ColorResource.primaryColor,
                      child: const Icon(Icons.edit, size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Basic Details Section
                decorationContainer(
                  width: width,
              child: ExpansionTile(
                dense: true,
                shape: const RoundedRectangleBorder(
                  side: BorderSide.none,
                ),
                collapsedShape: const RoundedRectangleBorder(
                  side: BorderSide.none,
                ),

                initiallyExpanded: true,
                title: const Text("Basic Details", style: TextStyle(    color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,)),
                children: [
                  CommonTextFormField(controller: nameController, hintText: "Full name"),
                  const SizedBox(height: 16),

                  // Gender
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint:  Text("Gender",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black.withOpacity(0.85))),
                        value: selectedGender,
                        items: ["Male", "Female", "Others"]
                            .map((e) => DropdownMenuItem(value: e, child: Text(e,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black))))
                            .toList(),
                        onChanged: (val) => setState(() => selectedGender = val),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),


                  const SizedBox(height: 16),

                  CommonTextFormField(
                    controller: emailController,
                    hintText: "Email ID",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),


                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint:  Text("Select State",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black.withOpacity(0.85))),
                        value: selectedState,
                        items: indianStates
                            .map((e) => DropdownMenuItem(value: e, child: Text(e,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black))))
                            .toList(),
                        onChanged: (val) => setState(() => selectedState = val),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Preferred Language
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint:  Text("Select Preferred Language",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black.withOpacity(0.85))),
                        value: selectedLanguage,
                        items: ["English", "Hindi", "Tamil", "Telugu", "Others"]
                            .map((e) => DropdownMenuItem(value: e, child: Text(e,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black))))
                            .toList(),
                        onChanged: (val) => setState(() => selectedLanguage = val),
                      ),
                    ),
                  ),
                //  const SizedBox(height: 24),

                  // CommonAppButton(
                  //   text: "Submit",
                  //   onPressed: () {
                  //     // Just expand Organization Details
                  //     // You can add validation here later
                  //   },
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 30),


            decorationContainer(
              width: width,
              child: ExpansionTile(

                shape: const RoundedRectangleBorder(
                  side: BorderSide.none,
                ),
                collapsedShape: const RoundedRectangleBorder(
                  side: BorderSide.none,
                ),
                title: const Text("Organization Details", style: TextStyle(    color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,)),
                children: [
                  // Type
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint:  Text("Type",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black.withOpacity(0.85)),),
                        value: orgTypeController.text.isEmpty ? null : orgTypeController.text,
                        items: ["Company", "Firm", "Proprietorship", "Others"]
                            .map((e) => DropdownMenuItem(value: e, child: Text(e,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black))))
                            .toList(),
                        onChanged: (val) => setState(() => orgTypeController.text = val ?? ""),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  CommonTextFormField(controller: designation, hintText: "Designation"),
                  const SizedBox(height: 16),         CommonTextFormField(controller: orgNameController, hintText: "Name"),
                  const SizedBox(height: 16),
                  CommonTextFormField(controller: parentOrgController, hintText: "Parent Organization Name"),
                  const SizedBox(height: 16),
                  CommonTextFormField(controller: postalAddressController, hintText: "Postal Address"),
                  const SizedBox(height: 16),
                  CommonTextFormField(  suffixIcon: Icon(Icons.calendar_month,color: Colors.grey.shade500,),controller: dateIncorporationController, hintText: "Date of Incorporation", onTap: () {
                    pickDate(
                      controller: dateIncorporationController,
                      onApiDate: (val) => dateIncorporationApi = val,
                    );
                  },),
                  const SizedBox(height: 16),
                  CommonTextFormField(controller: orgContactController, hintText: "Contact Number", keyboardType: TextInputType.phone,maxLength: 10,),
                  const SizedBox(height: 16),
                  CommonTextFormField(controller: orgEmailController, hintText: "Email ID", keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 16),
                  CommonTextFormField(controller: natureOrgController, hintText: "Nature of Organization"),
                  const SizedBox(height: 16),
                  CommonTextFormField(controller: panController, hintText: "PAN Number"),
                  const SizedBox(height: 16),
                  CommonTextFormField(controller: gstController, hintText: "GST Number"),
                  const SizedBox(height: 24),



                  // Select Associations (Checkboxes)
                  Row(
                    children: [
                      const Text("Select Association", style: TextStyle(    color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,)),
                    ],
                  ),
                  const SizedBox(height: 8),

                  if (selectedAssociationNames.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: selectedAssociationNames.map((name) {
                          return Chip(
                            label: Text(name),
                            deleteIcon: const Icon(Icons.close, size: 18),
                            onDeleted: () {
                              setState(() {
                                int index = selectedAssociationNames.indexOf(name);
                                selectedAssociationNames.removeAt(index);
                                selectedAssociations.removeAt(index);
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),




                  // if(state.getAllAssociationModel!=null||state.getAllAssociationModel!.data!.isNotEmpty)...[
                  //   ...state.getAllAssociationModel!.data!.map((assoc) => CheckboxListTile(
                  //     title: Text(assoc.associationName ?? "N/A",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black)),
                  //
                  //     value: selectedAssociations.contains(assoc.sId),
                  //     onChanged: (val) {
                  //       setState(() {
                  //         if (val == true) {
                  //           selectedAssociations.add(assoc.sId??"Not Store...");
                  //         } else {
                  //           selectedAssociations.remove(assoc.sId);
                  //         }
                  //       });
                  //     },
                  //   )),
                  // ],

                  const SizedBox(height: 30),

                  SizedBox(height: 20),

                  // CommonAppButton(
                  //   text: "Complete",
                  //   isLoading: state.isLoading,
                  //   onPressed: () {
                  //     context.read<RegisterBloc>().add(
                  //       MemberRegistrationSummitedEvent(
                  //         context: context,
                  //         fullName: nameController.text,
                  //         email: emailController.text,
                  //         gender: selectedGender ?? "",
                  //         state: selectedState ?? "",
                  //         language: selectedLanguage ?? "",
                  //
                  //
                  //         parentOrganizationName: parentOrgController.text,
                  //         postalAddress: postalAddressController.text,
                  //         dateIncorporation:dateIncorporationApi,
                  //         contactNumber: phoneController.text,
                  //
                  //         natureOrganization: natureOrgController.text,
                  //
                  //         selectAssociation: selectedAssociations,
                  //         profileImage: selectedImage,
                  //         phoneNumber: widget.phone,
                  //         panNumber:panController.text,
                  //         organizationEmailId: orgEmailController.text,
                  //         gstNumber:gstController.text,
                  //         designation: designation.text,
                  //         organizationName: orgNameController.text,
                  //         organizationType: orgTypeController.text,
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //       ),
                  //     );
                  //   },
                  // ),

                ],
              ),
            )])
          );
        }
      ),
    );
  }

  Widget decorationContainer({required Widget child,required double width}){
    return    Container(
        width: width,
        //    height: height,
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: ColorResource.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),

          ],
        ),
    child: child);
  }


  String formatUiDate(String apiDate) {
    final date = DateTime.parse(apiDate);
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }



// List of Indian states (you can expand this)
  final List<String> indianStates = [
    "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh",
    "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand",
    "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur",
    "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab",
    "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura",
    "Uttar Pradesh", "Uttarakhand", "West Bengal", "Delhi"
  ];





}





