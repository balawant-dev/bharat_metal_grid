import 'package:flutter/material.dart';

import '../../../../app/router/navigation/nav.dart';
import '../../../../app/router/navigation/routes.dart';
import '../../../../app/theme/color_resource.dart';
import '../../../../widget/custom_text.dart';

class IndustryNewsCard extends StatefulWidget {
  final String image;
  final String title;
  final String id;

  const IndustryNewsCard({super.key, required this.title, required this.image,required this.id});

  @override
  State<IndustryNewsCard> createState() => _IndustryNewsCardState();
}

class _IndustryNewsCardState extends State<IndustryNewsCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Nav.push(context, Routes.industryDetail, extra:widget.id);
      },
      child: Container(
        padding: EdgeInsets.all(5),
        width: 130,
        height: 210,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFF150E1F),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              widget.image,
              height: 90,
              width: 120,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTIH6UCBNTMummUP7XFb1fTkcv0ZgAY6YZ3VFHArGvlaEoNtte4',
                  // fit: BoxFit.cover,
                  height: 90,
                  width: 120,
                );
              },
            ),
            Text(
              widget.title,maxLines: 3,style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: ColorResource.white,

            ),

            ),
            SizedBox(height: 5),
            Container(
              width: 120,
              height: 20,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, 0.50),
                  end: Alignment(1.00, 0.50),
                  colors: [const Color(0xFF2F60C2), const Color(0xFF042C7A)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: CustomText(
                '5 MINS READ',
                size: 8,
                weight: FontWeight.w600,
                color: ColorResource.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
