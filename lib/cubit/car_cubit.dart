import 'package:car_list/data/model/carro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarCubit extends Cubit<List<Carro>> {
  CarCubit() : super([]);

  void addCar(Carro car) {
    emit([...state, car]);
  }

  void selectCar(Carro car) {
    for (Carro element in state) {
      element.isSelected = element.id == car.id;
    }
    emit([...state]);
  }

  void removeCar(Carro car) {
    state.remove(car);
    emit([...state]);
  }
}
