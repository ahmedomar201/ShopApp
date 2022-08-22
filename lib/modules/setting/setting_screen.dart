import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/layout/cubit_layout.dart';
import 'package:marketapp/layout/states_layout.dart';
import 'package:marketapp/shared/componets/tasks.dart';
// ignore: must_be_immutable
class SettingScreen extends StatelessWidget {
  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var phoneController =TextEditingController();
  var fromKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopStates>(
      listener:(context,state) {},
      builder:(context,state)=>BuildCondition(
        condition: ShopLayoutCubit.get(context).userModel!=null,
        builder: (context) {
          var model=ShopLayoutCubit.get(context).userModel;
          nameController.text=model!.data!.name!;
          emailController.text=model.data!.email!;
          phoneController.text=model.data!.phone!;

          return SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: fromKey,
              child: Column(
                children:
                [
                  if(state is ShopLoadingUpdateUserStates)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    controller:nameController ,
                    keyboardType:TextInputType.name,
                    onFieldSubmitted: (String value){
                      print(value);
                    },
                    decoration:InputDecoration(
                      labelText:"Name",
                      prefixIcon: Icon(
                          Icons.person
                      ),
                      border:OutlineInputBorder(),
                    ),
                    validator:(value) {
                      if(value!.isEmpty){
                        return "name must not be empty ";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller:emailController ,
                    keyboardType:TextInputType.emailAddress,
                    onFieldSubmitted: (String value){
                      print(value);
                    },
                    decoration:InputDecoration(
                      labelText:"Email address",
                      prefixIcon: Icon(
                          Icons.email
                      ),
                      border:OutlineInputBorder(),
                    ),
                    validator:(value) {
                      if(value!.isEmpty){
                        return "email address must not be empty ";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller:phoneController ,
                    keyboardType:TextInputType.phone,
                    onFieldSubmitted: (String value){
                      print(value);
                    },
                    decoration:InputDecoration(
                      labelText:"Phone",
                      prefixIcon: Icon(
                          Icons.phone
                      ),
                      border:OutlineInputBorder(),
                    ),
                    validator:(value) {
                      if(value!.isEmpty){
                        return "phone must not be empty ";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width:double.infinity,
                    color: Colors.blue,
                    child: MaterialButton(onPressed: (){
                      signOut(context);
                      },
                      child: Text("LOGOUT",
                        style: TextStyle(
                            color: Colors.white
                        ),),),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width:double.infinity,
                    color: Colors.blue,
                    child: MaterialButton(onPressed: (){
                      if(fromKey.currentState!.validate())
                      {
                        ShopLayoutCubit.get(context).updateUserData(
                            name: nameController.text,
                            email:emailController.text ,
                            phone:phoneController.text);
                      }

                    },
                      child: Text("UPDATE",
                        style: TextStyle(
                            color: Colors.white
                        ),),),
                  ),
                ],
              ),
            ),
        ),
          );
        },
        fallback: (context)=>Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
