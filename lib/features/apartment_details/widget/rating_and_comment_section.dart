import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingAndCommentSection extends StatefulWidget {
  const RatingAndCommentSection({super.key});

  @override
  State<RatingAndCommentSection> createState() =>
      _RatingAndCommentSectionState();
}

class _RatingAndCommentSectionState extends State<RatingAndCommentSection> {
  double _rating = 0;
  final TextEditingController _commentController = TextEditingController();
  List<Map<String, dynamic>> comments = [
    {"name": "Ali", "rating": 4.5, "comment": "شقة رائعة !"},
    {
      "name": "Maha",
      "rating": 3.0,
      "comment": "الشقة جيدة لكن يمكن تحسين بعض الأمور."
    },
  ];

  void _submitComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        comments.add({
          "name": "You", // You can replace this with the actual user’s name.
          "rating": _rating,
          "comment": _commentController.text,
        });
        _commentController.clear();
        _rating = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "التقييم والتعليقات",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.h),

        // Rating Input
        RatingBar.builder(
          initialRating: _rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
        ),

        SizedBox(height: 15.h),

        // Comment Input
        TextField(
          controller: _commentController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "اكتب تعليقك هنا...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        SizedBox(height: 10.h),

        // Submit Button
        ElevatedButton(
          onPressed: _submitComment,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text("إرسال", style: TextStyle(color: Colors.white)),
        ),

        SizedBox(height: 20.h),

        // Display Comments Section
        Text(
          "التعليقات السابقة",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 10.h),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              color: Colors.white,
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text(comments[index]["name"][0]),
                ),
                title: Text(comments[index]["name"]),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBarIndicator(
                      rating: comments[index]["rating"],
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20,
                    ),
                    SizedBox(height: 5.sp),
                    Text(comments[index]["comment"]),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
