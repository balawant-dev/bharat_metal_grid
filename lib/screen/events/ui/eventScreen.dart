import 'package:bharat_metal_grid/widget/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/api_constants.dart';
import '../bloc/eventsBloc.dart';
import '../bloc/eventsEvent.dart';
import '../bloc/eventsState.dart';
import '../model/getEventModel.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EventsBloc>().add(FetchEventsEvent(context: context));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: const CustomAppBar(
        title: "Events",
        showBackButton: true,
        isHome: true,
      ),
      body: BlocBuilder<EventsBloc, EventsState>(
        builder: (context, state) {

          if (state.getAllEventModel == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final events = state.getAllEventModel!.data ?? [];

          if (events.isEmpty) {
            return const Center(child: Text("No events available"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return _eventCard(event);
            },
          );
        },
      ),
    );
  }

  /// ---------------- EVENT CARD ----------------

  Widget _eventCard(EventsData event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        /// Soft Border
        border: Border.all(
          color: Colors.black.withOpacity(0.05),
        ),

        /// Soft Shadow
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// EVENT IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(18),
            ),
            child: SizedBox(
              height: 190,
              width: double.infinity,
              child: event.images != null &&
                  event.images!.isNotEmpty
                  ? Image.network(
                "${ApiConstants.baseUrl}${event.images!.first}",
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _imagePlaceholder(),
              )
                  : _imagePlaceholder(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// TITLE
                Text(
                  event.title ?? "Untitled Event",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 10),


                /// DATE + TIME ROW
                Row(
                  children: [

                    const Icon(Icons.calendar_today,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                        formatIndianDate(event.date),
                      style: const TextStyle(color: Colors.grey),
                    ),


                  ],
                ),              Row(
                  children: [




                    const Icon(Icons.access_time,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                        "${formatIndianTime(event.startTime)} - ${formatIndianTime(event.endTime)}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// DESCRIPTION
                Text(
                  event.description ?? "",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  String formatIndianDate(String? date) {
    if (date == null || date.isEmpty) return "N/A";
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat("dd MMMM yyyy").format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  String formatIndianTime(String? time) {
    if (time == null || time.isEmpty) return "";
    try {
      final parsedTime = DateFormat("HH:mm").parse(time);
      return DateFormat("hh:mm a").format(parsedTime);
    } catch (e) {
      return time;
    }
  }
  Widget _imagePlaceholder() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(
          Icons.image,
          size: 60,
          color: Colors.grey,
        ),
      ),
    );
  }
}