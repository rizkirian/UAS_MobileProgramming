part of 'ongkir_bloc.dart';

abstract class OngkirState extends Equatable {
  const OngkirState();

  @override
  List<Object> get props => [];
}

class OngkirInitial extends OngkirState {}

class OngkirLoading extends OngkirState {}

class OngkirLoaded extends OngkirState {
  final CostModel costModel;

  const OngkirLoaded({required this.costModel});

  @override
  List<Object> get props => [costModel];
}

class OngkirError extends OngkirState {
  final String message;

  const OngkirError({required this.message});

  @override
  List<Object> get props => [message];
}
