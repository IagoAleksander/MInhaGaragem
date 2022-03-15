import 'package:car_list/data/model/carro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarCubit extends Cubit<List<Carro>> {
  CarCubit() : super([]);

  void addCar() {
    state.add(Carro());
    emit (state);
  }

}