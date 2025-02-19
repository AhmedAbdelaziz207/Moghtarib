import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/edit_or_add_apartment_destination.dart';

class ApartmentDetailsParams {
  final ApartmentModel? apartment;

  final EditOrAddApartmentDestination? destination;

  ApartmentDetailsParams({this.destination,  this.apartment});
}
