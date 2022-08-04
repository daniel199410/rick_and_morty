import 'package:equatable/equatable.dart';

abstract class RamEvent extends Equatable {
  factory RamEvent.newRandomCharacterRequested() = NewRandomCharacterRequested;

  @override
  List<Object> get props => [];
}

class NewRandomCharacterRequested implements RamEvent {

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => true;

}