import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/features/technicians/logic/technicians_cubit.dart';
import 'package:mo3tarib/features/technicians/model/technicians_model.dart';

class HomeTechnicalsSection extends StatefulWidget {
  const HomeTechnicalsSection({super.key, });
  static List<TechnicalsModel> users = [
    TechnicalsModel(
        firstName: "Omar", lastName: "Adel", departmentName: "نجار", id: "1"),
    TechnicalsModel(
        firstName: "Mohab", lastName: "Adel", departmentName: "نجار", id: "2"),
    TechnicalsModel(
        firstName: "Ahmed", lastName: "Adel", departmentName: "نجار", id: "2"),
    TechnicalsModel(
        firstName: "Ebrahim",
        lastName: "Adel",
        departmentName: "نجار",
        id: "2"),
    TechnicalsModel(
        firstName: "Eslam", lastName: "Adel", departmentName: "نجار", id: "2"),
  ];

  @override
  State<HomeTechnicalsSection> createState() => _HomeTechnicalsSectionState();
}

class _HomeTechnicalsSectionState extends State<HomeTechnicalsSection> {
  @override
  void initState() {
    context.read<TechniciansCubit>().getTechnicians();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechniciansCubit, TechniciansState>(
      builder: (context, state) {
        if (state is TechniciansLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TechniciansError) {
          return Center(child: Text(state.message ?? "Something went wrong"));
        } else {
          final List<TechnicalsModel>? technicals =
              state is TechniciansSuccess ? state.technicians : [];
          return ListView.builder(
            itemCount: technicals?.length ?? 10,
            itemBuilder: (context, index) {
              final name =
                  "${technicals?[index].firstName ?? "Omar"} ${technicals?[index].lastName ?? "Adel"}";
              final letter = name.isNotEmpty ? name[0].toUpperCase() : "O";
              final color = _generateColor(
                  technicals?[index].firstName ?? "Omar");

              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: color,
                  child: Text(
                    letter,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  name,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  technicals?[index].departmentName ?? "نجار",
                  style: TextStyle(fontSize: 14.sp),
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    // Navigate to the details screen
                  },
                  child: const Text(
                    "تواصل",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  /// Generates a color based on the department name with only three dark colors
  Color _generateColor(String name) {
    final hash = name.codeUnits.fold(0, (prev, element) => prev + element);
    const colors = [
      Color(0xFFC14600), // Dark Blue-Gray
      Color(0xFFE73879), // Dark Gray
      Color(0xFF7E1891), // Dark Brown
    ];
    return colors[hash % colors.length];
  }
}
