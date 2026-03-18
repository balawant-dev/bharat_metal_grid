import '../../../core/services/secure_storage_service.dart';

import '../cms/model/settingsModel.dart';

class AppSettings {
  static SettingResponseModel? _settings;

  static void setSettings(SettingResponseModel data) {
    _settings = data;
  }

  static SettingResponseModel? get settings => _settings;

  static String _userType = "";
  static String _userName = "";

  static String _userPhone = "";
  static String _userEmail = "";
  static String _userProfileImage = "";
  static String _profileCompletionPercentage = "";

  static Future<void> initUserType() async {
    _userType = await SecureStorageService.getUserType() ?? "";
    _userName = await SecureStorageService.getUserName() ?? "";
    _profileCompletionPercentage = await SecureStorageService.getProfileCompletionPercentage() ?? "";

    _userPhone = await SecureStorageService.getUserPhone() ?? "";
    _userEmail = await SecureStorageService.getUserEmail() ?? "";
    _userProfileImage = await SecureStorageService.getUserProfileImage() ?? "";
  }

  static Future<void> setUserType({required String userType}) async {
    _userType = userType;

    await SecureStorageService.saveUserType(userType);
  }

  static Future<void> setUserDetail({
    required String userName,
    required String userPhone,
    required String userEmail,
    required String userProfileImage,
    required String profileCompletionPercentage,
  }) async {
    _userEmail = userEmail;
    _userName = userName;
    _userPhone = userPhone;
    _userProfileImage = userProfileImage;
    _profileCompletionPercentage = profileCompletionPercentage;

    await SecureStorageService.saveUserName(userName);
    await SecureStorageService.saveProfileCompletionPercentage(profileCompletionPercentage);

    await SecureStorageService.saveUserPhone(userPhone);
    await SecureStorageService.saveUseEmail(userEmail);
    await SecureStorageService.saveUserProfileImage(userProfileImage);
  }

  static Future<void> clearUserType() async {
    _userType = "";
    _userEmail = "";
    _userName = "";
    _userPhone = "";
    _userProfileImage = "";
    _profileCompletionPercentage = "";
    await SecureStorageService.removeIsAgent();
    await SecureStorageService.removeIsUser();
    await SecureStorageService.removeUserID();
    await SecureStorageService.removeUserName();
    await SecureStorageService.removeUserPhone();
    await SecureStorageService.removeUserEmail();
    await SecureStorageService.removeToken();
    await SecureStorageService.profileCompletionPercentage();
  }

  static String get userType => _userType;

  static String get userName => _userName;

  static String get userPhone => _userPhone;
  static String get profileCompletionPercentage => _profileCompletionPercentage;

  static String get userEmail => _userEmail;
  static String get userProfileImage => _userProfileImage;

  /// 🔥 SET USER TYPE + SAVE TO SECURE STORAGE (YEH SABSE ZAROORI HAI)

  /// ---------- BASIC INFO ----------
  static String get brandName => _settings?.data?.brandName ?? "";

  static String get logo => _settings?.data?.logo ?? "";

  static String get email => _settings?.data?.email ?? "";

  static String get mobile => _settings?.data?.mobile ?? "";

  static String get address => _settings?.data?.address ?? "";

  static String get gst => _settings?.data?.gst ?? "";

  /// ---------- PAYMENT / KEYS ----------
  static String get googleMapApiKey => _settings?.data?.googleMapApiKey ?? "";

  static String get razorpayKeyId => _settings?.data?.razorpayKeyId ?? "";

  static String get razorpayKeySecret =>
      _settings?.data?.razorpayKeySecret ?? "";

  static List<AppPaymentMethods> get paymentMethods =>
      _settings?.data?.appPaymentMethods ?? [];

  /// ---------- CMS CONTENT ----------
  static String get agreement => _settings?.data?.agreement ?? "";

  static String get termsAndConditions =>
      _settings?.data?.termAndConditions ?? "";

  static String get privacyPolicy => _settings?.data?.privacyPolicy ?? "";

  static String get refundPolicy => _settings?.data?.refundPolicy ?? "";

  /// ---------- APP CONFIG ----------
  static String get appColorCode => _settings?.data?.appColourCode ?? "#000000";

  static int get appColor {
    try {
      return int.parse(appColorCode.replaceFirst('#', '0xff'));
    } catch (e) {
      return 0xff000000; // fallback black
    }
  }

  static String get extraChargePerPerson =>
      _settings?.data?.extraChargePerPerson ?? "0";

  static String get baseUrl => _settings?.data?.liveBaseUrl ?? "";

  static int get agentCommission => _settings?.data?.agentComission ?? 0;

  /// ---------- HELPERS ----------
  static bool get isCashEnabled =>
      paymentMethods.any((e) => e.name == "cash" && e.status == "active");

  static bool get isOnlineEnabled =>
      paymentMethods.any((e) => e.name == "online" && e.status == "active");

  /// 🔥 LOGOUT KE TIME CLEAR KARNA (RECOMMENDED)
}
