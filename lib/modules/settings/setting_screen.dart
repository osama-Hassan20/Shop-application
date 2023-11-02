import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import 'edit_profile.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  var formKey =GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state) {},
      builder: (context,state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return
          ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) => SingleChildScrollView(

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 250.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImage(imagePath:'https://img.freepik.com/free-vector/hand-drawn-flat-design-palestine-national-emblems_23-2149377820.jpg?w=1060&t=st=1698882022~exp=1698882622~hmac=4c2db4fceda10d24d7ca08702857bad679057a869d1eeb299cde2a7c8d6b081e'),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                ),
                                height: 180.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://img.freepik.com/free-vector/hand-drawn-flat-design-palestine-national-emblems_23-2149377820.jpg?w=1060&t=st=1698882022~exp=1698882622~hmac=4c2db4fceda10d24d7ca08702857bad679057a869d1eeb299cde2a7c8d6b081e',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              radius: 66.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreenImage(imagePath:'https://img.freepik.com/free-vector/illustrated-peace-freedom-background_23-2148970288.jpg?w=740&t=st=1698881913~exp=1698882513~hmac=bb69a5bfdac42943d3c335e1035eb1cc8f784200a16b3e9019009789beb1dfde'),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage('https://img.freepik.com/free-vector/illustrated-peace-freedom-background_23-2148970288.jpg?w=740&t=st=1698881913~exp=1698882513~hmac=bb69a5bfdac42943d3c335e1035eb1cc8f784200a16b3e9019009789beb1dfde'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${model.data!.name!}',
                      style:TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      'Write Your bio',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Icon(Icons.call),
                        Text(
                          '${model.data!.phone!}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text(
                                    '180',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    'Posts',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              onTap: () {comingSoon();},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text(
                                    '265',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    'Photos',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              onTap: () {comingSoon();},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text(
                                    '10k',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    'Followers',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              onTap: () {comingSoon();},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text(
                                    '64',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    'Followings',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              onTap: () {comingSoon();},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              comingSoon();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Share Profile',
                                ),
                                SizedBox(width: 5,),
                                Icon(
                                  Icons.share,
                                  size: 16.0,
                                ),
                              ],
                            ),

                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              navigateTo(context, EditProfileScreen());
                            },
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Edi Profile',
                                ),
                                SizedBox(width: 10,),
                                Icon(
                                  Icons.edit,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          child: OutlinedButton(
                            style: ButtonStyle(

                                padding: MaterialStateProperty.all(EdgeInsets.zero),
                                minimumSize: MaterialStateProperty.all(Size(35, 35))
                            ),
                            onPressed: () {
                              comingSoon();
                            },
                            child:  Icon(
                              Icons.menu_outlined,
                              size: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              ShopCubit.get(context).currentIndex =0;
                              signOut(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Logout',
                                ),
                                SizedBox(width: 5,),
                                Icon(
                                  Icons.logout,
                                  size: 16.0,
                                ),
                              ],
                            ),

                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              comingSoon();
                            },
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Add Friend',
                                ),
                                SizedBox(width: 10,),
                                Icon(
                                  Icons.person_add,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );

      },
      
    );
  }
}
