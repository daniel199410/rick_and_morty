import 'package:equatable/equatable.dart';
import 'package:hello_world/model/info.dart';
import 'package:hello_world/model/ram_character.dart';

class CharactersFilterResponse extends Equatable{
  final Info info;
  final List<RamCharacter> results;

  const CharactersFilterResponse({
    required this.info,
    required this.results,
  });

  @override
  List<Object?> get props => [];

  factory CharactersFilterResponse.fromJson(dynamic json)  => CharactersFilterResponse(
    results: List<RamCharacter>.from(json['results'].map((model) => RamCharacter.fromJson(model))),
    info: Info.fromJson(json['info']),
  );
}