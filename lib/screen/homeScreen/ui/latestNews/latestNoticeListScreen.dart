import 'package:bharat_metal_grid/screen/homeScreen/bloc/homeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../app/router/navigation/nav.dart';
import '../../../../app/router/navigation/routes.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../widget/customAppbar.dart';
import '../../bloc/homeBloc.dart';
import '../../bloc/homeEvent.dart';
import '../component/latestNoticesSection.dart';

class LatestNoticeListScreen extends StatefulWidget {
  const LatestNoticeListScreen({super.key});

  @override
  State<LatestNoticeListScreen> createState() => _LatestNoticeListScreenState();
}

class _LatestNoticeListScreenState extends State<LatestNoticeListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //context.read<HomeBloc>().add(FetchIndustryNewsEvent(context: context,limit: 10,page: 1));
    context.read<HomeBloc>().add(
      FetchLatestNoticesEvent(context: context, page: 1, limit: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Latest Notices"),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return AnimationLimiter(
            child: ListView.builder(

              itemCount: state.latestNoticesModel!.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(seconds: 3),
                  child: SlideAnimation(
                    verticalOffset: 500.0,
                    child: FadeInAnimation(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                        child: GestureDetector(
                          onTap: (){
                            Nav.push(context, Routes.latestNoticeDetail, extra: state.latestNoticesModel!.data![index].sId);
                          },
                          child: LatestNoticesSection(
                            id: state.latestNoticesModel!.data![index].sId!,
                            image:
                                "${ApiConstants.baseUrl}${state.latestNoticesModel!.data!.first.coverImage}",

                            title: state.latestNoticesModel!.data!.first.title!,
                            des: state.latestNoticesModel!.data!.first.shortDescription!,
                            pdfFile:  "${ApiConstants.baseUrl}${state.latestNoticesModel!.data!.first.pdfFile}",
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
