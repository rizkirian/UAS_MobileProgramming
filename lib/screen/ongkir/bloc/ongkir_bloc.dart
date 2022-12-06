import 'package:bloc/bloc.dart';
import 'package:cek_ongkir/data/model/cost_model.dart';
import 'package:cek_ongkir/data/repositories/api_repository.dart';
import 'package:equatable/equatable.dart';

part 'ongkir_event.dart';
part 'ongkir_state.dart';

class OngkirBloc extends Bloc<OngkirEvent, OngkirState> {
  OngkirBloc() : super(OngkirInitial()) {
    on<OngkirEvent>((event, emit) {
      // TODO: implement event handler
    });

    final ApiRepository apiRepository = ApiRepository();

    on<GetCost>((event, emit) async {
      emit(OngkirLoading());
      try {
        final CostModel costModel = await apiRepository.fetchCostList(
          origin: event.origin,
          destination: event.destination,
          weight: int.parse(event.weight),
          courier: event.courier,
        );
        emit(OngkirLoaded(costModel: costModel));
      } catch (e) {
        emit(OngkirError(message: e.toString()));
      }
    });
  }
}
