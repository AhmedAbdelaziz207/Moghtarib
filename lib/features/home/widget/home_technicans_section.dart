import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/routing/routes.dart';
import 'package:mo3tarib/features/home/logic/home_cubit.dart';
import 'package:mo3tarib/features/register/model/user_model.dart';

class HomeTechnicalsSection extends StatefulWidget {
  const HomeTechnicalsSection({super.key});

  @override
  State<HomeTechnicalsSection> createState() => _HomeTechnicalsSectionState();
}

class _HomeTechnicalsSectionState extends State<HomeTechnicalsSection> {
  @override
  void initState() {
    context.read<HomeCubit>().getTechnicals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        if (state is GetTechnicalsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetTechnicalsError) {
          return Center(child: Text(state.message));
        } else {
          List<UserModel> users = state is GetTechnicals ? state.techs : [];
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: state is GetTechnicals ? state.techs.length : 0,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, chat, arguments: users[index]);
                  },
                  leading: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.orange.withOpacity(.3),
                    child: Text(
                      users[index].firstName!.substring(0, 1),
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    "${users[index].firstName} ${users[index].lastName}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                  subtitle: Text(
                    users[index].departmentName.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14.sp,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 20.sp),
                );
              },
            ),
          );
        }
      },
    );
  }
}
