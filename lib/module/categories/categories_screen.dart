import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/shop_layout/cubit_layout/cubit.dart';
import 'package:shop_application/layout/shop_layout/cubit_layout/states.dart';
import 'package:shop_application/model/categories_model.dart';
import 'package:shop_application/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var modelCategories = ShopLayoutCubit.get(context).categoriesModel;
        return modelCategories != null
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildCategories(modelCategories, index, context),
                separatorBuilder: (context, index) => divideBy(),
                itemCount: modelCategories.data!.data!.length,
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget buildCategories(CategoriesModel categoriesModel, index, context) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(categoriesModel.data!.data![index].image!),
              width: 120,
              height: 120,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              categoriesModel.data!.data![index].name!,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward,
              ),
            ),
          ],
        ),
      );
}
