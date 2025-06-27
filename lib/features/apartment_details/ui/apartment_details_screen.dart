import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/routing/routes.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';
import 'package:mo3tarib/features/apartment_details/widget/apartment_images_section.dart';
import 'package:mo3tarib/features/register/model/user_model.dart';
import '../../../core/widgets/map_screen.dart';
import '../widget/comments_section.dart';

class ApartmentDetailsScreen extends StatefulWidget {
  const ApartmentDetailsScreen({super.key, this.apartment});

  final ApartmentModel? apartment;

  @override
  State<ApartmentDetailsScreen> createState() => _ApartmentDetailsScreenState();
}

class _ApartmentDetailsScreenState extends State<ApartmentDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(
              chat,
              arguments: UserModel(
                id: widget.apartment!.userId,
                userName: widget.apartment!.userName,
                whatsappNumber: widget.apartment!.userWhatsapp,
                phoneNumber: widget.apartment!.userPhone,
              ),
            );
          },
          child: const Text(
            'تواصل مع العميل',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ApartmentImagesSection(apartment: widget.apartment!),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.apartment?.price} ج م',
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoChip(Icons.person, widget.apartment?.userName ?? ""),
                        _infoChip(Icons.bed,
                            widget.apartment?.numOfRooms?.toString() ?? ''),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoChip(Icons.location_on,
                            widget.apartment?.location ?? ''),
                        _infoChip(Icons.square_foot,
                            '${widget.apartment?.distanceByMeters} م'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.red.shade100,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.sync,
                                color: widget.apartment!.isRent!
                                    ? Colors.red
                                    : Colors.green,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.apartment!.isRent!
                                    ? 'غير متوفر'
                                    : 'متوفر',
                                style: TextStyle(
                                  color: widget.apartment!.isRent!
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapScreen(
                              late: widget.apartment!.addressLat.toString(),
                              long: widget.apartment!.addressLong.toString(),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 0,
                        color: Colors.grey.withOpacity(0.2),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'عرض الموقع',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.orange,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CommentsSection(apartment: widget.apartment!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(width: 4),
          Icon(icon, size: 16),
        ],
      ),
    );
  }
}
