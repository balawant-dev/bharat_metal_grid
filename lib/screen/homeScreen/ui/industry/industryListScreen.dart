import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../app/router/navigation/nav.dart';
import '../../../../app/router/navigation/routes.dart';
import '../../../../app/theme/color_resource.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../widget/customAppbar.dart';
import '../../../../widget/custom_text.dart';
import '../../bloc/homeBloc.dart';
import '../../bloc/homeState.dart';
import '../component/industryNewsCard.dart';

class IndustryNewScreen extends StatefulWidget {
  const IndustryNewScreen({super.key});

  @override
  State<IndustryNewScreen> createState() => _IndustryNewScreenState();
}

class _IndustryNewScreenState extends State<IndustryNewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Industry News"),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final newsList = state.industryNewsModel?.data ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: AnimationLimiter(
              child: Wrap(
                spacing: 12, // horizontal gap
                runSpacing: 12, // vertical gap
                children: List.generate(newsList.length, (index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(seconds: 3),
                    columnCount: 2,
                    child: SlideAnimation(
                      verticalOffset: 700.0,
                      child: FadeInAnimation(
                        child: SizedBox(
                          width: (MediaQuery.of(context).size.width / 2) - 18,
                          // child: IndustryNewsCard(
                          //   image:
                          //   "${ApiConstants.baseUrl}${newsList[index].coverImage}",
                          //   title: newsList[index].title!,
                          // ),
                          child: GestureDetector(
                            onTap: (){
                              Nav.push(context, Routes.industryDetail, extra: newsList[index].sId);
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: 130,
                              height: 210,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF150E1F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                                    child: Image.network(
                                      "${ApiConstants.baseUrl}${newsList[index].coverImage}",
                                      height: 100,
                                     width: 180,
                                      fit: BoxFit.fill,
                                      errorBuilder: (context, error, stackTrace) {
                                        return                    ClipRRect(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                                          child: Image.network(
                                            'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTIH6UCBNTMummUP7XFb1fTkcv0ZgAY6YZ3VFHArGvlaEoNtte4',
                                            // fit: BoxFit.cover,
                                            height: 100,
                                            width: 180,
                                            fit: BoxFit.fill,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Text(
                                    newsList[index].title!,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: ColorResource.white,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    width: 160,
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(0.00, 0.50),
                                        end: Alignment(1.00, 0.50),
                                        colors: [
                                          const Color(0xFF2F60C2),
                                          const Color(0xFF042C7A),
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                    ),
                                    child: Center(
                                      child: CustomText(
                                        '5 MINS READ',
                                        size: 12,
                                        weight: FontWeight.w600,
                                        color: ColorResource.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
