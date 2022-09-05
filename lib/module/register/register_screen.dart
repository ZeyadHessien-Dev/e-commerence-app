import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/shop_layout/layout_screen.dart';
import 'package:shop_application/module/register/register_cubit/cubit.dart';
import 'package:shop_application/module/register/register_cubit/states.dart';
import 'package:shop_application/shared/components/components.dart';
import 'package:shop_application/shared/network/local/cache_helper.dart';
import '../../shared/components/constants.dart';
import '../home/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterShopLayoutCubit, RegisterShopLayoutStates>(
      listener: (context, state) {
        if (state is SuccessRegisterUserState) {
          if (state.registerModel.status!) {
            buildToast(
              message: state.registerModel.message!,
              state: Cases.SUCCESS,
            ).then((value) {
              CacheHelper.setData(key: 'token', value: state.registerModel.data!.token);
              navigateTo(context, ShopLayoutScreen());
            });
          } else {
            buildToast(
              message: state.registerModel.message!,
              state: Cases.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = RegisterShopLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Register To Browse Our Sales',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultTextForm(
                        controller: nameController,
                        labelText: 'Name',
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name Must Not Be Null';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextForm(
                        controller: emailController,
                        labelText: 'Email',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email Must Not Be Null';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextForm(
                        controller: passwordController,
                        labelText: 'Password',
                        prefixIcon: Icons.lock,
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubit.changePassword();
                          },
                          icon: cubit.iconShow,
                        ),
                        obscureText: cubit.isShow,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password Must Not Be Null';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextForm(
                        controller: phoneController,
                        labelText: 'Phone',
                        prefixIcon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone Must Not Be Null';
                          }
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.registerUser(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        text: 'LOGIN',
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account',
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            child: const Text(
                              'REGISTER NOW',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
