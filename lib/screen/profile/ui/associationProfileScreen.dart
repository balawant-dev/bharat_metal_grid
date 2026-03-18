import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../app/theme/color_resource.dart';

import '../../../../widget/customAppbar.dart';
import '../../../../widget/customTextField.dart';

import '../../../core/constants/api_constants.dart';
import '../../../widget/primary_button.dart';
import '../../settings/appSettings/appSettings.dart';
import '../bloc/profileBloc.dart';
import '../bloc/profileEvent.dart';
import '../bloc/profileState.dart';


class ProfileAssociationScreen extends StatefulWidget {


  const ProfileAssociationScreen({super.key});

  @override
  State<ProfileAssociationScreen> createState() =>
      _ProfileAssociationScreenState();
}

class _ProfileAssociationScreenState
    extends State<ProfileAssociationScreen> {
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
    context.read<ProfileBloc>().add(FetchProfileAssociationEvent(context: context));
    //FetchProfileAssociationEvent
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
  Color getProgressColor(double value) {
    if (value < 0.5) {
      return Colors.redAccent;
    } else if (value < 0.8) {
      return Colors.orangeAccent;
    } else {
      return Colors.green;
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
    final double rawPercent =
        double.tryParse(AppSettings.profileCompletionPercentage ?? "0") ?? 0;

    final double percent = rawPercent.clamp(0, 100) / 100;
    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(
        title: "Association Profile Update",
        showBackButton: true,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileState) {
            final data = state.getProfileAssociationModel!.data;

            if (data != null) {
              associationNameController.text = data.associationName ?? "";
              govtRegistrationNumber.text =
                  data.governmentRegistrationNumber ?? "";
              yearFormationController.text = data.yearOfFormation ?? "";
              fullAddressController.text = data.fullAddress ?? "";
              cityController.text = data.city ?? "";
              emailController.text = data.email ?? "";
              pinController.text = data.pinCode ?? "";
              presidentSecretaryController.text =
                  data.presidentOrSecretary ?? "";

              selectedState = data.state;

              orgTypeController.text =
                  data.registrationCertificateType ?? "";

              // Dates (API format → UI format)
              if (data.verifiedBy != null) {
                verifiedByController.text =
                    _formatUiDate(data.verifiedBy!);
                verifiedByApi = data.verifiedBy!;
              }

              if (data.verifiedAt != null) {
                verifiedAtController.text =
                    _formatUiDate(data.verifiedAt!);
                verifiedAtApi = data.verifiedAt!;
              }
            }
          }
        },
        buildWhen: (previous, current) =>
        previous.refreshUI != current.refreshUI,
        builder: (context, state) {
          final bloc = context.read<ProfileBloc>();
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [

                CircularPercentIndicator(
                  radius: 52.0,
                  lineWidth: 8.0,
                  animation: true,
                  animationDuration: 800,
                  percent: percent,
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  progressColor: getProgressColor(percent),

                  center: Stack(
                    alignment: Alignment.center,
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
                            //   backgroundImage:
                            //       selectedImage != null
                            //           ? FileImage(selectedImage!)
                            //           : const AssetImage(
                            //                 "assets/icon/profileAvatar.png",
                            //               )
                            //               as ImageProvider,
                            // ),
                            // Positioned(
                            //   bottom: 0,
                            //   right: 0,
                            //   child: CircleAvatar(
                            //     radius: 14,
                            //     backgroundColor: ColorResource.primaryColor,
                            //     child: const Icon(
                            //       Icons.edit,
                            //       size: 16,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),

                      /// Optional percentage text overlay (top-right style)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: getProgressColor(percent),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "${rawPercent.toInt()}%",
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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
                        labelText: "Association Name",
                      ),
                      const SizedBox(height: 16),

                      CommonTextFormField(
                        controller: govtRegistrationNumber,
                        hintText: "Govt/Legal registration number",
                        labelText: "Govt/Legal registration number",
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 16),
                      CommonTextFormField(
                        controller: yearFormationController,
                        hintText: "Year of formation",
                        labelText: "Year of formation",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      CommonTextFormField(
                        controller: fullAddressController,
                        hintText: "Full Address",
                        labelText: "Full Address",
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 16),
                      CommonTextFormField(
                        controller: cityController,
                        hintText: "City",
                        labelText: "City",
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 16),

                      CommonTextFormField(

                        controller: emailController,
                        hintText: "Email ID",
                        labelText: "Email ID",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      CommonTextFormField(
                        controller: pinController,
                        hintText: "PIN",
                        labelText: "PIN",
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      CommonTextFormField(
                        controller: presidentSecretaryController,
                        hintText: "President/Secretary",
                        labelText: "President/Secretary",
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 16),

                      // State Dropdown
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 12,
                      //     vertical: 0,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.grey.shade300),
                      //     borderRadius: BorderRadius.circular(8),
                      //   ),
                      //   child: DropdownButtonHideUnderline(
                      //     child: DropdownButton<String>(
                      //       isExpanded: true,
                      //       hint: Text(
                      //         "Select State",
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.w400,
                      //           fontSize: 13,
                      //           color: Colors.black.withOpacity(0.85),
                      //         ),
                      //       ),
                      //       value: selectedState,
                      //       items:
                      //           indianStates
                      //               .map(
                      //                 (e) => DropdownMenuItem(
                      //                   value: e,
                      //                   child: Text(
                      //                     e,
                      //                     style: TextStyle(
                      //                       fontWeight: FontWeight.w400,
                      //                       fontSize: 13,
                      //                       color: Colors.black,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               )
                      //               .toList(),
                      //       onChanged:
                      //           (val) => setState(() => selectedState = val),
                      //     ),
                      //   ),
                      // ),

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
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 12,
                      //     vertical: 4,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.grey.shade300),
                      //     borderRadius: BorderRadius.circular(8),
                      //   ),
                      //   child: DropdownButtonHideUnderline(
                      //     child: DropdownButton<String>(
                      //       isExpanded: true,
                      //       hint: Text(
                      //         "Registration Certificate",
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.w400,
                      //           fontSize: 13,
                      //           color: Colors.black.withOpacity(0.85),
                      //         ),
                      //       ),
                      //       value:
                      //           orgTypeController.text.isEmpty
                      //               ? null
                      //               : orgTypeController.text,
                      //       items:
                      //           [
                      //                 "Company",
                      //                 "Firm",
                      //                 "Proprietorship",
                      //                 "Others",
                      //               ]
                      //               .map(
                      //                 (e) => DropdownMenuItem(
                      //                   value: e,
                      //                   child: Text(
                      //                     e,
                      //                     style: TextStyle(
                      //                       fontWeight: FontWeight.w400,
                      //                       fontSize: 13,
                      //                       color: Colors.black,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               )
                      //               .toList(),
                      //       onChanged:
                      //           (val) => setState(
                      //             () => orgTypeController.text = val ?? "",
                      //           ),
                      //     ),
                      //   ),
                      // ),
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
                        labelText: "Verified By",
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
                        labelText: "Verified At",
                        suffixIcon: Icon(Icons.calendar_month,color: Colors.grey.shade500,),
                        readOnly: true,
                        onTap: () {
                          pickDate(
                            controller: verifiedAtController,
                            onApiDate: (val) => verifiedAtApi = val,
                          );
                        },
                      ),



                    ],
                  ),
                ),
                SizedBox(height: 20),

                CommonAppButton(
                  text: "Update",
                  isLoading: state.isUpdateLoading,
                  onPressed: () {
                    context.read<ProfileBloc>().add(
                      AssociationUpdateSummitedEvent(
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
                        // mobile: widget.phone ,

                        pin: pinController.text,

                        presidentSecretary:presidentSecretaryController.text ,
                        selectState: selectedState??"",

                        yearFormation: yearFormationController.text,



                        email: emailController.text,



                      ),
                    );
                     AppSettings.initUserType(); // 🔥 MOST IMPORTANT
                    // context.read<ProfileBloc>().add(FetchProfileAssociationEvent(context: context));
                     AppSettings.initUserType(); // 🔥 MOST IMPORTANT
                  },
                ),
              ],
            ),
          );
        },
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

  String _formatUiDate(String apiDate) {
    // API: yyyy-MM-dd
    final date = DateTime.parse(apiDate);

    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
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
