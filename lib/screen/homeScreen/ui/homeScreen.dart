import 'package:bharat_metal_grid/app/theme/color_resource.dart';
import 'package:bharat_metal_grid/screen/homeScreen/bloc/homeBloc.dart';
import 'package:bharat_metal_grid/screen/homeScreen/bloc/homeEvent.dart';
import 'package:bharat_metal_grid/screen/homeScreen/homeSkeleton/homeSkeleton.dart';
import 'package:bharat_metal_grid/screen/settings/appSettings/appSettings.dart';
import 'package:bharat_metal_grid/widget/primary_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router/navigation/nav.dart';
import '../../../app/router/navigation/routes.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../../widget/custom_text.dart';
import '../../appDrawer/ui/app_drawer.dart';
import '../../profile/bloc/profileBloc.dart';
import '../../profile/bloc/profileEvent.dart';
import '../bloc/homeState.dart';
import '../model/bannerModel.dart';
import '../model/galleryListModel.dart';
import '../model/industryNewsModel.dart';
import '../model/latestNoticesModel.dart';
import 'component/circularProgressRing.dart';
import 'component/industryNewsCard.dart';
import 'component/latestNoticesSection.dart';
import 'component/overlaping.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'gallery_grid_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isUserLoaded = false;
  static String userName = "";
  static String userProfileImage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(FetchBannerEvent(context: context));
    // context.read<ProfileBloc>().add(FetchProfileAssociationEvent(context: context));


    // @override
    // void initState() {
    //   super.initState();
    //
    //   //FetchProfileAssociationEvent
    // }
    // context.read<HomeBloc>().add(FetchIndustryNewsEvent(context: context,limit: 10,page: 1));
    // context.read<HomeBloc>().add(FetchLatestNoticesEvent(context: context,page: 1,limit: 10));
    // context.read<HomeBloc>().add(GallerListEvent(context: context,page: 1,limit: 10));
    initUserType();
  }

  static Future<void> initUserType() async {

    userName = await SecureStorageService.getUserName() ?? "";

    userProfileImage = await SecureStorageService.getUserProfileImage() ?? "";
  }
  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning 👋";
    } else if (hour < 17) {
      return "Good Afternoon ☀️";
    } else if (hour < 21) {
      return "Good Evening 🌇";
    } else {
      return "Good Night 🌙";
    }
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print("😂😂😂😂${AppSettings.userName}");
    print("😂😂😂😂${ApiConstants.baseUrl}${AppSettings.userProfileImage}");
    return Scaffold(
      backgroundColor: ColorResource.white,
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          userName = await SecureStorageService.getUserName() ?? "";

          userProfileImage = await SecureStorageService.getUserProfileImage() ?? "";
          context.read<HomeBloc>().add(FetchBannerEvent(context: context));

        },
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            initUserType();
            //AppSettings.initUserType();
            // if (state.errorMessage != null) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text(state.errorMessage!)),
            //   );
            // }
          },
          builder: (context, state) {
            AppSettings.initUserType();
            if (state.isLoading && state.getBannerModel == null) {
              return const HomeSkeleton(); // 👈 only first time
            }
            // if (state.isLoading) {
            //   return const HomeSkeleton();
            // }

            /// ❌ SAFETY CHECK
            if (state.latestNoticesModel == null ||
                state.industryNewsModel == null ||
                state.galleryListModel == null) {
              return HomeSkeleton();
            }

            return Stack(
              children: [
                if (state.isLoading)
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(
                      minHeight: 3,
                      backgroundColor: Colors.red,
                      valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
                    ),
                  ),
                Builder(
                  builder: (context) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          expandedHeight: 300.0,
                          backgroundColor: ColorResource.white,

                          automaticallyImplyLeading: false,
                          // backgroundColor: Color(0xFF062E7E),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print("Open drawer");
                                      Scaffold.of(context).openDrawer();
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),

                                        child: Image.network(
                                          "${ApiConstants.baseUrl}${userProfileImage}",
                                          height: 30,
                                          fit: BoxFit.fill,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              "assets/icon/profileAvatar.png",
                                              height: 30,
                                              fit: BoxFit.fill,
                                              //       color: Colors.white,
                                            );
                                            ;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getGreeting(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      FutureBuilder(
                                        future: AppSettings.initUserType(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState !=
                                              ConnectionState.done) {
                                            return SizedBox();
                                            // return const CircularProgressIndicator();
                                          }
                                          return Text(
                                           "${userName}",
                                            style: TextStyle(
                                              color: const Color(0xFFE0E4C8),
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          );
                                        },
                                      ),

                                      // Text(
                                      //   "${AppSettings.userName}",
                                      //   // 'Rahul!',
                                      //   style: TextStyle(
                                      //     color: const Color(0xFFE0E4C8),
                                      //     fontSize: 12,
                                      //     fontFamily: 'Poppins',
                                      //     fontWeight: FontWeight.w500,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Nav.push(
                                    context,
                                    Routes.notification,
                                    //extra: widget.isAgent,
                                  );
                                },
                                child: Image.asset(
                                  "assets/icon/notification.png",
                                  scale: 3.5,
                                ),
                              ),
                            ],
                          ),
                          flexibleSpace: DecoratedBox(
                            // ← key wrapper for persistent gradient
                            decoration: const ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(-0.00, 0.50),
                                end: Alignment(1.00, 0.50),
                                colors: [Color(0xFF2D5FC0), Color(0xFF062E7E)],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(90),
                                ),
                              ),
                            ),
                            child: FlexibleSpaceBar(
                              background: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(-0.00, 0.50),
                                    end: Alignment(1.00, 0.50),
                                    colors: [
                                      const Color(0xFF2D5FC0),
                                      const Color(0xFF062E7E),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(93),
                                    ),
                                  ),
                                ),
                                child: SafeArea(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Greeting + Bell
                                      const SizedBox(height: 70),
                                      Container(
                                        width: width,
                                        height: 40,
                                        //  clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Metal rate: Silver- 300000/- kg | Gold 24 CRT - 14000/10gm',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0),
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 180,
                                                  child: OverlappingAvatars(),
                                                ),
                                                SizedBox(height: 10),
                                                SizedBox(
                                                  width: 135,
                                                  child: Text(
                                                    'Members Already Joined',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                // CommonAppButton(
                                                //   width: 150,
                                                //   height: 40,
                                                //   fontSize: 13,
                                                //   fontWeight: FontWeight.w500,
                                                //   text: "Renew Now    →",
                                                //   onPressed: () {},
                                                // ),
                                              ],
                                            ),
                                            CircleProgressRingScreen(),
                                          ],
                                        ),
                                      ),

                                      //     const Spacer(),

                                      // Metal Rates

                                      // Renew Button
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ─── Body Content ────────────────────────────────────────────────────
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            // "👏👏👏👏👏👏👏👏👏👏👏👏👏👏👏👏"
                            children: [

                              SizedBox(height: 15),
                              bannerCarousel(bannerList: state.getBannerModel!),
                              SizedBox(height: 15),
                              quickSection(context: context),
                              SizedBox(height: 10),
                              industryNewsSection(
                                context: context,
                                industryNewsModel: state.industryNewsModel!,
                              ),
                              SizedBox(height: 15),
                              latestNoticesSection(
                                context: context,
                                latestNoticesModel: state.latestNoticesModel!,
                              ),
                              SizedBox(height: 15),
                              gallerySection(
                                context: context,
                                galleryListModel: state.galleryListModel!,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget quickSection({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                'Quick Actions',
                size: 16,
                weight: FontWeight.w500,
                color: ColorResource.black,
              ),
            ],
          ),
          // titleWidget(title: 'Quick Actions', onTap: () {}),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardDetails(
                  context: context,
                  image: 'assets/icon/membership.png',
                  title: 'Membership \nInformation',
                  color: Color(0xFFFFF4E5),
                  onTap: (){
                    Nav.push(context, Routes.membershipAssignment);
                  }
              ),
              cardDetails(
                  context: context,
                  image: 'assets/icon/postmember.png',
                  title: 'Member Post',
                  color: Color(0xFFE5F0FF),
                  onTap: (){
                    Nav.push(context, Routes.post);
                  }

              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardDetails(
                  context: context,
                  image: 'assets/icon/indursty.png',
                  title: 'Industry \nReport',
                  color: Color(0xFFE9F9F0),
                  onTap: (){
                    Nav.push(context, Routes.industryNews);
                  }
              ),
              cardDetails(
                  context: context,
                  image: 'assets/icon/complaint.png',
                  title: 'Complaint & \nSupport',
                  color: Color(0xFFF3E8FF),
                  onTap: (){
                    Nav.push(context, Routes.complaintSupport);
                  }
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget bannerCarousel({required GetBannerModel bannerList}) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 140,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: bannerList.data!.banners!.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              // margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  "${ApiConstants.baseUrl}${imageUrl}",
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Text("Loading Banner...",style: TextStyle(fontSize: 10),),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(Icons.broken_image, size: 40),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
  Widget industryNewsSection({
    required BuildContext context,
    required IndustryNewsModel industryNewsModel,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          titleWidget(
            title: 'Industry News',
            onTap: () {
              Nav.push(context, Routes.industryNews);
            },
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 177,
            child: AnimationLimiter(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: industryNewsModel.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: IndustryNewsCard(
                      id: industryNewsModel.data![index].sId??"NO Id",
                      image:
                      "${ApiConstants.baseUrl}${industryNewsModel.data![index].coverImage}",
                      title: industryNewsModel.data![index].title!,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget latestNoticesSection({
    required BuildContext context,
    required LatestNoticesModel latestNoticesModel,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          // SizedBox(height: 10),
          titleWidget(
            title: 'Latest Notices',
            onTap: () {
              Nav.push(context, Routes.latestNotices);
            },
          ),
          SizedBox(height: 10),
          LatestNoticesSection(
            id: latestNoticesModel.data!.first.sId!,
            image:
            "${ApiConstants.baseUrl}${latestNoticesModel.data!.first.coverImage}",
            title: latestNoticesModel.data!.first.title!,
            des: latestNoticesModel.data!.first.shortDescription!,
            pdfFile:"${ApiConstants.baseUrl}${latestNoticesModel.data!.first.pdfFile}",
          ),

          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget gallerySection({
    required BuildContext context,
    required GalleryListModel galleryListModel,
  }) {
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: 168,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: const Color(0xFFBBD2FF)),
      child: Column(
        children: [
          titleWidget(
            title: 'Gallery',
            onTap: () {
              context.push(
                Routes.galleryGrid,
                extra: galleryListModel.data, // poora gallery list
              );
            },
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: galleryListModel.data!.length,
              itemBuilder: (context, index) {
                final image = galleryListModel.data![index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: (){
                      context.push(
                        Routes.fullGallery,
                        extra: {
                          'list': galleryListModel.data!, // poora list
                          'index': index,      // jo image click hua
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "${ApiConstants.baseUrl}${image.images!.first}",
                        // 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQEzkNQnD_EVTXzy95gT21Z61LupDx4Z6SpfE5XHI7HOxsZJy5x',
                        width: 100,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            // "${ApiConstants.baseUrl}${image}",
                            'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQEzkNQnD_EVTXzy95gT21Z61LupDx4Z6SpfE5XHI7HOxsZJy5x',
                            width: 100,
                            height: 80,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget titleWidget({
    required String title,

    required VoidCallback onTap,

    required,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title,
          size: 16,
          weight: FontWeight.w500,
          color: ColorResource.black,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 50,
            height: 18,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFF858089),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: Center(
              child: CustomText(
                'View all',
                size: 10,
                weight: FontWeight.w500,
                color: ColorResource.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget cardDetails({
    required String image,
    required String title,
    required BuildContext context,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width / 2 - 20,
            height: 110,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 7.70,
                  offset: Offset(-5, 5),
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Image.asset(image, height: 70, width: 70),
          ),
          Positioned(
            left: 10,
            bottom: 8,
            child: CustomText(
              title,
              size: 13,
              weight: FontWeight.w700,
              color: ColorResource.black,
            ),
          ),
        ],
      ),
    );
  }
}
