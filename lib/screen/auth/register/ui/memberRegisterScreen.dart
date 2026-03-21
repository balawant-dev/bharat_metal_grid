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


import '../../../../widget/motionToastHelper.dart';
import '../bloc/registerBloc.dart';
import '../bloc/registerEvent.dart';
import '../bloc/registerState.dart';

class MemberRegisterScreen extends StatefulWidget {
  final String phone;

  const MemberRegisterScreen({super.key,required this.phone});
  @override
  State<MemberRegisterScreen> createState() => _MemberRegisterScreenState();
}

class _MemberRegisterScreenState extends State<MemberRegisterScreen> {
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
context.read<RegisterBloc>().add(AllAssociationEvent(context: context));

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
      appBar: CustomAppBar(title: "Member Registration",showBackButton: true,),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) async {
          if (state.isSuccess) {
            // Nav.push(
            //   context,
            //   Routes.verifySuccess,
            //   //extra: component.isAgent,
            // );
            Nav.go(
              context,
              Routes.success,
              //extra: component.isAgent,
            );
            // Nav.go(
            //   context,
            //   Routes.home,
            //   //extra: component.isAgent,
            // );
            // Nav.push(context, Routes.otp, extra: mobileController.text);
          }
          if (state.hasError && state.errorMessage != null) {
            // ScaffoldMessenger.of(
            //   context,
            // ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            context.read<RegisterBloc>().add(const ResetRegisterEvent());
          }

          if (state.errorMessage != null) {
            // ScaffoldMessenger.of(
            //   context,
            // ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
          context.read<RegisterBloc>().emit(state.copyWith(errorMessage: null));
        },
        child: BlocBuilder<RegisterBloc,RegisterState>(
          builder: (context,state) {
            if(state.getAllAssociationModel==null){
              return SizedBox(
                height: height,
                  width: width,
                  child: Center(child: const AppMetalLoader(
                    text: "Loading Association data...",
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
                      backgroundColor: ColorResource.white,
                      radius: 50,
                      backgroundImage: selectedImage != null
                          ? FileImage(selectedImage!)
                          : const AssetImage("assets/images/appLogo.png") as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: ColorResource.primaryColor,
                        child: const Icon(Icons.camera_alt_rounded, size: 16, color: Colors.white),
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
                    titleWidget(title:"Gender" ),

                    SizedBox(height: 5,),

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
                    titleWidget(title:"State" ),


                    SizedBox(height: 5,),
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
                    titleWidget(title:"Preferred Language" ),

                    SizedBox(height: 5,),

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
                    titleWidget(title:"Organisation Type" ),
                    SizedBox(height: 5,),
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
                          hint:  Text("Organisation Type",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black.withOpacity(0.85)),),
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
                    const SizedBox(height: 16),         CommonTextFormField(controller: orgNameController, hintText: "Organization Name"),
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
                    if (state.getAllAssociationModel != null &&
                        state.getAllAssociationModel!.data!.isNotEmpty)
                      DropdownSearch<String>.multiSelection(
                        items: (filter, loadProps) async {
                          return state.getAllAssociationModel!.data!
                              .map((e) => e.associationName ?? "")
                              .where((item) =>
                              item.toLowerCase().contains(filter.toLowerCase()))
                              .toList();
                        },


                        selectedItems: const [],

                        popupProps: const PopupPropsMultiSelection.dialog(
                          showSearchBox: true,
                          searchFieldProps: const TextFieldProps(
                            decoration: InputDecoration(
                              hintText: "Search associations", // 🔍 hint here
                            ),
                          ),

                        ),

                        // ✅ CORRECT PARAMETER NAME
                        dropdownBuilder: (context, selectedItems) {
                          return const Text(
                            "Select Associations",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          );
                        },

                        // dropdownBuilderMultiSelection: (context, items) {
                        //   return const Text(
                        //     "Select Associations",
                        //     style: TextStyle(color: Colors.grey),
                        //   );
                        // },

                        onChanged: (List<String> selectedNames) {
                          setState(() {
                            selectedAssociations.clear();
                            selectedAssociationNames.clear(); // 👈 new list

                            for (var assoc in state.getAllAssociationModel!.data!) {
                              if (selectedNames.contains(assoc.associationName)) {
                                selectedAssociations.add(assoc.sId ?? "");
                                selectedAssociationNames.add(assoc.associationName ?? "");
                              }
                            }
                          });
                        },
                      ),
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





                    const SizedBox(height: 30),

                    SizedBox(height: 20),

                    CommonAppButton(
                      text: "Complete",
                      isLoading: state.isLoading,
                      onPressed: () {
                        if (!validateFields()) return;
                        context.read<RegisterBloc>().add(
                          MemberRegistrationSummitedEvent(
                            context: context,
                            fullName: nameController.text,
                            email: emailController.text,
                            gender: selectedGender ?? "",
                            state: selectedState ?? "",
                            language: selectedLanguage ?? "",


                            parentOrganizationName: parentOrgController.text,
                            postalAddress: postalAddressController.text,
                            dateIncorporation:dateIncorporationApi,
                            contactNumber: phoneController.text,

                            natureOrganization: natureOrgController.text,

                            selectAssociation: selectedAssociations,
                            profileImage: selectedImage,
                            phoneNumber: widget.phone,
                            panNumber:panController.text,
                            organizationEmailId: orgEmailController.text,
                            gstNumber:gstController.text,
                            designation: designation.text,
                            organizationName: orgNameController.text,
                            organizationType: orgTypeController.text,







                          ),
                        );
                      },
                    ),

                  ],
                ),
              )])
            );
          }
        ),
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





// List of Indian states (you can expand this)
  final List<String> indianStates = [
    "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh",
    "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand",
    "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur",
    "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab",
    "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura",
    "Uttar Pradesh", "Uttarakhand", "West Bengal", "Delhi"
  ];



  bool validateFields() {
    // Name
    if (nameController.text.trim().isEmpty) {
      ToastHelper.show(context,
          message: "Please enter full name", type: ToastType.warning);
      return false;
    }

    // Gender
    if (selectedGender == null) {
      ToastHelper.show(context,
          message: "Please select gender", type: ToastType.warning);
      return false;
    }  if (selectedImage == null) {
      ToastHelper.show(context,
          message: "Please upload profile image", type: ToastType.warning);
      return false;
    }

    // Email
    if (emailController.text.trim().isEmpty) {
      ToastHelper.show(context,
          message: "Please enter email", type: ToastType.warning);
      return false;
    }

    // State
    if (selectedState == null) {
      ToastHelper.show(context,
          message: "Please select state", type: ToastType.warning);
      return false;
    }

    // Language
    if (selectedLanguage == null) {
      ToastHelper.show(context,
          message: "Please select preferred language", type: ToastType.warning);
      return false;
    }

    // Organization Type
    if (orgTypeController.text.trim().isEmpty) {
      ToastHelper.show(context,
          message: "Please select organization type", type: ToastType.warning);
      return false;
    }

    // Designation
    if (designation.text.trim().isEmpty) {
      ToastHelper.show(context,
          message: "Please enter designation", type: ToastType.warning);
      return false;
    }

    // Organization Name
    if (orgNameController.text.trim().isEmpty) {
      ToastHelper.show(context,
          message: "Please enter organization name", type: ToastType.warning);
      return false;
    }

    // Address
    if (postalAddressController.text.trim().isEmpty) {
      ToastHelper.show(context,
          message: "Please enter postal address", type: ToastType.warning);
      return false;
    }

    // Date
    if (dateIncorporationApi.isEmpty) {
      ToastHelper.show(context,
          message: "Please select incorporation date", type: ToastType.warning);
      return false;
    }

    // Contact
    if (orgContactController.text.trim().isEmpty ||
        orgContactController.text.length < 10) {
      ToastHelper.show(context,
          message: "Please enter valid contact number", type: ToastType.warning);
      return false;
    }

    // Org Email
    if (orgEmailController.text.trim().isEmpty) {
      ToastHelper.show(context,
          message: "Please enter organization email", type: ToastType.warning);
      return false;
    }

    // PAN
    if (panController.text.trim().isEmpty) {
      ToastHelper.show(context,
          message: "Please enter PAN number", type: ToastType.warning);
      return false;
    }

    // GST
    if (gstController.text.trim().isEmpty) {
      ToastHelper.show(context,
          message: "Please enter GST number", type: ToastType.warning);
      return false;
    }

    // Associations
    if (selectedAssociations.isEmpty) {
      ToastHelper.show(context,
          message: "Please select at least one association", type: ToastType.warning);
      return false;
    }

    return true;
  }
  Widget titleWidget({required String title}){
    return    Row(
      children: [
        Text(title,style: TextStyle(fontSize: 12,color: Colors.black),),
      ],
    );
  }

}





