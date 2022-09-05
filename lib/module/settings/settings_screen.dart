import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/shop_layout/cubit_layout/cubit.dart';
import 'package:shop_application/layout/shop_layout/cubit_layout/states.dart';
import 'package:shop_application/model/profile_model.dart';
import 'package:shop_application/model/update_model.dart';
import 'package:shop_application/module/login/login_screen.dart';
import 'package:shop_application/shared/network/local/cache_helper.dart';
import '../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        var cubitUpdate = ShopLayoutCubit.get(context).updateProfileModel;
        var cubitProfile = ShopLayoutCubit.get(context).profileModel;
        if (state is SuccessUpdateProfileState) {
          nameController.text = cubitUpdate!.data!.name!;
          emailController.text = cubitUpdate.data!.email!;
          phoneController.text = cubitUpdate.data!.phone!;
        }
        if (cubitProfile != null && state is! SuccessUpdateProfileState) {
          nameController.text = cubitProfile.data!.name!;
          emailController.text = cubitProfile.data!.email!;
          phoneController.text = cubitProfile.data!.phone!;
        }
        return cubitProfile != null
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        defaultTextForm(
                          controller: nameController,
                          labelText: 'Name',
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextForm(
                          controller: emailController,
                          labelText: 'Email',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextForm(
                          controller: phoneController,
                          labelText: 'Phone',
                          prefixIcon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        defaultButton(
                          onPressed: () {
                            CacheHelper.removeData(key: 'token').then((value) {
                              navigateTo(context, LoginScreen());
                            });
                          },
                          text: 'Log Out',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultButton(
                          onPressed: () {
                            cubit.updateProfile(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          },
                          text: 'Update',
                        ),
                        if (state is LoadingUpdateProfileState)
                          const SizedBox(height: 7.5,),
                        if (state is LoadingUpdateProfileState)
                          const LinearProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
