import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserHomeHeaderSection extends StatefulWidget {
  const UserHomeHeaderSection({super.key, this.onSelected});

  final Function(String?)? onSelected;

  @override
  State<UserHomeHeaderSection> createState() => _UserHomeHeaderSectionState();
}

class _UserHomeHeaderSectionState extends State<UserHomeHeaderSection> {
  double distance = 1;
  final List<String> categories = [
    "شقة",
    "صنايعي",
  ];

  String selectedCategory = "شقة";

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (selectedCategory == "شقة")
        Expanded(
          child: Column(
            children: [
              Text(
                " نطاق البحث (كم)",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Slider(
                activeColor: CupertinoColors.activeOrange,
                divisions: 7,
                value: distance,
                label: "$distance",
                min: 1,
                max: 15,
                onChanged: (value) {
                  setState(() {
                    distance = value;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment:  CrossAxisAlignment.start,
            children: [
              Text(
                "ما تبحث عنه؟",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownMenu(

                onSelected: (value) {
                  widget.onSelected!(value);
                  setState(() {
                    selectedCategory = value??"";
                  });
                },
                initialSelection:selectedCategory,
                textStyle: TextStyle(fontSize: 14.sp),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                dropdownMenuEntries: categories
                    .map(
                      (e) => DropdownMenuEntry(
                        value: e,
                        label: e,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
