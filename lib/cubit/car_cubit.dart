import 'package:car_list/data/database_helper.dart';
import 'package:car_list/data/model/carro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarCubit extends Cubit<List<Carro>> {
  CarCubit() : super([]);

  final DatabaseHelper databaseHelper = DatabaseHelper();
  int? selectedCarId;

  void addCar(Carro car) async {
    int insertedId = await databaseHelper.insertCar(car);

    if (insertedId > 0) {
      getAllCars();
    }
  }

  void updateCar(Carro car) async {
    int updatedId = await databaseHelper.updateCar(car);

    if (updatedId > 0) {
      getAllCars();
    }
  }

  void selectCarToggle(Carro car) {
    if (isThereACarSelected() && car.id == selectedCarId) {
      for (Carro element in state) {
        if (element.id == car.id) {
          element.isSelected = false;
          selectedCarId = null;
        }
      }
    } else {
      for (Carro element in state) {
        element.isSelected = element.id == car.id;
        if (element.id == car.id) {
          selectedCarId = element.id;
        }
      }
    }
    emit([...state]);
  }

  void removeCar(Carro car) async {
    if (car.id != null) {
      await databaseHelper.deleteCar(car.id ?? -1);
      getAllCars();
    }
  }

  void getAllCars() async {
    List<Carro>? cars = await databaseHelper.getCarList();
    if (cars != null) {
      emit(cars);
    }
  }

  bool isThereACarSelected() {
    if (selectedCarId != null) {
      return true;
    }
    return false;
  }

  Carro? getCar(int? id) {
    for (Carro element in state) {
      if (element.id == id) {
        return element;
      }
    }
    return null;
  }
}
