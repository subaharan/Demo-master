import 'package:equatable/equatable.dart';

abstract class DemoEvent extends Equatable {
  const DemoEvent();
}

class GetDemoList extends DemoEvent {

  GetDemoList();


  @override
  // TODO: implement props
  List<Object> get props => [];

  @override
  String toString() {return 'GetDemoList{}';}
}

class SearchList extends DemoEvent {
  final String searchString;
  SearchList({this.searchString});

  @override
  // TODO: implement props
  List<Object> get props => [];

  @override
  String toString() {return 'SearchList{}';}
}