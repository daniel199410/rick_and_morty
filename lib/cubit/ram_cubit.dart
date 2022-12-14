import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ric_and_morty/cubit/ram_event.dart';
import 'package:ric_and_morty/cubit/ram_state.dart';

import '../model/characters_filter_response.dart';
import '../model/ram_character.dart';
import '../service/ApiService.dart';

class RamCubit extends Bloc<RamEvent, RamState> {
  RamCubit({required ApiService apiService}) : _apiService = apiService, super(InititalState()) {
    on<NewRandomCharacterRequested>(fetchNewRandomCharacter);
    on<CharactersByNameRequested>(fetchCharactersByName);
  }

  final ApiService _apiService;

  Future<void> fetchNewRandomCharacter(NewRandomCharacterRequested event, Emitter<RamState> emit) async {
    emit(Loading());
    var random = Random().nextInt(1100);
    final responseBox = await _apiService.getRamCharacter(random);
    final character = responseBox.fold((l) => l, (r) => r);
    if(responseBox.isLeft()) {
      return emit(Error());
    }
    emit(Success(character as RamCharacter));
  }

  Future<void> fetchCharactersByName(CharactersByNameRequested event, Emitter<RamState> emit) async {
    emit(Loading());
    final responseBox = await _apiService.getRamCharactersByName(event.name);
    final character = responseBox.fold((l) => l, (r) => r);
    if(responseBox.isLeft()) {
      return emit(Error());
    }
    emit(SuccessfulCharacterByName(character as CharactersFilterResponse));
  }
}