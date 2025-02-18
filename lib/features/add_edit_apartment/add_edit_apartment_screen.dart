import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/routing/routes.dart';
import 'package:mo3tarib/core/widgets/custom_button.dart';
import 'package:mo3tarib/core/widgets/custom_text_field.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_params.dart';
import 'package:mo3tarib/features/add_edit_apartment/widget/apartment_images_section.dart';

class AddEditApartmentScreen extends StatefulWidget {
  const AddEditApartmentScreen({super.key, required this.params});

  final ApartmentDetailsParams params;

  @override
  State<AddEditApartmentScreen> createState() => _AddEditApartmentScreenState();
}

class _AddEditApartmentScreenState extends State<AddEditApartmentScreen> {
  late TextEditingController priceController;
  late TextEditingController numOfRoomsController;
  late TextEditingController cityController;
  late TextEditingController locationController;

  String? selectedPropertyType;
  String? selectedAvailability;

  @override
  void initState() {
    super.initState();

    priceController =
        TextEditingController(text: widget.params.apartment?.price?.toString() ?? '');
    numOfRoomsController = TextEditingController(
        text: widget.params.apartment?.numOfRooms?.toString() ?? '');
    cityController = TextEditingController(text: widget.params.apartment?.city ?? '');
    locationController =
        TextEditingController(text: widget.params.apartment?.location ?? '');

    selectedPropertyType =
        widget.params.apartment?.isRent == true ? "rent" : "private";
    selectedAvailability = widget.params.apartment != null ? "yes" : "no";
  }

  @override
  void dispose() {
    priceController.dispose();
    numOfRoomsController.dispose();
    cityController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ApartmentImagesSection(
                  initialImageUrls: widget.params.apartment?.imagesURL ?? [],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: priceController,
                        hintText: "السعر",
                        fillColor: Colors.blueGrey.withOpacity(.2),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomTextFormField(
                        controller: numOfRoomsController,
                        hintText: "عدد الغرف",
                        fillColor: Colors.blueGrey.withOpacity(.2),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 21.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: cityController,
                        hintText: "المدينة",
                        fillColor: Colors.blueGrey.withOpacity(.2),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomTextFormField(
                        controller: locationController,
                        hintText: "الحي/الشارع",
                        fillColor: Colors.blueGrey.withOpacity(.2),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 21.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "نوع العقار",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                          SizedBox(height: 8.h),
                          DropdownMenu(
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(label: "ايجار", value: "rent"),
                              DropdownMenuEntry(
                                  label: "تمليك", value: "private"),
                            ],
                            initialSelection: selectedPropertyType,
                            onSelected: (value) {
                              setState(() {
                                selectedPropertyType = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "مازال متوفر؟",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                          SizedBox(height: 8.h),
                          DropdownMenu(
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(label: "نعم", value: "yes"),
                              DropdownMenuEntry(label: "لا", value: "no"),
                            ],
                            initialSelection: selectedAvailability,
                            onSelected: (value) {
                              setState(() {
                                selectedAvailability = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 21.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          color: Colors.blue),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, accessLocation);
                        },
                        child: Text(
                          "اختر الموقع",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                CustomElevatedButton(
                  child: Text(
                    "حفظ",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    // Save or update apartment logic
                  },
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
