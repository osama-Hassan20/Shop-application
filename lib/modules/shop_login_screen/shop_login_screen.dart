import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/network/local/cache_helper.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../shop_register/shop_register_screen.dart';


// ignore: must_be_immutable
class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  ShopLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit , ShopLoginStates>(

        listener: (BuildContext context, Object? state) {
          if (state is ShopLoginSuccessState)
            {
              if(state.loginModel.status == true)
                {
                  print(state.loginModel.message);
                  print(state.loginModel.data?.token);

                  ShowToast(
                      text: state.loginModel.message!,
                      state: ToastState.SUCCESS
                  );
                  CacheHelper.saveData(
                    key: 'token',
                    value: state.loginModel.data?.token,
                  ).then((value) {
                    token = state.loginModel.data!.token!;
                    navigateAndFinish(context, ShopLayout());
                  });


                }else{
                print(state.loginModel.message);
                ShowToast(
                    text:state.loginModel.message! ,
                    state: ToastState.ERROR
                );
              }
            }
        },
        builder: (BuildContext context, state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefix: Icons.email_outlined,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return'please enter your email address';
                              }
                            }
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            suffix: ShopLoginCubit.get(context).suffix,
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            suffixPressed: (){
                              ShopLoginCubit.get(context).changePasswordVisibility();
                            },
                            validate: (String? value){
                              if(value!.isEmpty){
                                return'password is too short';
                              }
                            }
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder:(context) => defaultButton(
                              function:(){
                                if(formKey.currentState!.validate()){
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,);
                                }

                              },
                              text: 'login',
                              isUpperCase: true,

                            ),
                            fallback:(context) => CircularProgressIndicator() ,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account',
                            ),
                            defaultTextButton(
                              function: (){

                                navigateTo(context, ShopRegisterScreen());
                              },
                              text: 'register',
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

      ),
    );
  }
}
