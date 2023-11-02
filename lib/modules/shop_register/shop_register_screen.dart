import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constant.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../layout/shop_layout.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  ShopRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context) => ShopRegisterCubit() ,
      child: BlocConsumer<ShopRegisterCubit , ShopRegisterStates>(
        listener: (BuildContext context, Object? state) {
          if (state is ShopRegisterSuccessState)
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
        builder: (context , state)
        {
          var cubit =ShopRegisterCubit.get(context);
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            label: 'User Name',
                            prefix: Icons.person,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return'please enter your name';
                              }
                            }
                        ),
                        SizedBox(
                          height: 20,
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
                            suffix: ShopRegisterCubit.get(context).suffix,
                            onSubmit: (value){},
                            isPassword: ShopRegisterCubit.get(context).isPassword,
                            suffixPressed: (){
                              ShopRegisterCubit.get(context).changePasswordVisibility();
                            },
                            validate: (String? value){
                              if(value!.isEmpty){
                                return'password is too short';
                              }
                            }
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            label: 'phone',
                            prefix: Icons.phone,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return'please enter your phone';
                              }
                            }
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder:(context) => defaultButton(
                              function:(){
                                CacheHelper.removeDate(key: 'token');
                                if(formKey.currentState!.validate()){
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                      phone: phoneController.text,
                                  );
                                }

                              },
                              text: 'register',
                              isUpperCase: true,

                            ),
                            fallback:(context) => CircularProgressIndicator() ,
                          ),
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

