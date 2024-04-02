// ignore_for_file: constant_identifier_names

class ApiUrl {
  static const String version = "1.0.3";
  static const String baseUrl = 'https://clickhub.me';
  // static const String configModel = "$baseUrl/admin/index.php/ClickHubapi/";
  static const String configModel = "$baseUrl/admin/index.php/Mahajongapi/";
  static const String aviatorBaseUrl = "https://admin.ClickHub.club/api/aviator/";
  // https://clickhub.me/admin/index.php/ClickHubapi/login

  static const String uploadImage = "$baseUrl/admin/uploads/";
  static const String login = " ${configModel}login";
  static const String register = "${configModel}register";
  static const String profile = "${configModel}profile?id=";
  static const String banner = "${configModel}colour_slider";
  static const String promotionCount = "${configModel}promotion_dashboard_count?id=";
  static const String walletDash = "${configModel}wallet_dashboard?id=";
  static const String depositHistory = "${configModel}deposit_history?id=";
  static const String withdrawHistory = "${configModel}withdraw_history?id=";
  static const String aboutus = "${configModel}about_us";
  static const String addAccount = "${configModel}add_account";
  static const String addAccount_View = "$baseUrl/admin/index.php/Mobile_app/account_get?user_id=";
  static const String HowtoplayApi = "$baseUrl/admin/index.php/Mobile_app/howtoplay?game_id=";
  static const String beginnerapi = "${configModel}beginner_guied_line";
  static const String notificationapi = "${configModel}notification";
  static const String giftcardapi = "${configModel}gift_cart_apply?";
  static const String coinsapi = "${configModel}coins";
  static const String mlm = "${configModel}level_getuserbyrefid?id=";
  static const String colorPrediction = "$baseUrl/admin/api/game_result.php?";
  static const String betColorPrediction = "$baseUrl/admin/api/bet.php";
  static const String withdrawl = "${configModel}withdraw";
  static const String feedback = "${configModel}feedback";
  static const String versionlink = "${configModel}version_apk_link";
  static const String profileUpdate = "${configModel}update_profile";
  static const String deposit = "${configModel}add_money";
  static const String getwayList = "${configModel}pay_modes?userid=";
  static const String colorresult = "$baseUrl/admin/api/colour_result.php?";
  static const String betHistory = "${configModel}bet_history?id=";
  static const String planMlm = "${configModel}mlm_plan";

  static const String privacypolicy = "${configModel}privacy_policy";
  static const String termscon = "${configModel}terms_condition";
  static const String contact = "${configModel}contact_us";
  static const String AttendenceList = "${configModel}attendance_list_get?userid=";
  static const String AttendenceGet = "${configModel}attendance?";
  static const String attendenceDays = "${configModel}attendance_claim?userid=";
  static const String attendenceHistory = "${configModel}attendance_history?userid=";
  static const String changepasswordapi = "${configModel}change_password";
  static const String MLM_PLAN = "${configModel}level_getuserbyrefid?id=";
  static const String walletHistory = "${configModel}wallet_history?userid=";
  static const String game_win = "${configModel}game_win?userid=";




///avaitor

  static const String betPlaced = "${aviatorBaseUrl}bet_now?";
  static const String aviatorCashout = "${aviatorBaseUrl}cash_out?";
  static const String betAvaiHistory = "${aviatorBaseUrl}bet_histroy?";
  static const String resultHistory = "${aviatorBaseUrl}result?limit=";
  static const String crashCheckApi = "${aviatorBaseUrl}result_bet?";
}

