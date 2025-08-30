

import 'package:equatable/equatable.dart';


abstract class UserDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUserDetail extends UserDetailEvent {
  final int id;
  FetchUserDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateUserDetail extends UserDetailEvent {
  final int id;
  final String name;
  final String email;
  final String address;

  UpdateUserDetail({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
  });

  @override
  List<Object?> get props => [id, name, email, address];
}

class NameChanged extends UserDetailEvent {
  final String name;
  NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class AddressChanged extends UserDetailEvent {
  final String address;
  AddressChanged(this.address);

  @override
  List<Object?> get props => [address];
}