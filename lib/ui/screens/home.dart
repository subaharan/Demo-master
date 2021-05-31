import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphosis_flutter_demo/bloc/demo/demo_bloc.dart';

import 'package:morphosis_flutter_demo/bloc/demo/demo_event.dart';
import 'package:morphosis_flutter_demo/bloc/demo/demo_state.dart';
import 'package:morphosis_flutter_demo/ui/widgets/loader_widet.dart';
import 'package:morphosis_flutter_demo/ui/widgets/nodata_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchTextField = TextEditingController();
   DemoBloc _demoBloc;
   ScrollController _controller;

  @override
  void initState() {
    _searchTextField.text = "Search";
    _demoBloc = BlocProvider.of<DemoBloc>(context);
    super.initState();
    _demoBloc.add(GetDemoList());
    _controller=ScrollController();
  }

  @override
  void dispose() {
    _searchTextField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* In this section we will be testing your skills with network and local storage. You need to fetch data from any open source api from the internet. 
             E.g: 
             https://any-api.com/
             https://rapidapi.com/collection/best-free-apis?utm_source=google&utm_medium=cpc&utm_campaign=Beta&utm_term=%2Bopen%20%2Bsource%20%2Bapi_b&gclid=Cj0KCQjw16KFBhCgARIsALB0g8IIV107-blDgIs0eJtYF48dAgHs1T6DzPsxoRmUHZ4yrn-kcAhQsX8aAit1EALw_wcB
             Implement setup for network. You are free to use package such as Dio, Choppper or Http can ve used as well.
             Upon fetching the data try to store thmm locally. You can use any local storeage. 
             Upon Search the data should be filtered locally and should update the UI.
            */

            CupertinoSearchTextField(
              controller: _searchTextField,
              onChanged: (value){
                _demoBloc.add(SearchList(searchString: _searchTextField.text));
              },
            ),

            BlocBuilder<DemoBloc, DemoState>(
              cubit: _demoBloc,
              builder: (context, state) {
                if (state is DemoStateLoading) {
                  return LoaderWidget();
                }

                if (state is DemoStateError) {
                  return SliverToBoxAdapter(child: Text(state.error));
                }

                if(state is DemoStateNoData){
                  return NoDataWidget();
                }
                if (state is DemoStateSuccess) {

                  return Expanded(
                    child: CustomScrollView(
                          shrinkWrap: true,
                          controller: _controller,
                          slivers: [
                            SliverPadding(
                              padding: EdgeInsets.only(
                                  top: 15,
                                  bottom: 15),
                              sliver: new SliverList(
                                delegate: new SliverChildBuilderDelegate(
                                      (context, index) {
                                    // ForumsObj item=snapshot.data[index];
                                    return ListTile(
                                      title: Text(state.demoModelList[index].name,
                                          textAlign: TextAlign.left,
                                          style:
                                          TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black87)),
                                      subtitle: Text(state.demoModelList[index].country,
                                          textAlign: TextAlign.left,
                                          style:
                                          TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black87)),
                                    );
                                  },
                                  childCount: state.demoModelList.length,
                                ),
                              ),
                            )
                          ],

                        ),
                  );
                }

                return new Container(child: const Text(''));
              },
            )
          ],
        ),
      ),
    );
  }
}

