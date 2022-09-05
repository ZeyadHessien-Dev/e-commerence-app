import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/shop_layout/cubit_layout/cubit.dart';
import 'package:shop_application/layout/shop_layout/cubit_layout/states.dart';
import 'package:shop_application/model/get_favorites_model.dart';
import 'package:shop_application/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        if (state is SuccessFavoritesState) {
          buildToast(message: state.favoritesModel.message!, state: Cases.SUCCESS);
        }
      },
      builder: (context, state) {
        var modelFavorites = ShopLayoutCubit.get(context).getFavoritesModel;

        return modelFavorites != null
            ? ListView.separated(
                itemBuilder: (context, index) => buildFavorites(context, index,
                    modelFavorites.data!.data![index].product!),
                separatorBuilder: (context, index) => divideBy(),
                itemCount: modelFavorites.data!.data!.length,
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget buildFavorites(context, index, GetFavoritesProductModel model) =>
      Container(
        height: 200,
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: 150,
              height: 150,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.price}',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontSize: 12.0,
                                    color: Colors.blue,
                                  ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (model.discount! != 0)
                          Text(
                            '${model.oldPrice!}',
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      fontSize: 10.0,
                                      color: Colors.grey,
                                    ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopLayoutCubit.get(context).favoritesMethod(model.id!);
                          },
                          icon: CircleAvatar(
                            backgroundColor: ShopLayoutCubit.get(context).favorites[model.id!]! ?
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
            ),
          ],
        ),
      );
}
