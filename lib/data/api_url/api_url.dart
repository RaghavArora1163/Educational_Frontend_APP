class ApiUrl{

  static String devBaseUrl = "";
  static String prodBaseUrl = "https://online-course-server.boostengine.in/v1/";
  static String localBaseUrl = "";
  static String signIn = "auth/login";
  static String studentFeatureCourses = "courses/get-all-courses";
  static String courseDetail = "courses/course-details-combined";
  static String studentAssignment = "assignments/students-assignments";
  static String studentQuizzes = "quizzes/student-quizzes";
  static String studentResources = "courses/resources";
  static String booksList = "books/book-list";
  static String testSeries = "test-series/test-series-list";
  static String testSeriesDetail = "test-series/details";
  static String takeTestSeries = "test-series/take-test";
  static String submitTest = "test-series/submit-test";
  static String bookDetails = "books/book-by-id";
  static String wishList = "wishlist/add";
  static String addToCart = "cart/add";
  static String lectureDetails = "courses/lecture-details";
  static String studentProfile = "student/students-profile";
  static String getStudentProfileForEdit = "student/general-details";
  static String updateStudentProfile = "student/general-details";
  static String payment = "purchases/app-purchase";
  static String liveClassStream = "live-classes/student-live-class";
  static String liveStreamUrl = "https://online-course-server.boostengine.in";
  static String youTubeUrl = "youtubeThumbnails";
  static String logout = "auth/logout";
  static String delete = "auth/delete-account";
  static String notifications = "notifications";
  static String getAllOrders = "orders/get-all-orders";
  static String testProgress = 'test-series/test-progress';
  static String orderBook = 'purchases/order-book';
  static String submitReview = 'reviews/';
  static String submitSupportQuery = 'support/';
  static String search = 'search/';
  static String fcmUpdate = 'auth/update-fcm-token';
}