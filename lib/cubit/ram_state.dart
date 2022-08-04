import 'package:equatable/equatable.dart';
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

class Error extends RamState{

}