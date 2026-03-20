import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/navigation/routes.dart';
import '../../../core/constants/api_constants.dart';
import '../../../widget/customAppbar.dart';
import '../bloc/leaderShipBloc.dart';
import '../bloc/leaderShipEvent.dart';
import '../bloc/leaderShipState.dart';
import '../model/leaderShipModel.dart';

class LeadershipScreen extends StatefulWidget {
  const LeadershipScreen({super.key});

  @override
  State<LeadershipScreen> createState() => _LeadershipScreenState();
}

class _LeadershipScreenState extends State<LeadershipScreen> {

  @override
  void initState() {
    super.initState();
    context.read<LeaderShipBloc>().add(
      FetchLeaderShipEvent(context: context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: CustomAppBar(
        title: "Leadership",
        showBackButton: true,
        isHome: true,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        context.push(Routes.postLeaderShip);
      },child: Icon(Icons.add,color: Colors.white,),),
      body: BlocBuilder<LeaderShipBloc, LeaderShipState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.leaderShipModel?.data == null ||
              state.leaderShipModel!.data!.isEmpty) {
            return const Center(child: Text("No leadership data found"));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: _buildLeadershipStructure(
              state.leaderShipModel!.data!,
            ),
          );
        },
      ),
    );
  }

  /// 🔥 ORGANIZATION STRUCTURE UI
  Widget _buildLeadershipStructure(List<Data> employees) {

    final president = employees
        .where((e) => e.designation == "President")
        .toList();

    final vicePresident = employees
        .where((e) => e.designation == "Vice-President")
        .toList();

    final secretary = employees
        .where((e) => e.designation == "Secretary")
        .toList();

    final treasurer = employees
        .where((e) => e.designation == "Treasurer")
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [

          /// 🔝 PRESIDENT (TOP CENTER)
          if (president.isNotEmpty)
            Center(child: _employeeCard(employee:president.first, height: 200,width: 180,fontSize: 20)),

          const SizedBox(height: 40),

          /// 🔽 SECOND ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              if (vicePresident.isNotEmpty)
                Expanded(child: _employeeCard(employee:vicePresident.first,height: 140,width: 140,fontSize: 16)),

              const SizedBox(width: 12),

              if (secretary.isNotEmpty)
                Expanded(child: _employeeCard(employee:secretary.first,width: 140,height: 140,fontSize: 16)),

              const SizedBox(width: 12),

              if (treasurer.isNotEmpty)
                Expanded(child: _employeeCard(employee:treasurer.first,width: 140,height: 140,fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔥 EMPLOYEE CARD
  Widget _employeeCard({required Data employee,required double height,required double width,required double fontSize}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        /// 🔥 Soft Black Border
        border: Border.all(
          color: Colors.black.withOpacity(0.08),
          width: 1,
        ),

        /// 🔥 Soft Shadow
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                height: height,
                width: width,
                child: employee.profileImg != null &&
                    employee.profileImg!.isNotEmpty
                    ? Image.network(
                  "${ApiConstants.baseUrl}${employee.profileImg}",
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.person, size: 100),
                    );
                  },
                )
                    : Container(
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.person, size: 100),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// NAME
            Text(
              employee.name ?? "",
              textAlign: TextAlign.center,
              style:  TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: Colors.black
              ),
            ),

            const SizedBox(height: 6),

            /// DESIGNATION
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                employee.designation ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2E5FC0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
