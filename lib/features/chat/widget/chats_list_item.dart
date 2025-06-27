import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/constants/assets.dart';
import 'package:mo3tarib/core/routing/routes.dart';
import 'package:mo3tarib/features/register/model/user_model.dart';

class ChatsListItem extends StatelessWidget {
  const ChatsListItem({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, chat, arguments: user);
      },
      child: ListTile(
          leading: CircleAvatar(
            radius: 20.r,
            backgroundColor: Colors.grey.shade200,
            child: Text(
              "${user.firstName!.substring(0, 1)}${user.lastName!.substring(0, 1)}",
            ),
          ),
          title: Text(
            "${user.firstName}${user.lastName}",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
          ),
          subtitle: Text(
            user.email.toString(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 11.sp,
                ),
          ),
      )
    );
  }
}
