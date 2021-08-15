class ApiRoutes {
  static const String BASE_URL = 'https://mas.doctor/api/v1/';

  //? Auth
  static const String LOGIN = BASE_URL + 'login';
  static const String REGISTER = BASE_URL + 'register';
  static const String LOGOUT = BASE_URL + 'logout';

  //? Account
  static const String ACCOUNT = BASE_URL + 'doctor/account';
  static const String PROFILE = BASE_URL + 'doctor/profile';
  static const String UPDATE_IMAGE = BASE_URL + 'general/profile/image';
  static const String UPDATE_PERSONAL_INFO = BASE_URL + 'doctor/profile/update';
  static const String UPDATE_HOSPITAL = BASE_URL + 'doctor/hospital/update';
  static const String UPDATE_AVAILABITLITY = BASE_URL + 'doctor/time/update';
  static const String UPDATE_SPECIFICATION = BASE_URL + 'doctor/specification/update';
  static const String UPDATE_SERVICES = BASE_URL + 'doctor/service/update';
  static const String UPDATE_FEES_EXPERIENCE = BASE_URL + 'doctor/fees/update';
  static const String CONTACT_SUPPORT = BASE_URL + 'doctor/contact-support';
  static const String FAQ = BASE_URL + 'general/faqs?app_type=doctor';
  static const String TERMS_AND_CONDITIONS =
      BASE_URL + 'general/terms_conditions';

  //? Appointments
  static const String appointments = BASE_URL + 'doctor/appointments';
  static const String reviews = BASE_URL + 'doctor/reviews';

  //? Reviews
}
