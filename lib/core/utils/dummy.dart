import '../../features/add_edit_apartment/model/apartment_model.dart';

final ApartmentModel dummyApartment = ApartmentModel(
  id: 1,
  city: "New York",
  village: "Greenwood",
  location: "Central Park, NY",
  addressLat: "40.785091",
  addressLong: "-73.968285",
  price: 2500,
  numOfRooms: 3,
  baseImageURL: "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=1980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  type: 1,
  distanceByMeters: 500,
  isRent: true,
  dateOfCreation: DateTime.now(),
  userId: "user_123",
  userName: "John Doe",
  userPhone: "+1 234 567 890",
  userWhatsapp: "+1 987 654 321",
  imagesURL: [
    "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=1980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1628592102751-ba83b0314276?q=80&w=1997&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  ],
);
