import '../helpers/console.dart';

class AppConfig {
  // static const mainUrl = 'http://172.17.0.2';
  static const mainUrl = 'http://test.pathologywala.com';
  static const host = "${mainUrl}/api";
  static const googlePlacesApi = "";
  static const String LINKEDIN_SECRET = '';
  static const String LINKEDIN_CLIENT_ID = '';
  static const String LINKED_REDIRECT_URL = '';
  static const String LINKEDIN_SCOPE = 'r_liteprofile r_emailaddress';

  static const redis_host = "172.17.0.3";
  static const redis_port = "6379";

  static Map<String, String> getApiHeader(String? token) {
    if (token != null) {
      return {
        "Content-type": "application/x-www-form-urlencoded",
        'Authorization': 'Bearer $token',
      };
    }
    return {"Content-type": "application/x-www-form-urlencoded"};
  }
  static Uri get linkedinAuthUrl{
    Map<String,String> params = {
      'response_type': 'code',
      'client_id'    : LINKEDIN_CLIENT_ID,
      'redirect_uri' : LINKED_REDIRECT_URL,
      'state'        : 'imaginar.in',
      'scope'        : LINKEDIN_SCOPE
    };
    Uri uri = Uri.https('linkedin.com','oauth/v2/authorization', params);
    return uri;
  }
}
