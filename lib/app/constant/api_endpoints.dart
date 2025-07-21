// class ApiEndpoints {
//   ApiEndpoints._();

//   // Timeouts
//   static const connectionTimeout = Duration(seconds: 1000);
//   static const receiveTimeout = Duration(seconds: 1000);

//   // For Android Emulator
//   static const String serverAddress = "http://10.0.2.2:5006";
//   static const String baseUrl = "$serverAddress/api/auth";
  
//   // // For iOS Simulator
//   // static const String serverAddress = "http://localhost:3000";

//   // For iPhone (uncomment if needed)
//   // static const String baseUrl = "$serverAddress/api/v1/";
//   // static const String imageUrl = "$baseUrl/uploads/";

//   // Auth
//   static const String login = "/login";
//   static const String register = "/register";
//   static const String getProductsByCategory = "/products";






// }

class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  static const String serverAddress = "http://10.0.2.2:5006";

  // Base URLs
  static const String authBaseUrl = "$serverAddress/api/auth";
  static const String userBaseUrl = "$serverAddress/api/user";

  // Auth endpoints
  static const String login = "$authBaseUrl/login";
  static const String register = "$authBaseUrl/register";

  // Product endpoint under user path
  static const String getProductsByCategory = "$userBaseUrl/products";

  // You can add a baseUrl here if needed:
  static const String baseUrl = serverAddress; // or "$serverAddress/api"
}
