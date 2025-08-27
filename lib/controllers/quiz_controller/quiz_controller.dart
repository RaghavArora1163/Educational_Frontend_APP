import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/models/take_test_series_model/take_test_series_model.dart';
import 'package:online/models/test_progress_model/test_progress_model.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';

class QuizController extends GetxController {
  final scrollerController = ScrollController();
  Rx<PageController> pageController = PageController().obs;
  RxInt currentPageIndex = 0.obs;
  RxList<dynamic> selectedAnswers = <dynamic>[].obs;
  Rx<TakeTestSeriesData> takeTestSeriesData = TakeTestSeriesData().obs;
  RxSet<int> markedForReview = <int>{}.obs;
  Timer? _timer;
  Rx<Duration> remainingTime = const Duration().obs;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    takeTestSeriesApi();
  }

  @override
  void onClose() {
    _timer?.cancel();
    scrollerController.dispose();
    pageController.value.dispose();
    super.onClose();
  }

  void _startCountdown(String durationStr) {
    int seconds = 0;
    final parts = durationStr.split(' ');
    if (parts.length == 2) {
      final value = int.tryParse(parts[0]) ?? 0;
      if (parts[1].toLowerCase().startsWith('min')) {
        seconds = value * 60;
      } else if (parts[1].toLowerCase().startsWith('sec')) {
        seconds = value;
      }
    }
    remainingTime.value = Duration(seconds: seconds);

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value.inSeconds <= 0) {
        timer.cancel();
        remainingTime.value = Duration.zero;
        _handleTimeUp();
      } else {
        remainingTime.value = remainingTime.value - const Duration(seconds: 1);
      }
    });
  }

  void _handleTimeUp() {
    Get.snackbar(
      'Time’s Up!',
      'The quiz has ended. Submitting your answers.',
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
    submitApi();
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void initializeSelections(int questionCount) {
    selectedAnswers.value = List.filled(questionCount, null);
  }

  void takeTestSeriesApi() async {
    isLoading.value = true;
    errorMessage.value = '';
    final data = {
      'testSeriesId': getIt.globalVariable.takeTestSeriesId,
      'testId': getIt.globalVariable.takeTestId,
    };
    try {
      final response = await ApiController().studentTakeTestSeries(
        apiUrl: ApiUrl.takeTestSeries,
        data: data,
      );
      if (response != null && response.success == true) {
        takeTestSeriesData.value = response.data;
        initializeSelections(takeTestSeriesData.value.questionCount ?? 0);
        _startCountdown(takeTestSeriesData.value.duration ?? '0 min');
      } else {
        errorMessage.value = response?.message ?? 'Failed to load quiz data';
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      errorMessage.value = 'Network error: $e';
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void skipQuestion() {
    if (currentPageIndex.value <
        (takeTestSeriesData.value.questionCount! - 1)) {
      pageController.value.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  bool validateAnswers() {
    final unanswered = selectedAnswers.where((answer) => answer == null).length;
    if (unanswered > 0) {
      Get.snackbar(
        'Incomplete',
        '$unanswered question(s) unanswered. Proceed anyway?',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return false;
    }
    return true;
  }

  List<Map<String, dynamic>> buildAnswerPayload() {
    final questions = takeTestSeriesData.value.questions ?? [];
    return List.generate(questions.length, (index) {
      final answer = selectedAnswers[index];
      final question = questions[index];
      final selectedAnswer = question.questionType == 'multiple-choice' &&
              answer != null
          ? String.fromCharCode(65 +
              (answer as int)) // Convert index to letter (0 -> A, 1 -> B, etc.)
          : answer?.toString() ?? '';

      return {
        'questionId': question.sId,
        'answer': selectedAnswer,
        'markedForReview': markedForReview.contains(index),
      };
    });
  }

  void submitApi() {
    if (!validateAnswers()) {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                size: 36,
                color: Colors.orange,
              ),
              const SizedBox(height: 12),
              const Text(
                'Incomplete Quiz',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${selectedAnswers.where((answer) => answer == null).length} question(s) unanswered. Proceed anyway?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Continue Quiz',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        _submitQuiz();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Submit Anyway',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      _submitQuiz();
    }
  }

  void _submitQuiz() async {
    final data = {
      'testSeriesId': getIt.globalVariable.takeTestSeriesId,
      'testId': getIt.globalVariable.takeTestId,
      'answers': buildAnswerPayload(),
    };
    try {
      final submitResponse = await ApiController().submitTakeTestSeries(
        apiUrl: ApiUrl.submitTest,
        data: data,
      );
      if (submitResponse != null && submitResponse.success == true) {
// Fetch test progress after successful submission
        final progressResponse = await ApiController().testProgress(
          apiUrl: ApiUrl.testProgress,
          data: {
            'testSeriesId': getIt.globalVariable.takeTestSeriesId,
            'testId': getIt.globalVariable.takeTestId,
          },
        );
        print("progressResponse is $progressResponse");
        print(progressResponse);
        if (progressResponse != null && progressResponse.success == true) {
          Get.offAllNamed(
            '/result',
            arguments: {
              'progressData': progressResponse.data,
            },
          );
        } else {
          Get.snackbar(
            'Error',
            progressResponse?.message ?? 'Failed to fetch test progress',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          submitResponse?.message ?? 'Failed to submit quiz',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Network error: $e',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}
