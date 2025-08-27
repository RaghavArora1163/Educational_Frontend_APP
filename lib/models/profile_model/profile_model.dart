class ProfileModel {
  bool? success;
  ProfileModelData? data;
  String? message;

  ProfileModel({this.success, this.data, this.message});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new ProfileModelData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class ProfileModelData {
  GeneralDetails? generalDetails;
  List<Tabs>? tabs;

  ProfileModelData({this.generalDetails, this.tabs});

  ProfileModelData.fromJson(Map<String, dynamic> json) {
    generalDetails = json['generalDetails'] != null
        ? new GeneralDetails.fromJson(json['generalDetails'])
        : null;
    if (json['tabs'] != null) {
      tabs = <Tabs>[];
      json['tabs'].forEach((v) {
        tabs!.add(new Tabs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.generalDetails != null) {
      data['generalDetails'] = this.generalDetails!.toJson();
    }
    if (this.tabs != null) {
      data['tabs'] = this.tabs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GeneralDetails {
  String? fullName;
  String? emailAddress;
  String? biography;
  String? avatarUrl;
  String? phoneNumber;
  String? registrationDate;
  UserPreferences? userPreferences;

  GeneralDetails(
      {this.fullName,
        this.emailAddress,
        this.biography,
        this.avatarUrl,
        this.phoneNumber,
        this.registrationDate,
        this.userPreferences,
        });

  GeneralDetails.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    emailAddress = json['emailAddress'];
    biography = json['biography'];
    avatarUrl = json['avatarUrl'];
    phoneNumber = json['phoneNumber'];
    registrationDate = json['registrationDate'];
    userPreferences = json['userPreferences'] != null
        ? new UserPreferences.fromJson(json['userPreferences'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['emailAddress'] = this.emailAddress;
    data['biography'] = this.biography;
    data['avatarUrl'] = this.avatarUrl;
    data['phoneNumber'] = this.phoneNumber;
    data['registrationDate'] = this.registrationDate;
    if (this.userPreferences != null) {
      data['userPreferences'] = this.userPreferences!.toJson();
    }
    return data;
  }
}

class UserPreferences {
  String? language;
  bool? notificationEnabled;

  UserPreferences({this.language, this.notificationEnabled});

  UserPreferences.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    notificationEnabled = json['notificationEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['notificationEnabled'] = this.notificationEnabled;
    return data;
  }
}

class Tabs {
  String? tabName;
  CourseProgress? courseProgress;
  TestSeriesProgress? testSeriesProgress;
  MyCourses? myCourses;
  MyTestSeries? myTestSeries;
  MyWishlist? myWishlist;
  MyCartItems? myCartItems;
  MyBooks? myBooks;
  MyOrders? myOrders;

  Tabs(
      {this.tabName,
        this.courseProgress,
        this.testSeriesProgress,
        this.myCourses,
        this.myTestSeries,
        this.myWishlist,
        this.myCartItems,
        this.myBooks,
        this.myOrders});

  Tabs.fromJson(Map<String, dynamic> json) {
    tabName = json['tabName'];
    courseProgress = json['courseProgress'] != null
        ? new CourseProgress.fromJson(json['courseProgress'])
        : null;
    testSeriesProgress = json['testSeriesProgress'] != null
        ? new TestSeriesProgress.fromJson(json['testSeriesProgress'])
        : null;
    myCourses = json['myCourses'] != null
        ? new MyCourses.fromJson(json['myCourses'])
        : null;
    myTestSeries = json['myTestSeries'] != null
        ? new MyTestSeries.fromJson(json['myTestSeries'])
        : null;
    myWishlist = json['myWishlist'] != null
        ? new MyWishlist.fromJson(json['myWishlist'])
        : null;
    myCartItems = json['myCartItems'] != null
        ? new MyCartItems.fromJson(json['myCartItems'])
        : null;
    myBooks =
    json['myBooks'] != null ? new MyBooks.fromJson(json['myBooks']) : null;
    myOrders = json['myOrders'] != null
        ? new MyOrders.fromJson(json['myOrders'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tabName'] = this.tabName;
    if (this.courseProgress != null) {
      data['courseProgress'] = this.courseProgress!.toJson();
    }
    if (this.testSeriesProgress != null) {
      data['testSeriesProgress'] = this.testSeriesProgress!.toJson();
    }
    if (this.myCourses != null) {
      data['myCourses'] = this.myCourses!.toJson();
    }
    if (this.myTestSeries != null) {
      data['myTestSeries'] = this.myTestSeries!.toJson();
    }
    if (this.myWishlist != null) {
      data['myWishlist'] = this.myWishlist!.toJson();
    }
    if (this.myCartItems != null) {
      data['myCartItems'] = this.myCartItems!.toJson();
    }
    if (this.myBooks != null) {
      data['myBooks'] = this.myBooks!.toJson();
    }
    if (this.myOrders != null) {
      data['myOrders'] = this.myOrders!.toJson();
    }
    return data;
  }
}

class CourseProgress {
  List<CourseProgressData>? courseProgressData;

  CourseProgress({this.courseProgressData});

  CourseProgress.fromJson(Map<String, dynamic> json) {
    if (json['courseProgressData'] != null) {
      courseProgressData = <CourseProgressData>[];
      json['courseProgressData'].forEach((v) {
        courseProgressData!.add(new CourseProgressData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseProgressData != null) {
      data['courseProgressData'] =
          this.courseProgressData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseProgressData {
  String? courseIdentifier;
  String? courseName;
  String? courseThumbnail;
  int? completionRate;
  String? lastVisited;

  CourseProgressData(
      {this.courseIdentifier,
        this.courseName,
        this.courseThumbnail,
        this.completionRate,
        this.lastVisited});

  CourseProgressData.fromJson(Map<String, dynamic> json) {
    courseIdentifier = json['courseIdentifier'];
    courseName = json['courseName'];
    courseThumbnail = json['courseThumbnail'];
    completionRate = json['completionRate'];
    lastVisited = json['lastVisited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseIdentifier'] = this.courseIdentifier;
    data['courseName'] = this.courseName;
    data['courseThumbnail'] = this.courseThumbnail;
    data['completionRate'] = this.completionRate;
    data['lastVisited'] = this.lastVisited;
    return data;
  }
}

class TestSeriesProgress {
  List<TestSeriesProgressData>? testSeriesProgressData;

  TestSeriesProgress({this.testSeriesProgressData});

  TestSeriesProgress.fromJson(Map<String, dynamic> json) {
    if (json['testSeriesProgressData'] != null) {
      testSeriesProgressData = <TestSeriesProgressData>[];
      json['testSeriesProgressData'].forEach((v) {
        testSeriesProgressData!.add(new TestSeriesProgressData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.testSeriesProgressData != null) {
      data['testSeriesProgressData'] =
          this.testSeriesProgressData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestSeriesProgressData {
  String? testSeriesIdentifier;
  String? testSeriesName;
  String? testSeriesThumbnail;
  int? completionRate;
  String? lastVisited;

  TestSeriesProgressData(
      {this.testSeriesIdentifier,
        this.testSeriesName,
        this.testSeriesThumbnail,
        this.completionRate,
        this.lastVisited});

  TestSeriesProgressData.fromJson(Map<String, dynamic> json) {
    testSeriesIdentifier = json['testSeriesIdentifier'];
    testSeriesName = json['testSeriesName'];
    testSeriesThumbnail = json['testSeriesThumbnail'];
    completionRate = json['completionRate'];
    lastVisited = json['lastVisited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testSeriesIdentifier'] = this.testSeriesIdentifier;
    data['testSeriesName'] = this.testSeriesName;
    data['testSeriesThumbnail'] = this.testSeriesThumbnail;
    data['completionRate'] = this.completionRate;
    data['lastVisited'] = this.lastVisited;
    return data;
  }
}

class MyCourses {
  List<MyCoursesData>? myCoursesData;

  MyCourses({this.myCoursesData});

  MyCourses.fromJson(Map<String, dynamic> json) {
    if (json['myCoursesData'] != null) {
      myCoursesData = <MyCoursesData>[];
      json['myCoursesData'].forEach((v) {
        myCoursesData!.add(new MyCoursesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myCoursesData != null) {
      data['myCoursesData'] =
          this.myCoursesData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyCoursesData {
  String? courseIdentifier;
  String? courseName;
  String? courseSummary;
  String? courseThumbnail;
  String? courseFee;
  String? accessDuration;

  MyCoursesData(
      {this.courseIdentifier,
        this.courseName,
        this.courseSummary,
        this.courseThumbnail,
        this.courseFee,
        this.accessDuration});

  MyCoursesData.fromJson(Map<String, dynamic> json) {
    courseIdentifier = json['courseIdentifier'];
    courseName = json['courseName'];
    courseSummary = json['courseSummary'];
    courseThumbnail = json['courseThumbnail'];
    courseFee = json['courseFee'];
    accessDuration = json['accessDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseIdentifier'] = this.courseIdentifier;
    data['courseName'] = this.courseName;
    data['courseSummary'] = this.courseSummary;
    data['courseThumbnail'] = this.courseThumbnail;
    data['courseFee'] = this.courseFee;
    data['accessDuration'] = this.accessDuration;
    return data;
  }
}

class MyTestSeries {
  List<MyTestSeriesData>? myTestSeriesData;

  MyTestSeries({this.myTestSeriesData});

  MyTestSeries.fromJson(Map<String, dynamic> json) {
    if (json['myTestSeriesData'] != null) {
      myTestSeriesData = <MyTestSeriesData>[];
      json['myTestSeriesData'].forEach((v) {
        myTestSeriesData!.add(new MyTestSeriesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myTestSeriesData != null) {
      data['myTestSeriesData'] =
          this.myTestSeriesData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyTestSeriesData {
  String? testSeriesIdentifier;
  String? testSeriesName;
  String? testSeriesSummary;
  String? testSeriesFee;
  String? testSeriesThumbnail;

  MyTestSeriesData(
      {this.testSeriesIdentifier,
        this.testSeriesName,
        this.testSeriesSummary,
        this.testSeriesFee,
        this.testSeriesThumbnail});

  MyTestSeriesData.fromJson(Map<String, dynamic> json) {
    testSeriesIdentifier = json['testSeriesIdentifier'];
    testSeriesName = json['testSeriesName'];
    testSeriesSummary = json['testSeriesSummary'];
    testSeriesFee = json['testSeriesFee'];
    testSeriesThumbnail = json['testSeriesThumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testSeriesIdentifier'] = this.testSeriesIdentifier;
    data['testSeriesName'] = this.testSeriesName;
    data['testSeriesSummary'] = this.testSeriesSummary;
    data['testSeriesFee'] = this.testSeriesFee;
    data['testSeriesThumbnail'] = this.testSeriesThumbnail;
    return data;
  }
}

class MyWishlist {
  MyWishlistData? myWishlistData;

  MyWishlist({this.myWishlistData});

  MyWishlist.fromJson(Map<String, dynamic> json) {
    myWishlistData = json['myWishlistData'] != null
        ? new MyWishlistData.fromJson(json['myWishlistData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myWishlistData != null) {
      data['myWishlistData'] = this.myWishlistData!.toJson();
    }
    return data;
  }
}

class MyWishlistData {
  List<Books>? books;
  List<TestSeries>? testSeries;
  List<MyWishlistCourses>? courses;

  MyWishlistData({this.books, this.testSeries, this.courses});

  MyWishlistData.fromJson(Map<String, dynamic> json) {
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books!.add(new Books.fromJson(v));
      });
    }
    if (json['testSeries'] != null) {
      testSeries = <TestSeries>[];
      json['testSeries'].forEach((v) {
        testSeries!.add(new TestSeries.fromJson(v));
      });
    }
    if (json['courses'] != null) {
      courses = <MyWishlistCourses>[];
      json['courses'].forEach((v) {
        courses!.add(new MyWishlistCourses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.books != null) {
      data['books'] = this.books!.map((v) => v.toJson()).toList();
    }
    if (this.testSeries != null) {
      data['testSeries'] = this.testSeries!.map((v) => v.toJson()).toList();
    }
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
  String? itemIdentifier;
  String? itemCategory;
  String? itemName;
  String? itemFee;
  String? itemThumbnail;
  String? bookFormat;

  Books(
      {this.itemIdentifier,
        this.itemCategory,
        this.itemName,
        this.itemFee,
        this.itemThumbnail,
        this.bookFormat});

  Books.fromJson(Map<String, dynamic> json) {
    itemIdentifier = json['itemIdentifier'];
    itemCategory = json['itemCategory'];
    itemName = json['itemName'];
    itemFee = json['itemFee'];
    itemThumbnail = json['itemThumbnail'];
    bookFormat = json['bookFormat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemIdentifier'] = this.itemIdentifier;
    data['itemCategory'] = this.itemCategory;
    data['itemName'] = this.itemName;
    data['itemFee'] = this.itemFee;
    data['itemThumbnail'] = this.itemThumbnail;
    data['bookFormat'] = this.bookFormat;
    return data;
  }
}


class MyWishlistCourses {
  String? itemIdentifier;
  String? itemCategory;
  String? itemName;
  String? itemFee;
  String? itemThumbnail;

  MyWishlistCourses(
      {this.itemIdentifier,
        this.itemCategory,
        this.itemName,
        this.itemFee,
        this.itemThumbnail,
        });

  MyWishlistCourses.fromJson(Map<String, dynamic> json) {
    itemIdentifier = json['itemIdentifier'];
    itemCategory = json['itemCategory'];
    itemName = json['itemName'];
    itemFee = json['itemFee'];
    itemThumbnail = json['itemThumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemIdentifier'] = this.itemIdentifier;
    data['itemCategory'] = this.itemCategory;
    data['itemName'] = this.itemName;
    data['itemFee'] = this.itemFee;
    data['itemThumbnail'] = this.itemThumbnail;
    return data;
  }
}

class TestSeries {
  String? itemIdentifier;
  String? itemCategory;
  String? itemName;
  String? itemFee;
  String? itemThumbnail;

  TestSeries(
      {this.itemIdentifier,
        this.itemCategory,
        this.itemName,
        this.itemFee,
        this.itemThumbnail});

  TestSeries.fromJson(Map<String, dynamic> json) {
    itemIdentifier = json['itemIdentifier'];
    itemCategory = json['itemCategory'];
    itemName = json['itemName'];
    itemFee = json['itemFee'];
    itemThumbnail = json['itemThumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemIdentifier'] = this.itemIdentifier;
    data['itemCategory'] = this.itemCategory;
    data['itemName'] = this.itemName;
    data['itemFee'] = this.itemFee;
    data['itemThumbnail'] = this.itemThumbnail;
    return data;
  }
}

class MyCartItems {
  List<MyCartItemsData>? myCartItemsData;

  MyCartItems({this.myCartItemsData});

  MyCartItems.fromJson(Map<String, dynamic> json) {
    if (json['myCartItemsData'] != null) {
      myCartItemsData = <MyCartItemsData>[];
      json['myCartItemsData'].forEach((v) {
        myCartItemsData!.add(new MyCartItemsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myCartItemsData != null) {
      data['myCartItemsData'] =
          this.myCartItemsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyCartItemsData {
  String? itemIdentifier;
  String? itemCategory;
  String? itemName;
  String? itemFee;
  int? itemQuantity;
  String? itemThumbnail;
  String? bookFormat;

  MyCartItemsData(
      {this.itemIdentifier,
        this.itemCategory,
        this.itemName,
        this.itemFee,
        this.itemQuantity,
        this.itemThumbnail,
        this.bookFormat});

  MyCartItemsData.fromJson(Map<String, dynamic> json) {
    itemIdentifier = json['itemIdentifier'];
    itemCategory = json['itemCategory'];
    itemName = json['itemName'];
    itemFee = json['itemFee'];
    itemQuantity = json['itemQuantity'];
    itemThumbnail = json['itemThumbnail'];
    bookFormat = json['bookFormat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemIdentifier'] = this.itemIdentifier;
    data['itemCategory'] = this.itemCategory;
    data['itemName'] = this.itemName;
    data['itemFee'] = this.itemFee;
    data['itemQuantity'] = this.itemQuantity;
    data['itemThumbnail'] = this.itemThumbnail;
    data['bookFormat'] = this.bookFormat;
    return data;
  }
}

class MyBooks {
  List<MyBooksData>? myBooksData;

  MyBooks({this.myBooksData});

  MyBooks.fromJson(Map<String, dynamic> json) {
    if (json['myBooksData'] != null) {
      myBooksData = <MyBooksData>[];
      json['myBooksData'].forEach((v) {
        myBooksData!.add(new MyBooksData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myBooksData != null) {
      data['myBooksData'] = this.myBooksData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyBooksData {
  String? bookIdentifier;
  String? bookName;
  String? bookFee;
  String? bookThumbnail;
  String? bookFormat;

  MyBooksData(
      {this.bookIdentifier,
        this.bookName,
        this.bookFee,
        this.bookThumbnail,
        this.bookFormat});

  MyBooksData.fromJson(Map<String, dynamic> json) {
    bookIdentifier = json['bookIdentifier'];
    bookName = json['bookName'];
    bookFee = json['bookFee'];
    bookThumbnail = json['bookThumbnail'];
    bookFormat = json['bookFormat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookIdentifier'] = this.bookIdentifier;
    data['bookName'] = this.bookName;
    data['bookFee'] = this.bookFee;
    data['bookThumbnail'] = this.bookThumbnail;
    data['bookFormat'] = this.bookFormat;
    return data;
  }
}

class MyOrders {
  List<MyOrdersData>? myOrdersData;

  MyOrders({this.myOrdersData});

  MyOrders.fromJson(Map<String, dynamic> json) {
    if (json['myOrdersData'] != null) {
      myOrdersData = <MyOrdersData>[];
      json['myOrdersData'].forEach((v) {
        myOrdersData!.add(new MyOrdersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myOrdersData != null) {
      data['myOrdersData'] = this.myOrdersData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyOrdersData {
  String? orderIdentifier;
  List<OrderedItems>? orderedItems;
  String? orderTotal;
  String? orderState;
  String? orderDate;

  MyOrdersData(
      {this.orderIdentifier,
        this.orderedItems,
        this.orderTotal,
        this.orderState,
        this.orderDate});

  MyOrdersData.fromJson(Map<String, dynamic> json) {
    orderIdentifier = json['orderIdentifier'];
    if (json['orderedItems'] != null) {
      orderedItems = <OrderedItems>[];
      json['orderedItems'].forEach((v) {
        orderedItems!.add(new OrderedItems.fromJson(v));
      });
    }
    orderTotal = json['orderTotal'];
    orderState = json['orderState'];
    orderDate = json['orderDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderIdentifier'] = this.orderIdentifier;
    if (this.orderedItems != null) {
      data['orderedItems'] = this.orderedItems!.map((v) => v.toJson()).toList();
    }
    data['orderTotal'] = this.orderTotal;
    data['orderState'] = this.orderState;
    data['orderDate'] = this.orderDate;
    return data;
  }
}

class OrderedItems {
  String? bookIdentifier;
  String? bookName;
  String? bookFee;
  int? bookQuantity;
  String? bookThumbnail;
  String? bookFormat;

  OrderedItems(
      {this.bookIdentifier,
        this.bookName,
        this.bookFee,
        this.bookQuantity,
        this.bookThumbnail,
        this.bookFormat});

  OrderedItems.fromJson(Map<String, dynamic> json) {
    bookIdentifier = json['bookIdentifier'];
    bookName = json['bookName'];
    bookFee = json['bookFee'];
    bookQuantity = json['bookQuantity'];
    bookThumbnail = json['bookThumbnail'];
    bookFormat = json['bookFormat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookIdentifier'] = this.bookIdentifier;
    data['bookName'] = this.bookName;
    data['bookFee'] = this.bookFee;
    data['bookQuantity'] = this.bookQuantity;
    data['bookThumbnail'] = this.bookThumbnail;
    data['bookFormat'] = this.bookFormat;
    return data;
  }
}
