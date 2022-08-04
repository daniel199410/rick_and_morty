import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/bloc_observer.dart';
import 'package:hello_world/cubit/ram_cubit.dart';
import 'package:hello_world/cubit/ram_event.dart';
import 'package:hello_world/service/ApiService.dart';

import 'cubit/ram_state.dart';

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
        body: BlocListener<RamCubit, RamState>(
          listenWhen: (previous, current) => previous is! Error && current is Error,
          listener: (BuildContext context, state) {
            if(state is Error) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Boom!")));
            }
          },
          child: const PageContent(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final cubit = BlocProvider.of<RamCubit>(context);
            cubit.add(RamEvent.newRandomCharacterRequested());
          },
          child: const Icon(Icons.search),
        ),
    );
  }
}

class PageContent extends StatelessWidget {
  const PageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocBuilder<RamCubit, RamState>(
          builder: (context, state) {
            if(state is Loading) {
              return const CircularProgressIndicator();
            }
            if(state is Success) {
              return Column(
                children: [
                  Image.network(state.character.image),
                  Text(state.character.name),
                  Text(state.character.gender)
                ],
              );
            }
            if(state is Error) {
              return const Text("Boom!");
            }
            return Container(
              color: Colors.teal,
              width: 100,
              height: 100,
            );
          },
        )
    );
  }
}