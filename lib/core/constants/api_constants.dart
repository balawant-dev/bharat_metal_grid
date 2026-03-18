
  class ApiConstants {
// static const String baseUrl = 'http://192.168.1.14:5009/';
//
// static const String socketURl = 'http://192.168.1.14:5009';
// static const String socketURl = 'https://vamanji.app';
// static const String baseUrl = 'https://vamanji.app/';
static const String socketURl = 'http://159.89.146.245:7007';
static const String baseUrl = 'http://159.89.146.245:7007/';


    static const String sendOtp = 'api/user/generate-otp';

    static const String verifyOtp = 'api/user/verify-otp';
    static const String userType = 'api/user/user-type';
    static const String userName = 'api/user/userName';
    static const String userEmail = 'api/user/userEmail';
    static const String userPhone = 'api/user/userPhone';
    static const String profileCompletionPercentage = 'api/user/profileCompletionPercentage';

    static const String userProfileImage = 'api/user/userProfileImage';
static const String memberRegistration = 'api/user/register-member';
static const String post = 'api/user/post';
static const String membershipAssignment = 'api/user/membership-assignment';
static const String postReaction = 'api/user/post-reaction';
static const String createOrder = 'api/user/create-order';
static const String associationRegistration = 'api/user/register-association';
static const String updateAssociation = 'api/user/update-association';
static const String allAssociation = 'api/user/all-associations';
static const String profileEndpoint = 'api/user/profile';
static const String leadershipChain = 'api/user/leadership-chain';
static const String industryNews = 'api/user/industry-news';
static const String gallery = 'api/user/gallery';
static const String banners = 'api/user/banners';
static const String info = 'api/user/info';
static const String events = 'api/user/events';
static const String latestNotices = 'api/user/latest-notices';





static const String agentSignUp = 'api/user/auth/agent-signup';
    static const String settingData = 'api/user/common/settingData';
    static const String registerEndpoint = 'auth/register';
    static const String organizationDetails = 'auth/OrganizationDetailsModel';


    static const String homeData = 'api/user/home/homeData';
    static const String createSOS = 'api/user/sos/create';
    static const String location = 'api/user/home/location';
    static const String bookingHistory = 'api/user/booking/history';
    static const String bookingHistoryDetail = 'api/user/booking/detail';
    static const String bookingHistoryCancel = 'api/user/booking/cancel';
    static const String suggestedLocation = 'api/user/home/suggestedLocation';
    static const String createBooking = 'api/user/booking/create';
    static const String packageDetail = 'api/user/home/packageDetail';
    static const String notificationList = 'api/user/notification/list';

    static const String createBankDetail = 'api/user/bank-detail/create';
    static const String updateBankDetail = 'api/user/bank-detail/update';
    static const String getBankDetail = 'api/user/bank-detail';
    static const String dashboardEndpoint = 'dashboard';
    static const String settingsEndpoint = 'settings';
    static const String uploadEndpoint = 'upload';
  static const token = "auth_token";
  static const onboardingComplete = "onboarding_complete";
    static const String tokenKey = 'token';
    static const String isAgentKey = 'isAgent';
    static const String isUserKey = 'isUser';
    static const String saveUserType = 'saveUserType';
    static const String gemini = 'gemini';
  }