import 'package:equatable/equatable.dart';

class Info extends Equatable{
  final int count;
  final int pages;
  final String next;

  const Info({
    required this.count,
    required this.pages,
    required this.next,
  });

  @override
  List<Object?> get props => [];

  factory Info.fromJson(dynamic json)  => Info(
    count: json['count'],
    pages: json['pages'],
    next: json['next'],
  );
}