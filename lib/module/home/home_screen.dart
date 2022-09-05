import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/shop_layout/cubit_layout/cubit.dart';
import 'package:shop_application/layout/shop_layout/cubit_layout/states.dart';

import '../../model/home_model.dart';
import '../../shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        if (state is SuccessFavoritesState) {
          buildToast(message: state.favoritesModel.message!, state: Cases.SUCCESS);
        }
      },
      builder: (context, state) {
        var modelHome = ShopLayoutCubit.get(context).homeModel;
        var modelCategories = ShopLayoutCubit.get(context).categoriesModel;
        if (modelHome != null && modelCategories != null) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: modelHome.data!.banners!
                      .map(
                        (e) => Image(
                          image: NetworkImage(e.image!),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 200,
                    initialPage: 0,
                    viewportFraction: 1.0,
                    reverse: false,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayInterval: const Duration(
                      seconds: 3,
                    ),
                    autoPlayAnimationDuration: const Duration(
                      seconds: 1,
                    ),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Categories',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                      Container(
                        height: 140,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            width: 120,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Image(
                                  image: NetworkImage(modelCategories
                                      .data!.data![index].image!),
                                  height: 120,
                                  width: 120,
                                ),
                                Container(
                                  width: 120,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  color: Colors.black,
                                  child: Text(
                                    modelCategories.data!.data![index].name!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 15.0,
                          ),
                          itemCount: modelCategories.data!.data!.length,
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        'Products',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[350],
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                    childAspectRatio: 1 / 1.56,
                    children: List.generate(
                      modelHome.data!.products!.length,
                      (index) => buildGrid(modelHome, index, context),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildGrid(HomeModel modelHome, index, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    modelHome.data!.products![index].image!,
                  ),
                  height: 200,
                  width: double.infinity,
                ),
                if (modelHome.data!.products![index].discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 6.5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    modelHome.data!.products![index].name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 16.0,
                          height: 1.34,
                        ),
                  ),
                  const SizedBox(
                    height: 7.5,
                  ),
                  Row(
                    children: [
                      Text(
                        '${modelHome.data!.products![index].price}',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 12.0,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (modelHome.data!.products![index].discount != 0)
                        Text(
                          '${modelHome.data!.products![index].oldPrice}',
                          style:
                          Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 10.0,
                            color: Colors.grey,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                            ShopLayoutCubit.get(context).favoritesMethod(modelHome.data!.products![index].id!);
                        },
                        icon: CircleAvatar(
                          backgroundColor: ShopLayoutCubit.get(context).favorites[modelHome.data!.products![index].id]! ?
                          Colors.blue : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
