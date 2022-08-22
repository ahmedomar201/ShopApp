import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/models/search_model.dart';
import 'package:marketapp/modules/search/search_states.dart';
import 'package:marketapp/shared/componets/tasks.dart';
import 'package:marketapp/shared/network/remote/dio_helper.dart';
import '../../shared/network/remote/end_points.dart';

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