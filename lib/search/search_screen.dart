import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/search/search_cubit.dart';
import 'package:marketapp/search/search_states.dart';
import 'package:marketapp/tasks.dart';
// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  var fromKey=GlobalKey<FormState>();
  var searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener:(context,state){},
        builder:(context,state) {
          return Scaffold(
            appBar:AppBar() ,
            body: Form(
              key: fromKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller:searchController,
                      keyboardType:TextInputType.text,
                      onFieldSubmitted: (String text){

                          SearchCubit.get(context).userSearch(text);
                      },
                      decoration:InputDecoration(
                        labelText:"Search",
                        prefixIcon: Icon(
                            Icons.search
                        ),
                        border:OutlineInputBorder(),
                      ),
                      validator:(value) {
                        if(value!.isEmpty){
                          return "enter text to search ";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if(state is SearchLoading)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if(state is SearchSuccess)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder:(context,index)=>
                              buildListProduct(SearchCubit.get(context).searchModel!.data!.data![index],context,oldPrice: false),
                          separatorBuilder: (context,index)=>myDivider(),
                          itemCount:SearchCubit.get(context).searchModel!.data!.data!.length),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
