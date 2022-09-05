import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/shop_layout/cubit_layout/cubit.dart';
import 'package:shop_application/layout/shop_layout/cubit_layout/states.dart';
import 'package:shop_application/model/search_model.dart';
import 'package:shop_application/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        var modelSearch = ShopLayoutCubit.get(context).searchModel;

        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultTextForm(
                  controller: searchController,
                  labelText: 'Search',
                  prefixIcon: Icons.search,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (value) {
                    cubit.getSearch(value);
                  },
                ),
                if (state is LoadingSearchState)
                  const SizedBox(
                    height: 7.5,
                  ),
                if (state is LoadingSearchState)
                  const LinearProgressIndicator(),
                if (modelSearch != null)
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildSearch(modelSearch, context, index),
                      separatorBuilder: (context, index) => divideBy(),
                      itemCount: modelSearch.data!.data!.length,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSearch(SearchModel model, context, index) => Container(
    height: 200,
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.data!.data![index].image!),
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
                  model.data!.data![index].name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.data!.data![index].price}',
                      style:
                      Theme.of(context).textTheme.headline5!.copyWith(
                        fontSize: 12.0,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (model.data!.data![index].discount != 0)
                      Text(
                        '${model.data!.data![index].oldPrice}',
                        style:
                        Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 10.0,
                          color: Colors.grey,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
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
