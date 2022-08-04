import 'dart:convert';

import 'package:equatable/equatable.dart';

class RamCharacter extends Equatable{
  final id;

  const RamCharacter(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];

  factory RamCharacter.fromJson(String body)  => RamCharacter(
    body
  );
}