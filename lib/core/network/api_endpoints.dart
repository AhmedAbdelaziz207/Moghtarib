class ApiEndPoints {
  static const baseUrl = "https://mo3tarib123.runasp.net/";
  static const imagesUrl = "http://mo3tarib123.runasp.net/Images/";
  static const login = "api/Account/Login";
  static const register = "api/Account/Register";
  static const department = "api/Department";
  static const apartment = "api/Apartment/Search";
  static const technicians = "/api/Account/GetAllSanaieeia";
  static const user = "api/Account/GetUserById";
  static const allChats = "api/Chat/GetContactUsers";
  static const chat = "api/Chat/GetChat";
  static const deleteChat = "api/Chat";
  static const sendMessage = "api/Chat/send";
  static const favorites = "api/Favourite";

  static const sendEmailOTP = "api/Account/SendEmail";

  static const changePassword = "api/Account/ChangePassword";

  static const comment =
      "/api/Comment/GetAllCommentsOfApartment";
  static const addOrDeleteComment = "/api/Comment";

  static const allApartmentForBroker =
      "api/Apartment/GetApartmentForSignInUser";
  static const addApartment = "api/Apartment";
}
