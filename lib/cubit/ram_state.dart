import 'package:equatable/equatable.dart';
import 'package:hello_world/model/characters_filter_response.dart';
import 'package:hello_world/model/ram_character.dart';

abstract class RamState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InititalState extends RamState{

}

class Loading extends RamState{

}

class Success extends RamState{
  final RamCharacter character;

  Success(this.character);

  @override
  List<Object?> get props => [character];
}

class SuccessfulCharacterByName extends RamState{
  final CharactersFilterResponse charactersFilterResponse;

  SuccessfulCharacterByName(this.charactersFilterResponse);

  @override
  List<Object?> get props => [charactersFilterResponse];
}

class Error extends RamState{

}