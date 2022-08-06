class AppConfig
{
  static String appName="Movie Links";
  static String appVersion="Movie Links";



  static String DOMAIN_NAME="192.168.124.1/movie-link";
  static bool IS_HTTPS=false;
  static String PROTOCOL=IS_HTTPS?"https":"http";
  static String API_PATH="api";
  static String API_URL="$PROTOCOL://$DOMAIN_NAME/$API_PATH";





}