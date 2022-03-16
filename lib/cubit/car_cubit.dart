import 'package:car_list/data/database_helper.dart';
import 'package:car_list/data/model/carro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarCubit extends Cubit<List<Carro>> {
  CarCubit() : super([]);

  final DatabaseHelper databaseHelper = DatabaseHelper();

  void addCar(Carro car) async {
    int insertedId = await databaseHelper.insertCar(car);

    if (insertedId > 0) {
      emit([
        ...state,
        Carro(
          id: insertedId,
          placa: car.placa,
          cor: car.cor,
        )
      ]);
    }
  }

  void selectCar(Carro car) {
    for (Carro element in state) {
      element.isSelected = element.id == car.id;
    }
    emit([...state]);
  }

  void removeCar(Carro car) {
    if (car.id != null) {
      databaseHelper.deleteCar(car.id ?? -1);
      state.remove(car);
      emit([...state]);
    }
  }

  void getAllCars() async {
    List<Carro>? cars = await databaseHelper.getCarList();
    if (cars != null) {
      emit(cars);
    }
  }
}
