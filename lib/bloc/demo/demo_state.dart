import 'package:equatable/equatable.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/demo_model.dart';


abstract class DemoState extends Equatable{
  const DemoState();

  @override
  List<Object> get props => [];
}

class DemoStateEmpty extends DemoState{

}

class DemoStateLoading extends DemoState{

}

class DemoStateSuccess extends DemoState{
 final List<DemoModel> demoModelList;

  const DemoStateSuccess(this.demoModelList);


  @override
  List<Object> get props => [demoModelList];

  @override
  String toString() => 'DemoStateSuccess { items: ${demoModelList} }';
}

class DemoStateError extends DemoState{

  final String error;
  const DemoStateError(this.error);

  @override
  List<Object> get props => [error];
}

class DemoStateNoData extends DemoState{

}