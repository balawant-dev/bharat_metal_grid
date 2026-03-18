
import 'package:flutter/material.dart';

import '../../../app/theme/color_resource.dart';
import '../../../widget/customAppbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  final List<NotificationModel> notifications = [
    NotificationModel(
      image: 'https://cdn-icons-png.flaticon.com/512/1827/1827392.png',
      title: 'GST Notification',
      time: '1h ago',
      isRead: false,
    ),
    NotificationModel(
      image: 'https://cdn-icons-png.flaticon.com/512/1827/1827349.png',
      title: 'New Order Received',
      time: '3h ago',
      isRead: true,
    ),
    NotificationModel(
      image: 'https://cdn-icons-png.flaticon.com/512/190/190411.png',
      title: 'Payment Credited',
      time: 'Yesterday',
      isRead: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notification',showBackButton: true,),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final data = notifications[index];
          return notificationCard(data);
        },
      ),
    );
  }

  Widget notificationCard(NotificationModel data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorResource.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              data.image,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.notifications, size: 40);
              },
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
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

          if (!data.isRead)
            Container(
              height: 8,
              width: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF073080),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}


class NotificationModel {
  final String image;
  final String title;
  final String time;
  final bool isRead;

  NotificationModel({
    required this.image,
    required this.title,
    required this.time,
    required this.isRead,
  });
}
 