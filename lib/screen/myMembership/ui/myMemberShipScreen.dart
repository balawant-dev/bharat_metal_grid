

import 'package:flutter/material.dart';

import '../../../widget/customAppbar.dart';

class MemberShipScreen extends StatefulWidget {
  const MemberShipScreen({super.key});

  @override
  State<MemberShipScreen> createState() => _MemberShipScreenState();
}

class _MemberShipScreenState extends State<MemberShipScreen> {
  final List<MemberShipModel> memberData = [
    MemberShipModel(
      image: 'https://cdn-icons-png.flaticon.com/512/1827/1827392.png',
      title: 'GST Notification',
      time: '1h ago',
    ),
    MemberShipModel(
      image: 'https://cdn-icons-png.flaticon.com/512/1827/1827349.png',
      title: 'New Order Received',
      time: '3h ago',
    ),
    MemberShipModel(
      image: 'https://cdn-icons-png.flaticon.com/512/190/190411.png',
      title: 'Payment Credited',
      time: 'Yesterday',
    ),
  ];

  final List<Map<String, String>> benefits = [
    {
      "image": "https://cdn-icons-png.flaticon.com/512/1827/1827392.png",
      "title": "Priority Trade Leads"
    },
    {
      "image": "https://cdn-icons-png.flaticon.com/512/1827/1827349.png",
      "title": "Verified Buyers"
    },
    {
      "image": "https://cdn-icons-png.flaticon.com/512/190/190411.png",
      "title": "Market Insights"
    },
    {
      "image": "https://cdn-icons-png.flaticon.com/512/1827/1827392.png",
      "title": "Premium Support"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Membership',showBackButton: true,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 85,
              decoration: BoxDecoration(
                  color: const Color(0xFFC39C48),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                  color: const Color(0xFFD4BA6B),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All India Metal Forum',
                        style: TextStyle(
                          color: const Color(0xFF191919),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 1.29,
                        ),
                      ),
                      Container(
                        width: 72,
                        height: 20,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF22C55E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Active',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 1.29,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MEMBER ID',
                        style: TextStyle(
                          color: const Color(0xFF191919),
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 1.80,
                        ),
                      ),
                      Text(
                        'VALID THRU',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: const Color(0xFF191919),
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 1.80,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#AIM- 98234',
                        style: TextStyle(
                          color: const Color(0xFF191919),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1.50,
                        ),
                      ),
                      Text(
                        'Oct 2024',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: const Color(0xFF191919),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1.50,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Membership Benefits',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            GridView.builder(
              itemCount: benefits.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                final item = benefits[index];
                return memberCard(
                  image: item['image']!,
                  title: item['title']!,
                );
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Recent Invoices',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            ListView.builder(
              itemCount: memberData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return MemberListData(memberData[index]);
              },
            ),
          ],
        ),
      ),
    );
  }



  Widget memberCard({
    required String image,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(image, height: 35, width: 35),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget MemberListData(MemberShipModel data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          )
        ],
      ),
      child: Row(
        children: [
          Image.network(data.image, height: 40, width: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(
                  data.time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Image.asset('assets/icon/download.png',height: 30,width: 30,)
        ],
      ),
    );
  }
}

class MemberShipModel {
  final String image;
  final String title;
  final String time;

  MemberShipModel({
    required this.image,
    required this.title,
    required this.time,
  });
}
