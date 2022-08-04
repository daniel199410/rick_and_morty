import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/cubit/ram_state.dart';
import 'package:hello_world/model/ram_character.dart';
import 'package:hello_world/service/ApiService.dart';

class RamCubit extends Cubit<RamState> {
  RamCubit({required ApiService apiService}) : _apiService = apiService, super(InititalState());

  final ApiService _apiService;

  Future<void> fetchNewRandomCharacter() async {
    emit(Loading());
    var random = Random().nextInt(1100);
    final responseBox = await _apiService.getRamCharacter(random);
    final character = responseBox.fold((l) => l, (r) => r);
    if(responseBox.isLeft()) {
      return emit(Error());
    }
    emit(Success(character as RamCharacter));
  }
}