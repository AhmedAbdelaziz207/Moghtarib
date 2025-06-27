import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3tarib/features/home/logic/home_cubit.dart';

class ApartmentOrTechnicalDropdown extends StatefulWidget {
  const ApartmentOrTechnicalDropdown({super.key});

  @override
  State<ApartmentOrTechnicalDropdown> createState() => _ApartmentOrTechnicalDropdownState();
}

class _ApartmentOrTechnicalDropdownState extends State<ApartmentOrTechnicalDropdown> {
  String selectedValue = 'شقة';

  final List<String> options = [
    'شقة',
    'صنايعي',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality( // Ensures RTL layout
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ما تبحث عنه؟',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedValue,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderSide:  BorderSide.none
              ),
            ),
            icon: const Icon(Icons.arrow_drop_down),
            items: options.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, textAlign: TextAlign.right),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
              if (selectedValue == 'شقة') {
                context.read<HomeCubit>().navigateToApartment();
              }else{
                context.read<HomeCubit>().navigateToTechnical();
              }

            },
          ),
        ],
      ),
    );
  }
}
