import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../department/logic/department_cubit.dart';
import '../../department/logic/department_state.dart';
import '../logic/register_cubit.dart';

class ProfessionDropdown extends StatefulWidget {
  const ProfessionDropdown({super.key});

  @override
  State<ProfessionDropdown> createState() => _ProfessionDropdownState();
}

class _ProfessionDropdownState extends State<ProfessionDropdown> {
  int? selectedDepartmentId; // To store the selected department ID

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DepartmentCubit, DepartmentState>(
      builder: (context, state) {
        if (state is DepartmentLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DepartmentLoaded) {
          final departments = state.departments;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<int>(
                value: selectedDepartmentId,
                hint: const Text('اختر المهنة'),
                items: departments
                    ?.map(
                      (department) => DropdownMenuItem<int>(
                    value: department.id, // Use department ID as the value
                    child: Text(department.name??""),
                  ),
                )
                    .toList(),
                onChanged: (value) {

                  context.read<RegisterCubit>().selectedDepartmentId = value;

                  setState(() {
                    selectedDepartmentId = value; // Update the selected department ID
                  });
                  // Handle the selected department ID here
                  log('Selected Department ID: $selectedDepartmentId');
                },
                decoration:  InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                ),
              ),
            ],
          );
        } else if (state is DepartmentError) {
          return const Center(
            child: Text(
              'حدث خطأ ما ',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        return Container();
      },
    );
  }
}
