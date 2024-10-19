import 'dart:convert';

AppSettingsModel appSettingsModelFromJson(String str) =>
    AppSettingsModel.fromJson(json.decode(str));

String appSettingsModelToJson(AppSettingsModel data) =>
    json.encode(data.toJson());

class AppSettingsModel {
  final Message message;
  final Data data;

  AppSettingsModel({
    required this.message,
    required this.data,
  });

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) =>
      AppSettingsModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  final String baseUrl;
  final String defaultImage;
  final String screenImagePath;
  final String logoImagePath;
  final AppUrl appUrl;
  final AppSettings appSettings;

  Data({
    required this.baseUrl,
    required this.defaultImage,
    required this.screenImagePath,
    required this.logoImagePath,
    required this.appUrl,
    required this.appSettings,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        baseUrl: json["base_url"],
        defaultImage: json["default_image"],
        screenImagePath: json["screen_image_path"],
        logoImagePath: json["logo_image_path"],
        appUrl: AppUrl.fromJson(json["app_url"]),
        appSettings: AppSettings.fromJson(json["app_settings"]),
      );

  Map<String, dynamic> toJson() => {
        "base_url": baseUrl,
        "default_image": defaultImage,
        "screen_image_path": screenImagePath,
        "logo_image_path": logoImagePath,
        "app_url": appUrl.toJson(),
        "app_settings": appSettings.toJson(),
      };
}

class AppSettings {
  final Agent user;
  final Agent agent;
  final Agent merchant;

  AppSettings({
    required this.user,
    required this.agent,
    required this.merchant,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        user: Agent.fromJson(json["user"]),
        agent: Agent.fromJson(json["agent"]),
        merchant: Agent.fromJson(json["merchant"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "agent": agent.toJson(),
        "merchant": merchant.toJson(),
      };
}

class Agent {
  final SplashScreen splashScreen;
  final List<OnboardScreen> onboardScreen;
  final BasicSettings basicSettings;

  Agent({
    required this.splashScreen,
    required this.onboardScreen,
    required this.basicSettings,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        splashScreen: SplashScreen.fromJson(json["splash_screen"]),
        onboardScreen: List<OnboardScreen>.from(
            json["onboard_screen"].map((x) => OnboardScreen.fromJson(x))),
        basicSettings: BasicSettings.fromJson(json["basic_settings"]),
      );

  Map<String, dynamic> toJson() => {
        "splash_screen": splashScreen.toJson(),
        "onboard_screen":
            List<dynamic>.from(onboardScreen.map((x) => x.toJson())),
        "basic_settings": basicSettings.toJson(),
      };
}

class BasicSettings {
  final String siteName;
  final String siteTitle;
  final String baseColor;
  final String siteLogo;
  final String siteLogoDark;
  final String siteFavDark;
  final String siteFav;
  final String timezone;

  BasicSettings({
    required this.siteName,
    required this.siteTitle,
    required this.baseColor,
    required this.siteLogo,
    required this.siteLogoDark,
    required this.siteFavDark,
    required this.siteFav,
    required this.timezone,
  });

  factory BasicSettings.fromJson(Map<String, dynamic> json) => BasicSettings(
        siteName: json["site_name"],
        siteTitle: json["site_title"],
        baseColor: json["base_color"],
        siteLogo: json["site_logo"],
        siteLogoDark: json["site_logo_dark"],
        siteFavDark: json["site_fav_dark"],
        siteFav: json["site_fav"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "site_name": siteName,
        "site_title": siteTitle,
        "base_color": baseColor,
        "site_logo": siteLogo,
        "site_logo_dark": siteLogoDark,
        "site_fav_dark": siteFavDark,
        "site_fav": siteFav,
        "timezone": timezone,
      };
}

class OnboardScreen {
  final int id;
  final String title;
  final String subTitle;
  final String image;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  OnboardScreen({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OnboardScreen.fromJson(Map<String, dynamic> json) => OnboardScreen(
        id: json["id"],
        title: json["title"],
        subTitle: json["sub_title"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sub_title": subTitle,
        "image": image,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class SplashScreen {
  final int id;
  final String splashScreenImage;
  final String version;
  final DateTime createdAt;
  final DateTime updatedAt;

  SplashScreen({
    required this.id,
    required this.splashScreenImage,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SplashScreen.fromJson(Map<String, dynamic> json) => SplashScreen(
        id: json["id"],
        splashScreenImage: json["splash_screen_image"],
        version: json["version"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "splash_screen_image": splashScreenImage,
        "version": version,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class AppUrl {
  final int id;
  final String androidUrl;
  final String isoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppUrl({
    required this.id,
    required this.androidUrl,
    required this.isoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppUrl.fromJson(Map<String, dynamic> json) => AppUrl(
        id: json["id"],
        androidUrl: json["android_url"],
        isoUrl: json["iso_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "android_url": androidUrl,
        "iso_url": isoUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
