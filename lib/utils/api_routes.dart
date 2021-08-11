class ApiRoutes {
  static const String BASE_URL = 'https://mas.doctor/api/v1/';

  //? Auth
  static const String LOGIN = BASE_URL + 'login';
  static const String REGISTER = BASE_URL + 'register';
  static const String LOGOUT = BASE_URL + 'logout';

  //? Account
  static const String PROFILE = BASE_URL + 'doctor/profile';
  static const String CONTACT_SUPPORT = BASE_URL + 'doctor/contact-support';
  static const String FAQ = BASE_URL + 'general/faqs?app_type=doctor';
  static const String TERMS_AND_CONDITIONS =
      BASE_URL + 'general/terms_conditions';

  //? Appointments
  static const String appointments = BASE_URL + 'doctor/appointments';
  static const String reviews = BASE_URL + 'doctor/reviews';

  //? Reviews
}
