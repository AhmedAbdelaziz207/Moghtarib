import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/widgets/custom_text_field.dart';
import '../access_apartmen_location/access_location_screen.dart';
import '../access_apartmen_location/logic/access_location_cubit.dart';
import 'logic/apartment_cubit.dart';
import 'model/apartment_model.dart';

class EditApartmentScreen extends StatefulWidget {
  final ApartmentModel apartment;

  const EditApartmentScreen({super.key, required this.apartment});

  @override
  State<EditApartmentScreen> createState() => _EditApartmentScreenState();
}

class _EditApartmentScreenState extends State<EditApartmentScreen> {
  late TextEditingController priceController;
  late TextEditingController numOfRoomsController;
  late TextEditingController cityController;
  late TextEditingController locationController;

  String? selectedPropertyType;
  String? selectedAvailability;

  final formKey = GlobalKey<FormState>();

  Position? position;

  @override
  void initState() {
    super.initState();

    priceController =
        TextEditingController(text: widget.apartment.price?.toString() ?? '');
    numOfRoomsController = TextEditingController(
        text: widget.apartment.numOfRooms?.toString() ?? '');
    cityController = TextEditingController(text: widget.apartment.city ?? '');
    locationController =
        TextEditingController(text: widget.apartment.location ?? '');

    selectedPropertyType = widget.apartment.isRent == true ? "rent" : "private";
    selectedAvailability = widget.apartment.isRent == true ? "yes" : "no";

    position = Position(
      latitude: widget.apartment.addressLat ?? 30.0,
      longitude: widget.apartment.addressLong ?? 30.0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
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
      appBar: AppBar(
        title: const Text('تعديل بيانات الشقة'),
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: priceController,
                          hintText: "السعر",
                          fillColor: Colors.blueGrey.withOpacity(.2),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: CustomTextFormField(
                          controller: numOfRoomsController,
                          hintText: "عدد الغرف",
                          fillColor: Colors.blueGrey.withOpacity(.2),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: cityController,
                          hintText: "المدينة",
                          fillColor: Colors.blueGrey.withOpacity(.2),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: CustomTextFormField(
                          controller: locationController,
                          hintText: "الحي/الشارع",
                          fillColor: Colors.blueGrey.withOpacity(.2),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedPropertyType,
                          decoration:
                              const InputDecoration(labelText: 'نوع العقار'),
                          items: const [
                            DropdownMenuItem(
                                value: 'rent', child: Text('ايجار')),
                            DropdownMenuItem(
                                value: 'private', child: Text('تمليك')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedPropertyType = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedAvailability,
                          decoration:
                              const InputDecoration(labelText: 'مازال متوفر؟'),
                          items: const [
                            DropdownMenuItem(value: 'yes', child: Text('نعم')),
                            DropdownMenuItem(value: 'no', child: Text('لا')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedAvailability = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.location_on),
                    label: const Text("تعديل الموقع"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => AccessLocationCubit(),
                            child: AccessLocationScreen(
                              onLocationPicked: (loc) {
                                if (loc != null) {
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24),
                  BlocConsumer<ApartmentCubit, ApartmentState>(
                    listener: (context, state) {
                      if (state is AddApartmentSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("تم تحديث الشقة بنجاح"),
                          ),
                        );
                        Navigator.pop(context);
                      } else if (state is AddApartmentFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.message),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;

                          final updatedApartment = widget.apartment;

                          context.read<ApartmentCubit>().editApartment(
                                apartment: updatedApartment!,);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 30),
                        ),
                        child: state is AddApartmentLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'حفظ التعديلات',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
