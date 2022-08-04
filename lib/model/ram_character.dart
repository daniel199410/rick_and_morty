
import 'package:equatable/equatable.dart';

class RamCharacter extends Equatable{
  final int id;

  final String image;

  const RamCharacter(this.id, this.image);
  @override
  // TODO: implement props
  List<Object?> get props => [id];

  factory RamCharacter.fromJson(dynamic json)  => RamCharacter(
    json['id'],
    json['image']
  );
}