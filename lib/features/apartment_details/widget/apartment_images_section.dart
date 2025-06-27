import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3tarib/features/add_edit_apartment/logic/apartment_cubit.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';

import '../../../core/network/api_endpoints.dart';
import '../../favorites/logic/favorites_cubit.dart';

class ApartmentImagesSection extends StatefulWidget {
  const ApartmentImagesSection({super.key, required this.apartment});

  final ApartmentModel apartment;

  @override
  State<ApartmentImagesSection> createState() => _ApartmentImagesSectionState();
}

class _ApartmentImagesSectionState extends State<ApartmentImagesSection> {
  int currentIndex = 0;
  bool isFavourite = false;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    checkIsFavourite();
    _pageController = PageController();
  }

  Future<void> checkIsFavourite() async {
    await context.read<FavoritesCubit>().isFavorite(widget.apartment.id!).then((value) {
      log("is favorite: $value , id: ${widget.apartment.id}");

      setState(() {
        isFavourite = value;
      });
    });

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = widget.apartment.imagesURL ?? [];

    return Container(
      height: 300,
      color: Colors.white,
      child: Row(
        children: [
          // Main Image PageView
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          ApiEndPoints.imagesUrl + images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: BlocConsumer<FavoritesCubit, FavoritesState>(
                    listenWhen: (prev, curr) =>
                        curr is AddedFavoriteSuccess ||
                        curr is DeleteFavoriteSuccess,
                    listener: (context, state) {
                      if (state is AddedFavoriteSuccess) {
                        setState(() => isFavourite = true);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("تم الاضافة للمفضلة"),
                          ),
                        );
                      } else if (state is DeleteFavoriteSuccess) {
                        setState(() => isFavourite = false);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("تم الحذف من المفضلة"),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is IsFavoritesLoading;
                      bool isFav = isFavourite;
                      log("is favorite: $isFav");
                      return IconButton(
                        icon: isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? Colors.red : Colors.grey,
                              ),
                        onPressed: isLoading
                            ? null
                            : () {
                                if (isFav) {
                                  context
                                      .read<FavoritesCubit>()
                                      .removeFavoriteApartment(
                                          widget.apartment.id!);
                                } else {
                                  context
                                      .read<FavoritesCubit>()
                                      .addApartmentToFavorites(
                                          widget.apartment.id!);
                                }
                              },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Thumbnail Column
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                final isSelected = index == currentIndex;
                return GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding:
                        isSelected ? const EdgeInsets.all(2) : EdgeInsets.zero,
                    decoration: BoxDecoration(
                      border: isSelected
                          ? Border.all(color: Colors.orange, width: 2)
                          : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        ApiEndPoints.imagesUrl + images[index],
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
