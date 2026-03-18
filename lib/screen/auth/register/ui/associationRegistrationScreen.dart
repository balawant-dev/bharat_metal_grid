import 'dart:async';
import 'dart:io';
import 'package:bharat_metal_grid/widget/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/router/navigation/nav.dart';
import '../../../../app/router/navigation/routes.dart';
import '../../../../app/theme/color_resource.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../widget/customAppbar.dart';
import '../../../../widget/customTextField.dart';

import '../bloc/registerBloc.dart';
import '../bloc/registerEvent.dart';
import '../bloc/registerState.dart';

class AssociationRegistrationScreen extends StatefulWidget {
  final String phone;

  const AssociationRegistrationScreen({super.key, required this.phone});

  @override
  State<AssociationRegistrationScreen> createState() =>
      _AssociationRegistrationScreenState();
}

class _AssociationRegistrationScreenState
    extends State<AssociationRegistrationScreen> {
  final associationNameController = TextEditingController();
  final emailController = TextEditingController();
  final pinController = TextEditingController();
  final presidentSecretaryController = TextEditingController();
  final govtRegistrationNumber = TextEditingController();
  final yearFormationController = TextEditingController();
  final fullAddressController = TextEditingController();
  final cityController = TextEditingController();

  String? selectedState;

  // Controllers for Organization Details
  final orgTypeController = TextEditingController();

  final verifiedByController = TextEditingController();
  final verifiedAtController = TextEditingController();




  @override
  void initState() {
    super.initState();
  }

  final List<String> associations = [
    "Association 1",
    "Association 2",
    "Association 3",
    "Association 4",
  ];
  final Set<String> selectedAssociations = {};

  File? selectedImage;
  File? selectedDocument;
  final ImagePicker _picker = ImagePicker();
  final ImagePicker _picker2 = ImagePicker();

  /// 📸 Pick Image
  Future<void> pickImage(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }
  Future<void> pickDocument(ImageSource source) async {
    final XFile? picked = await _picker2.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (picked != null) {
      setState(() {
        selectedDocument = File(picked.path);
      });
    }
  }

  void showDocumentPicker() {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () {
                    Navigator.pop(context);
                    pickDocument(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text("Gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    pickDocument(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
    );
  }  void showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => SafeArea(
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
  String verifiedByApi = "";
  String verifiedAtApi = "";


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
    associationNameController.dispose();
    emailController.dispose();
    pinController.dispose();
    presidentSecretaryController.dispose();
    govtRegistrationNumber.dispose();
    yearFormationController.dispose();
    fullAddressController.dispose();
    cityController.dispose();
    orgTypeController.dispose();

    verifiedAtController.dispose();

    verifiedAtController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(
        title: "Association Registration",
        showBackButton: true,
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) async {
          if (state.isSuccess) {
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
            // Nav.push(
            //   context,
            //   Routes.verifySuccess,
            //   //extra: component.isAgent,
            // );
            // Nav.push(context, Routes.otp, extra: mobileController.text);
          }
          if (state.hasError && state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            context.read<RegisterBloc>().add(const ResetRegisterEvent());
          }

          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
          context.read<RegisterBloc>().emit(state.copyWith(errorMessage: null));
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            final bloc = context.read<RegisterBloc>();
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
                          backgroundImage:
                              selectedImage != null
                                  ? FileImage(selectedImage!)
                                  : const AssetImage(
                                        "assets/icon/profileAvatar.png",
                                      )
                                      as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: ColorResource.primaryColor,
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
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
                      title: const Text(
                        "Basic Details",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      children: [
                        CommonTextFormField(
                          controller: associationNameController,
                          hintText: "Association Name",
                        ),
                        const SizedBox(height: 16),

                        CommonTextFormField(
                          controller: govtRegistrationNumber,
                          hintText: "Govt/Legal registration number",
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 16),
                        CommonTextFormField(
                          controller: yearFormationController,
                          hintText: "Year of formation",
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        CommonTextFormField(
                          controller: fullAddressController,
                          hintText: "Full Address",
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 16),
                        CommonTextFormField(
                          controller: cityController,
                          hintText: "City",
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 16),

                        CommonTextFormField(
                          controller: emailController,
                          hintText: "Email ID",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        CommonTextFormField(
                          controller: pinController,
                          hintText: "PIN",
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        CommonTextFormField(
                          controller: presidentSecretaryController,
                          hintText: "President/Secretary",
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 16),

                        // State Dropdown
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text(
                                "Select State",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(0.85),
                                ),
                              ),
                              value: selectedState,
                              items:
                                  indianStates
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                              onChanged:
                                  (val) => setState(() => selectedState = val),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Organization Details Section
                  decorationContainer(
                    width: width,
                    child: ExpansionTile(
                      shape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                      ),
                      collapsedShape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                      ),
                      title: const Text(
                        "Advance Details",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      children: [
                        // Type
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text(
                                "Registration Certificate",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(0.85),
                                ),
                              ),
                              value:
                                  orgTypeController.text.isEmpty
                                      ? null
                                      : orgTypeController.text,
                              items:
                                  [
                                        "Company",
                                        "Firm",
                                        "Proprietorship",
                                        "Others",
                                      ]
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                              onChanged:
                                  (val) => setState(
                                    () => orgTypeController.text = val ?? "",
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: showDocumentPicker, // same function
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12), // rounded rectangle
                                child: Container(
                                  height: 120,
                                  width: double.infinity,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(12),
                             //    color: ColorResource.t,
                                 border: Border.all(color: Colors.grey.shade300),
                               ),
                                  child: selectedDocument != null
                                      ? Image.file(
                                    selectedDocument!,
                                    fit: BoxFit.cover,
                                  )
                                      : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      Icon(
                                        Icons.cloud_upload_outlined,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        width: 108,
                                        height: 30,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1,
                                              color: const Color(0xFFD9D9D9),
                                            ),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ),
                                        child: Center(


                                          child: Text(
                                            'Browse file',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'PDF, JPG or PNG (Max 5MB)',
                                        style: TextStyle(
                                          color: Colors.black.withValues(alpha: 0.50),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),


                        const SizedBox(height: 16),

                        CommonTextFormField(
                          controller: verifiedByController,
                          hintText: "Verified By",
                          suffixIcon: Icon(Icons.calendar_month,color: Colors.grey.shade500,),
                          readOnly: true,
                          onTap: () {
                            pickDate(
                              controller: verifiedByController,
                              onApiDate: (val) => verifiedByApi = val,
                            );
                          },
                        ),

                        const SizedBox(height: 16),
                        CommonTextFormField(
                          controller: verifiedAtController,
                          hintText: "Verified At",
                          suffixIcon: Icon(Icons.calendar_month,color: Colors.grey.shade500,),
                          readOnly: true,
                          onTap: () {
                            pickDate(
                              controller: verifiedAtController,
                              onApiDate: (val) => verifiedAtApi = val,
                            );
                          },
                        ),


                        SizedBox(height: 20),

                        CommonAppButton(
                          text: "Complete",
                          isLoading: state.isLoading,
                          onPressed: () {
                            context.read<RegisterBloc>().add(
                              AssociationRegistrationSummitedEvent(
                                context: context,
                                registrationCertificateType: orgTypeController.text,
                                verifiedBy:verifiedByApi,
                                verifiedAt: verifiedAtApi,
                                profileImage: selectedImage,
                                registrationCertificateImage: selectedDocument,
                                associationName:  associationNameController.text,
                                govtLegalRegistrationNumber: govtRegistrationNumber.text ,
                                city:cityController.text ,
                                fullAddress:fullAddressController.text ,
                                mobile: widget.phone ,

                                pin: pinController.text,

                                presidentSecretary:presidentSecretaryController.text ,
                                selectState: selectedState??"",

                                yearFormation: yearFormationController.text,



                                email: emailController.text,



                              ),
                            );
                          },
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
    );
  }

  Widget decorationContainer({required Widget child, required double width}) {
    return Container(
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
      child: child,
    );
  }

  // List of Indian states (you can expand this)
  final List<String> indianStates = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
    "Delhi",
  ];
}
