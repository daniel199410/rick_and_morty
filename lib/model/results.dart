import 'package:equatable/equatable.dart';
import 'package:ric_and_morty/model/ram_character.dart';

class Result extends Equatable{
  final List<RamCharacter> results;

  const Result({
    required this.results,
  });

  @override
  List<Object?> get props => [];

  factory Result.fromJson(dynamic json)  => Result(
    results: json['results'],
  );
}