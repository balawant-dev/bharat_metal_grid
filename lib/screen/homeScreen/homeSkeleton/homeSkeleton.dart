import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;

  const ShimmerBox({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
     // padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔹 HEADER
          ShimmerBox(
            height: 280,
            width: width,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(90)),
          ),

          const SizedBox(height: 20),

          /// 🔹 QUICK ACTION TITLE
          const ShimmerBox(height: 20, width: 120),

          const SizedBox(height: 12),

          /// 🔹 QUICK ACTION GRID
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.4,
            ),
            itemBuilder: (context, index) {
              return const ShimmerBox(
                height: 120,
                width: double.infinity,
              );
            },
          ),

          const SizedBox(height: 24),

          /// 🔹 INDUSTRY NEWS TITLE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              ShimmerBox(height: 20, width: 140),
              ShimmerBox(height: 20, width: 60),
            ],
          ),

          const SizedBox(height: 12),

          /// 🔹 NEWS LIST
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return const ShimmerBox(
                  height: 220,
                  width: 180,
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          /// 🔹 LATEST NOTICE TITLE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              ShimmerBox(height: 20, width: 140),
              ShimmerBox(height: 20, width: 60),
            ],
          ),

          const SizedBox(height: 12),

          /// 🔹 NOTICE CARD
          const ShimmerBox(
            height: 220,
            width: double.infinity,
          ),

        ],
      ),
    );
  }
}
