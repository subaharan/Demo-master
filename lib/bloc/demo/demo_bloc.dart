import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphosis_flutter_demo/bloc/demo/demo_event.dart';
import 'package:morphosis_flutter_demo/bloc/demo/demo_state.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/demo_model.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/hive_manager.dart';

import 'package:rxdart/rxdart.dart';

import '../../non_ui/repo/api.dart';

class DemoBloc extends Bloc<DemoEvent, DemoState>{

  DemoBloc() : super(DemoStateEmpty());


  @override
  Stream<Transition<DemoEvent, DemoState>> transformEvents(
      Stream<DemoEvent> events,
      Stream<Transition<DemoEvent, DemoState>> Function(DemoEvent event, )
      transitionFn,) {
    return events.debounceTime(const Duration(milliseconds: 300)).switchMap(transitionFn);
  }

  @override
  Stream<DemoState> mapEventToState(DemoEvent event) async*{
    if(event is GetDemoList){
      yield DemoStateLoading();
      try{
        var response = await API.getDemoModel();

          Iterable list = response.data;
          List<DemoModel> modelList = list.map((model) => DemoModel.fromJson(model)).toList();;
          if(modelList.length >0){
            HiveManager.storeData(modelList);
            yield DemoStateSuccess(modelList);

          }else{
            yield DemoStateNoData();
          }

      }catch(error){
        yield DemoStateError(error.toString());
      }
    }else if(event is SearchList){
      List<DemoModel> modelList = await HiveManager.getSearchItem(event.searchString);
      if(modelList.length>0){
        yield DemoStateSuccess(modelList);
      }else{
        yield DemoStateNoData();
      }

    }
  }
}