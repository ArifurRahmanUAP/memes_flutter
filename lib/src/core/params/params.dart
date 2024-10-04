import 'package:equatable/equatable.dart';

class Params extends Equatable {
  final Map<String, dynamic> filterMap;

  const Params({required this.filterMap});

  @override
  List<Object?> get props => [filterMap];
}
