import 'package:equatable/equatable.dart';

abstract class RamEvent extends Equatable {
  factory RamEvent.newRandomCharacterRequested() = NewRandomCharacterRequested;
  factory RamEvent.charactersByNameRequested(String name) = CharactersByNameRequested;

  @override
  List<Object> get props => [];
}

class NewRandomCharacterRequested implements RamEvent {

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => true;

}

class CharactersByNameRequested implements RamEvent {
  final String name;

  CharactersByNameRequested(this.name);

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => true;
}