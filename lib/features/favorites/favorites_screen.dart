import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/features/favorites/logic/favorites_cubit.dart';
import 'package:mo3tarib/features/favorites/widget/favorite_card.dart';
import '../../core/theme/colors.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    context.read<FavoritesCubit>().getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        color: primaryColor,
        onRefresh: () async => context.read<FavoritesCubit>().getFavorites(),
        child: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return Center(
                  child: CircularProgressIndicator(
                color: primaryColor,
              ));
            }

            if (state is FavoritesError) {
              return Center(
                  child: Text(
                state.message,
                style: TextStyle(color: Colors.red, fontSize: 16.sp),
              ));
            }

            if (state is FavoritesLoaded) {
              if (state.apartments.isEmpty) {
                return const Center(child: Text("لا يوجد عقارات في المفضلة"));
              }

              return Column(
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .6,
                      ),
                      itemCount: state.apartments.length,
                      itemBuilder: (context, index) => FavoriteCard(
                        apartment: state.apartments[index],
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
