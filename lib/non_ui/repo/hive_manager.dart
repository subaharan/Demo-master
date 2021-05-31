import 'package:hive/hive.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/demo_model.dart';

class HiveManager{

 static storeData(List<DemoModel> items) async {
   var box = await Hive.openBox<DemoModel>('demo');

   var filteredData;
   if(box.values.length==0){
     box.addAll(items);
     // filteredData= box.values.where((element) => !items.contains(element)).toList();
     // box.addAll(filteredData);
   }/*else{
     box.addAll(items);
   }*/
}

static Future<List<DemoModel>> getSearchItem(String search) async {
   final box = await Hive.openBox<DemoModel>('demo');

   return box.values.where((element) => element.name.toLowerCase().contains(search.toLowerCase())).toList();

 }
}