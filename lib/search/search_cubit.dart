import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/models/search_model.dart';
import 'package:marketapp/network/remote/dio_helper.dart';
import 'package:marketapp/network/remote/end_points.dart';
import 'package:marketapp/search/search_states.dart';
import 'package:marketapp/tasks.dart';

class SearchCubit extends Cubit<SearchStates>
{
SearchCubit():super(SearchInitial());
static SearchCubit get(context)=> BlocProvider.of(context);

SearchModel? searchModel;

void userSearch(String text)
{
  emit(SearchLoading());
  DioHelper.postData(
      url: SEARCH,
      token: token,
  data:
  {
    'text':text
  } ).then((value)
  {
    searchModel=SearchModel.fromJson(value.data);
    emit(SearchSuccess());
  }).catchError((error)
  {
    emit(SearchError());
  });
}

}