class APIEndpointUrls {
  static const String baseUrl = 'https://fma.ozrit.in/';
  // static const String baseUrl = 'http://192.168.80.193:8000/';
  static const String apiUrl = 'api/';

  /// Auth URls
  static const String register = '${apiUrl}register';
  static const String refreshtoken = '${apiUrl}login';

  static const String addPost = '${apiUrl}create-post';
  static const String deletePost = '${apiUrl}delete-post';
  static const String editPost = '${apiUrl}edit-post';

  static const String get_architect = '${apiUrl}get-architects';
  static const String getsubplans = '${apiUrl}plans';
  static const String activesubplans = '${apiUrl}selected-plan';
  static const String get_states = '${apiUrl}states';
  static const String get_city = '${apiUrl}states';
  static const String loginotp = '${apiUrl}login-otp';
  static const String verify_company_otp = '${apiUrl}company/verify-otp';
  static const String verify_login_otp = '${apiUrl}verify-login-otp';
  static const String create_profile = '${apiUrl}company/register';
  static const String create_post = '${apiUrl}create-post';
  static const String user_posts = '${apiUrl}customer-posts';
}
