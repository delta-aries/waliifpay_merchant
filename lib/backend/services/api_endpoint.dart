import 'package:qrpay/backend/extentions/custom_extentions.dart';

class ApiEndpoint {
  static const String mainDomain = "https://waliifpay.waliiftransport.com";
  static const String baseUrl = "$mainDomain/merchant-api";
  //! auth
  static String loginURL = '/merchant/login'.addBaseURl();
  static String logOutURL = '/merchant/logout'.addBaseURl();
  static String sendOTPEmailURL = '/merchant/send-code'.addBaseURl();
  static String sendForgotOTPEmailURL =
      '/merchant/forget/password'.addBaseURl();

  static String verifyForgotOTPEmailURL =
      '/merchant/forget/verify/otp'.addBaseURl();
  static String verifyEmailURL = '/merchant/email-verify'.addBaseURl();
  static String checkingUserURL =
      '/merchant/forget/password/check/merchant'.addBaseURl();
  static String resetPasswordURL =
      '/merchant/forget/reset/password'.addBaseURl();

  //!register

  static String checkRegisterURL =
      '/merchant/register/check/exist'.addBaseURl();
  static String basicDataURL = '/merchant/get/basic/data'.addBaseURl();
  static String merchantKycURL = '/merchant/kyc'.addBaseURl();
  static String registerURL = '/merchant/register'.addBaseURl();
  static String sendRegisterEmailOTPURL =
      '/merchant/register/send/otp'.addBaseURl();
  static String verifyRegisterEmailOTPURL =
      '/merchant/register/verify/otp'.addBaseURl();

//! navbar
  static String dashboardURL = '/merchant/dashboard'.addBaseURl();
  static String notificationsURL = '/merchant/notifications'.addBaseURl();

//! profile
  static String profileURL = '/merchant/profile'.addBaseURl();
  static String updateProfileApi = '/merchant/profile/update'.addBaseURl();
  static String updateKYCApi = '/merchant/kyc/submit'.addBaseURl();

//! categories
  static String addMoneyInfoURL =
      '/merchant/add-money/information'.addBaseURl();

  //! drawer
  static String passwordUpdate = '/merchant/password/update'.addBaseURl();
  static String logout = '/merchant/logout'.addBaseURl();

//! send money
  static String sendMoneyInsertURL =
      '/merchant/add-money/submit-data'.addBaseURl();
  static String sendMoneyStripeConfirmURL =
      '/merchant/add-money/stripe/payment/confirm'.addBaseURl();
  static String sendMoneyManualConfirmURL =
      '/merchant/add-money/manual/payment/confirmed'.addBaseURl();

  static String receiveMoneyURL = '/merchant/receive-money'.addBaseURl();
  static String sendMoneyInfoURL = '/merchant/send-money/info'.addBaseURl();
  static String checkUserExistURL = '/merchant/send-money/exist'.addBaseURl();
  static String checkUserWithQeCodeURL =
      '/merchant/send-money/qr/scan'.addBaseURl();
  static String sendMoneyURL = '/merchant/send-money/confirmed'.addBaseURl();

  // money_out
  static String withdrawInfoURL = '/merchant/withdraw/info'.addBaseURl();
  static String withdrawInsertURL = '/merchant/withdraw/insert'.addBaseURl();
  static String manualWithdrawConfirmURL =
      '/merchant/withdraw/manual/confirmed'.addBaseURl();
  static String checkFlutterwaveAccountURL =
      '/merchant/withdraw/check/flutterwave/bank'.addBaseURl();
  static String automaticWithdrawConfirmURL =
      '/merchant/withdraw/automatic/confirmed'.addBaseURl();

  static String flutterWaveBanksURL =
      '/merchant/withdraw/get/flutterwave/banks?trx='.addDefaultBaseURL();

  /// transactions
  static String transactionLogURL = '/merchant/transactions'.addBaseURl();

  //app settings
  static String appSettingsURL = '/app-settings'.addBaseURl();

  // 2 fa security
  static String twoFAInfoURL =
      '/merchant/security/google/2fa/status'.addBaseURl();
  static String twoFAVerifyURL = '/merchant/google/2fa/verify'.addBaseURl();

  static String makePaymentInfoURL = '/merchant/make-payment/info'.addBaseURl();
  static String checkMerchantExistURL =
      '/merchant/make-payment/check/merchant'.addBaseURl();
  static String checkMerchantWithQeCodeURL =
      '/merchant/make-payment/merchants/scan'.addBaseURl();
  static String makePaymentURL =
      '/merchant/make-payment/confirmed'.addBaseURl();

  static String smsVerifyURL = '/merchant/sms/verify'.addBaseURl();
  static String deleteAccountURL = '/merchant/delete/account'.addBaseURl();

  //api key
  static String apiKeyURL = '/merchant/developer/api'.addBaseURl();
  static String apiKeyProductionURL =
      '/merchant/developer/api/mode/update'.addBaseURl();

  // gateway settings
  static String gatewaySettingsURL = '/merchant/gateway-settings'.addBaseURl();
  static String walletBalanceStatusURL =
      '/merchant/gateway-settings/update/wallet/status'.addBaseURl();
  static String virtualCardStatusURL =
      '/merchant/gateway-settings/update/virtual/card/status'.addBaseURl();
  static String masterCardStatusURL =
      '/merchant/gateway-settings/update/master/card/status'.addBaseURl();
  static String updateKeyURL =
      '/merchant/gateway-settings/update/master/card/credentials'.addBaseURl();

  /// Language
  static String languagesURL = '/app-settings/languages'.addBaseURl();

  //-> payments
  static String paymentLinkGetURL = '/merchant/payment-links'.addBaseURl();
  static String paymentLinkEditGetURL =
      '/merchant/payment-links/edit?target='.addDefaultBaseURL();
  static String paymentLinkStoreURL =
      '/merchant/payment-links/store'.addBaseURl();
  static String paymentLinkUpdateURL =
      '/merchant/payment-links/update'.addBaseURl();
  static String statusURL = '/merchant/payment-links/status'.addBaseURl();
  static String apiKeyCreateURL =
      '/merchant/developer/api/key/generate'.addBaseURl();
  static String apiKeyDeleteURL =
      '/merchant/developer/api/key/delete'.addBaseURl();

  ///->>>>  Pusher
  static String pusherBeamsAuthURL =
      '/merchant/pusher/beams-auth?user_id='.addDefaultBaseURL();
  static String pusherBeamsAuthMain =
      '/merchant/pusher/beams-auth'.addDefaultBaseURL();
}
