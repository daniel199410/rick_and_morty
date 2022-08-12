import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ric_and_morty/service/ApiService.dart';

import 'bloc_observer.dart';
import 'cubit/ram_cubit.dart';
import 'cubit/ram_event.dart';
import 'cubit/ram_state.dart';
import 'model/ram_character.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const RamApp());
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

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return SearchFormState();
  }
}

class SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  final formController = TextEditingController();

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Flexible(
              flex: 10,
              child: TextFormField(
                controller: formController,
                decoration: InputDecoration(
                  hintText: 'Enter character name.',
                  suffixIcon: IconButton(
                    onPressed: formController.clear,
                    icon: const Icon(Icons.clear),
                  )
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              )
            ),
            Flexible(
              flex: 2,
              child: TextButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    final cubit = BlocProvider.of<RamCubit>(context);
                    cubit.add(RamEvent.charactersByNameRequested(formController.text));
                  }
                },
                child: const Icon(Icons.search, color: Colors.blue),
              ),
            ),
          ],
        ),
      )
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
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const SearchForm(),
              Flexible(child: BlocListener<RamCubit, RamState>(
                listenWhen: (previous, current) => previous is! Error && current is Error,
                listener: (BuildContext context, state) {
                  if(state is Error) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Boom!")));
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: const PageContent()
                ),
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final cubit = BlocProvider.of<RamCubit>(context);
            cubit.add(RamEvent.newRandomCharacterRequested());
          },
          child: const Icon(Icons.shuffle),
        ),
    );
  }
}

class PageContent extends StatelessWidget {
  const PageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RamCubit, RamState>(
      builder: (context, state) {
        if(state is Loading) {
          return const CircularProgressIndicator();
        }
        if(state is Success) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(state.character.image),
                Text(state.character.name),
                Text(state.character.gender)
              ],
            ),
          );
        }
        if(state is SuccessfulCharacterByName) {
          var characters = state.charactersFilterResponse.results;
          return ListView.builder(
            itemCount: characters.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return CharacterInfo(character: characters[index]);
            })
          );
        }
        if(state is Error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                    "¡Oh no!"
                  ),
                ),
                Text("No hemos encontrado información.")
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

class CharacterInfo extends StatelessWidget {
  const CharacterInfo({Key? key, required this.character}) : super(key: key);

  final RamCharacter character;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: (
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: Image.network(character.image, height: 60, width: 60, )
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(character.name),
                  Text(character.gender),
                ],
              ),
            )
          ],
        )
      ),
    );
  }

}