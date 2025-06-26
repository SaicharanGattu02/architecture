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
  static const String get_selected_sub_plans = '${apiUrl}selected-plan';
  static const String get_states = '${apiUrl}states';
  static const String get_city = '${apiUrl}states';
  static const String login_otp = '${apiUrl}login-otp';
  static const String resend_login_otp = '${apiUrl}resend-login-otp';
  static const String verify_company_otp = '${apiUrl}company/verify-otp';
  static const String verify_login_otp = '${apiUrl}verify-login-otp';
  static const String resend_verify_company_otp = '${apiUrl}company/resend-otp';
  static const String create_profile = '${apiUrl}company/register';
  static const String update_company_profile =
      '${apiUrl}company/update-profile';
  static const String create_post = '${apiUrl}create-post';
  static const String create_payment = '${apiUrl}create-payment';
  static const String user_posts = '${apiUrl}customer-posts';
  static const String architech_profile = '${apiUrl}getProfile';
  static const String architech_profile_details =
      '${apiUrl}get-architect-by-id';
  static const String architech_company_additional_info =
      '${apiUrl}company/additional-info';
  static const String architech_company_additional_info_update =
      '${apiUrl}company/update-additional-info';
}
