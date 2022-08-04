import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/bloc_observer.dart';
import 'package:hello_world/cubit/ram_cubit.dart';
import 'package:hello_world/service/ApiService.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const RamApp())  ,
    blocObserver: AppBlocObserver()
  );

}

class RamApp extends StatelessWidget {
  const RamApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'R & M',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => RamCubit(apiService: ApiService(Dio())),
        child: const Dashboard(title: 'R & M')
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(title),
        ),
        body: Center(
         child: Text(title)
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final cubit = BlocProvider.of<RamCubit>(context);
            cubit.fetchNewRandomCharacter();
          },
          child: const Icon(Icons.search),
        ),
    );
  }
}

