class StudentProfileModel {
  final bool? success;
  final StudentProfileData? data;
  final String? message;

  StudentProfileModel({this.success, this.data, this.message});

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) {
    return StudentProfileModel(
      success: json['success'],
      data: json['data'] != null ? StudentProfileData.fromJson(json['data']) : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class StudentProfileData {
  final String? fullName;
  final String? emailAddress;
  final String? biography;
  final String? avatarUrl;
  final String? phoneNumber;
  final ShippingAddress? shippingAddress;
  final String? registrationDate;
  final UserPreferences? userPreferences;

  StudentProfileData({
    this.fullName,
    this.emailAddress,
    this.biography,
    this.avatarUrl,
    this.phoneNumber,
    this.shippingAddress,
    this.registrationDate,
    this.userPreferences,
  });

  factory StudentProfileData.fromJson(Map<String, dynamic> json) {
    return StudentProfileData(
      fullName: json['fullName'],
      emailAddress: json['emailAddress'],
      biography: json['biography'],
      avatarUrl: json['avatarUrl'],
      phoneNumber: json['phoneNumber'],
      shippingAddress: json['shippingAddress'] != null
          ? ShippingAddress.fromJson(json['shippingAddress'])
          : null,
      registrationDate: json['registrationDate'],
      userPreferences: json['userPreferences'] != null
          ? UserPreferences.fromJson(json['userPreferences'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'emailAddress': emailAddress,
      'biography': biography,
      'avatarUrl': avatarUrl,
      'phoneNumber': phoneNumber,
      'shippingAddress': shippingAddress?.toJson(),
      'registrationDate': registrationDate,
      'userPreferences': userPreferences?.toJson(),
    };
  }
}

class ShippingAddress {
  final String? street;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;

  ShippingAddress({this.street, this.city, this.state, this.postalCode, this.country});

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
    };
  }
}

class UserPreferences {
  final String? language;
  final bool? notificationEnabled;

  UserPreferences({this.language, this.notificationEnabled});

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      language: json['language'],
      notificationEnabled: json['notificationEnabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'notificationEnabled': notificationEnabled,
    };
  }
}