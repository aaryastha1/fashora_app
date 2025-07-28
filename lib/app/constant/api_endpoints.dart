


// class ApiEndpoints {
//   ApiEndpoints._();

//   static const Duration connectionTimeout = Duration(seconds: 1000);
//   static const Duration receiveTimeout = Duration(seconds: 1000);

//   static const String serverAddress = "http://10.0.2.2:5006";

//   // Base URLs
//   static const String authBaseUrl = "$serverAddress/api/auth";
//   static const String userBaseUrl = "$serverAddress/api/user";

//   // Auth endpoints
//   static const String login = "$authBaseUrl/login";
//   static const String register = "$authBaseUrl/register";


//     // Profile endpoints


//   // Product endpoint under user path
//   static const String getProductsByCategory = "$userBaseUrl/products";

//   // Favorite endpoints
//   static const String getFavorites = "$userBaseUrl/favorites";
//   static const String toggleFavorite = "$userBaseUrl/favorites/toggle";


//   static const String cartBaseUrl = "$serverAddress/api/cart";

// static const String getCart = cartBaseUrl;
// static const String addToCart = cartBaseUrl; // POST to add item
// static const String removeFromCart = "$cartBaseUrl/remove"; // or customize based on your backend routes
// static const String updateCartItem = "$cartBaseUrl/update"; // or customize
// static const String clearCart = "$cartBaseUrl/clear";



// static const String searchProducts = '/api/user/products/search';


//  static const String getProfile = '$authBaseUrl/me';
// static const String updateProfile = '$authBaseUrl/me';

//  // if you have such an endpoint





//   // You can add a baseUrl here if needed:
//   static const String baseUrl = serverAddress; // or "$serverAddress/api"
// }




class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  // Use your PC's IP address for real device access
  static const String serverAddress = "http://192.168.1.72:5006";

  // Base URLs
  static const String authBaseUrl = "$serverAddress/api/auth";
  static const String userBaseUrl = "$serverAddress/api/user";

  // Auth endpoints
  static const String login = "$authBaseUrl/login";
  static const String register = "$authBaseUrl/register";

  // Product endpoint under user path
  static const String getProductsByCategory = "$userBaseUrl/products";

  // Favorite endpoints
  static const String getFavorites = "$userBaseUrl/favorites";
  static const String toggleFavorite = "$userBaseUrl/favorites/toggle";

  // Cart endpoints
  static const String cartBaseUrl = "$serverAddress/api/cart";
  static const String getCart = cartBaseUrl;
  static const String addToCart = cartBaseUrl;
  static const String removeFromCart = "$cartBaseUrl/remove";
  static const String updateCartItem = "$cartBaseUrl/update";
  static const String clearCart = "$cartBaseUrl/clear";

  // Product search
  static const String searchProducts = "$userBaseUrl/products/search";

  // Profile
  static const String getProfile = "$authBaseUrl/me";
  static const String updateProfile = "$authBaseUrl/me";

  // Optional base URL reference
  static const String baseUrl = serverAddress;
}
