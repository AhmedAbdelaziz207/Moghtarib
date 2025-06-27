import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mo3tarib/core/widgets/custom_button.dart';
import 'package:mo3tarib/core/widgets/custom_text_field.dart';
import 'package:mo3tarib/features/access_apartmen_location/logic/access_location_cubit.dart';
import 'package:mo3tarib/features/access_apartmen_location/logic/access_location_state.dart';
import 'package:mo3tarib/features/add_edit_apartment/logic/apartment_cubit.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_params.dart';
import 'package:mo3tarib/features/add_edit_apartment/widget/apartment_images_section.dart';
import '../access_apartmen_location/access_location_screen.dart';

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

    priceController = TextEditingController(
        text: widget.params.apartment?.price?.toString() ?? '');
    numOfRoomsController = TextEditingController(
        text: widget.params.apartment?.numOfRooms?.toString() ?? '');
    cityController =
        TextEditingController(text: widget.params.apartment?.city ?? '');
    locationController =
        TextEditingController(text: widget.params.apartment?.location ?? '');

    selectedPropertyType =
        widget.params.apartment?.isRent == true ? "rent" : "private";
    selectedAvailability = widget.params.apartment != null ? "yes" : "no";
  }

  String? location = "";
  Position? position;

  @override
  void dispose() {
    priceController.dispose();
    numOfRoomsController.dispose();
    cityController.dispose();
    locationController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const ApartmentImagesSection(),
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
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            DropdownMenu(
                              dropdownMenuEntries: const [
                                DropdownMenuEntry(
                                    label: "ايجار", value: "rent"),
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
                  BlocBuilder<AccessLocationCubit, AccessLocationState>(
                    builder: (context, state) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined,
                                    color: Colors.blue),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider(
                                            create: (context) =>
                                                AccessLocationCubit(),
                                            child: AccessLocationScreen(
                                              onLocationPicked: (location) {
                                                log(" location: ${location?.latitude}, ${location?.longitude}");
                                              },
                                            ),
                                          ),
                                        )).then(
                                      (value) async {
                                        final Position? position = await context
                                            .read<AccessLocationCubit>()
                                            .getUserLocation();

                                        if (position != null) {
                                          log(" position: ${position.latitude}, ${position.longitude}");
                                          setState(() {
                                            this.position = position;
                                          });
                                        } else {
                                          log(" position: null");
                                        }
                                      },
                                    );
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
                            const Spacer(),
                            if (state is AccessLocationLoaded)
                              const Icon(Icons.check_circle,
                                  color: Colors.green),
                            SizedBox(
                              width: 20.w,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 30.h),
                  BlocConsumer<ApartmentCubit, ApartmentState>(
                    listener: (context, state) {
                      if (state is AddApartmentFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Text(state.message),
                          ),
                        );
                      }

                      if (state is AddApartmentSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("تم الاضافة بنجاح"),
                          ),
                        );

                        Navigator.pop(context);
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is AddApartmentSuccess ||
                        current is AddApartmentFailed ||
                        current is AddApartmentLoading,
                    builder: (context, state) {
                      return CustomElevatedButton(
                        child: state is AddApartmentLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "حفظ",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          context.read<ApartmentCubit>().addApartment(
                                apartment: ApartmentModel(
                                  city: cityController.text,
                                  village: locationController.text,
                                  location: locationController.text,
                                  price: int.parse(priceController.text),
                                  // ✅ Convert to int
                                  numOfRooms:
                                      int.parse(numOfRoomsController.text),
                                  // ✅ Convert to int
                                  type: 1,
                                  addressLat: position?.latitude ?? 30.0,
                                  addressLong: position?.longitude ?? 30.0,
                                  isRent: selectedPropertyType != "rent",
                                ),
                              );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(30.5482967, 30.9963733);

      if (placeMarks.isNotEmpty) {
        final Placemark place = placeMarks[0];
        setState(() {
          location = "${place.locality}, ${place.country}";
        });
        print(
            '📍 العنوان: ${place.street}, ${place.locality}, ${place.country}');
      }
    } catch (e) {
      print('❌ خطأ في الحصول على العنوان: $e');
    }
  }
}
