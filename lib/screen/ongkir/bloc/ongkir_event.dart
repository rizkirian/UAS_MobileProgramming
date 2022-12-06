part of 'ongkir_bloc.dart';

abstract class OngkirEvent extends Equatable {
  const OngkirEvent();

  @override
  List<Object> get props => [];
}

class GetCost extends OngkirEvent {
  final String origin;
  final String destination;
  final String weight;
  final String courier;

  const GetCost({
    required this.origin,
    required this.destination,
    required this.weight,
    required this.courier,
  });

  @override
  List<Object> get props => [origin, destination, weight, courier];
}
