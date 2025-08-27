import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/quiz_controller/quiz_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/extension/dimmention/dimmention.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';

class QuizViewScreen extends StatelessWidget {
  QuizViewScreen({super.key});
  final quizController = Get.find<QuizController>();

  // Constants for consistent styling
  static const double _padding = 16.0;
  static const double _cardMargin = 8.0;
  static const double _fontSizeTitle = 18.0;
  static const double _fontSizeBody = 14.0;
  static const double _fontSizeSmall = 13.0;
  static const double _buttonHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffold2,
      floatingActionButton: _buildFloatingActionButton(),
      body: Obx(() {
        if (quizController.isLoading.value) {
          return _buildLoadingScreen();
        }
        if (quizController.errorMessage.value.isNotEmpty) {
          return _buildErrorScreen();
        }
        return _buildQuizContent(context);
      }),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColor.bgColor,
            strokeWidth: 6.0,
          ),
          const SizedBox(height: 16),
          Text(
            'Getting your quiz ready...',
            style: TextStyle(
              fontSize: _fontSizeBody,
              color: AppColor.textClr,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.redAccent,
            size: 48,
            semanticLabel: 'Error',
          ),
          const SizedBox(height: 16),
          Text(
            quizController.errorMessage.value,
            style: TextStyle(
              fontSize: _fontSizeBody,
              color: AppColor.textClr,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: quizController.takeTestSeriesApi,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.bgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              minimumSize: const Size(120, _buttonHeight),
            ),
            child: Text(
              'Try Again',
              style: TextStyle(
                fontSize: _fontSizeSmall,
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizContent(BuildContext context) {
    return CustomScrollView(
      controller: quizController.scrollerController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          elevation: 0,
          toolbarHeight: Get.height * 0.16,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          flexibleSpace: CommonAppbar(
            isSearchShow: false,
            isDrawerShow: false,
            title: quizController.takeTestSeriesData.value.testTitle ?? 'Quiz',
            isNotificationShow: false,
            onLeadingTap: () => _showExitDialog(context),
            clipper: CustomAppBarClipper(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _padding,
              vertical: _padding / 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuizHeader(),
                SizedBox(height: Get.height * 0.01),
                _QuizProgressBar(),
                SizedBox(height: Get.height * 0.02),
                _QuizCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuizHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => Text(
          'Question ${quizController.currentPageIndex.value + 1}/${quizController.takeTestSeriesData.value.questionCount ?? 0}',
          style: TextStyle(
            fontSize: _fontSizeTitle,
            color: AppColor.textClr,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        )),
        Obx(() => Row(
          children: [
            Icon(
              Icons.timer,
              size: 20,
              color: AppColor.quizTextClr,
              semanticLabel: 'Time remaining',
            ),
            const SizedBox(width: 4),
            Text(
              quizController.formatDuration(
                  quizController.remainingTime.value),
              style: TextStyle(
                fontSize: _fontSizeBody,
                color: AppColor.quizTextClr,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        )),
      ],
    );
  }

  Widget _QuizProgressBar() {
    return Obx(() {
      final questionCount =
          quizController.takeTestSeriesData.value.questionCount ?? 0;
      final progress = questionCount == 0
          ? 0.0
          : (quizController.currentPageIndex.value + 1) / questionCount;
      return Container(
        height: 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: AppColor.dividerClr.withOpacity(0.2),
        ),
        child: LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.bgColor),
        ),
      );
    });
  }

  Widget _QuizCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Get.height * 0.65,
          child: Obx(() => PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: quizController.pageController.value,
            itemCount:
            quizController.takeTestSeriesData.value.questionCount ?? 0,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (value) =>
            quizController.currentPageIndex.value = value,
            itemBuilder: (context, index) {
              return _QuestionCard(index: index);
            },
          )),
        ),
        SizedBox(height: Get.height * 0.015),
        _QuestionIndicator(),
      ],
    );
  }

  Widget _QuestionCard({required int index}) {
    final question = quizController.takeTestSeriesData.value.questions
        ?.elementAtOrNull(index);
    if (question == null) {
      return Center(
        child: Semantics(
          label: 'No question available',
          child: Text(
            'No question available',
            style: TextStyle(
              fontSize: _fontSizeBody,
              color: AppColor.textClr,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      );

    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: _cardMargin),
      padding: const EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.white,
            AppColor.scaffold2.withOpacity(0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.boxShadowClr.withOpacity(0.08),
            offset: const Offset(0, 3),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.questionText ?? '',
            style: TextStyle(
              fontSize: _fontSizeBody,
              color: AppColor.quizTextClr,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
            semanticsLabel: 'Question: ${question.questionText}',
          ),
          SizedBox(height: Get.height * 0.015),
          Expanded(
            child: question.questionType == 'multiple-choice'
                ? _MultipleChoiceOptions(index: index)
                : _TextInputField(index: index),
          ),
          SizedBox(height: Get.height * 0.015),
          _ActionButtons(index: index),
        ],
      ),
    );
  }

  Widget _MultipleChoiceOptions({required int index}) {
    final options = quizController.takeTestSeriesData.value.questions
        ?.elementAtOrNull(index)
        ?.options ??
        [];
    if (options.isEmpty) {
      return Center(
        child: Semantics(
          label: 'No options available',
          child: Text(
            'No options available',
            style: TextStyle(
              fontSize: _fontSizeBody,
              color: AppColor.textClr,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: options.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, innerIndex) {
        return Obx(() {
          final isSelected = quizController.selectedAnswers.length > index &&
              quizController.selectedAnswers[index] == innerIndex;
          return GestureDetector(
            onTap: () {
              if (quizController.selectedAnswers.length > index) {
                quizController.selectedAnswers[index] = innerIndex;
                quizController.markedForReview.remove(index);
                Get.snackbar(
                  'Option Selected',
                  'You chose option ${innerIndex + 1}',
                  backgroundColor: AppColor.bgColor,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 1),
                  snackPosition: SnackPosition.TOP,
                );
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.quizOptionCardClr.withOpacity(0.7)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppColor.bgColor : AppColor.dividerClr,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? AppColor.bgColor : Colors.white,
                      border: Border.all(
                        color: isSelected ? AppColor.bgColor : AppColor.dividerClr,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                      semanticLabel: 'Selected',
                    )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      options[innerIndex],
                      style: TextStyle(
                        fontSize: _fontSizeBody,
                        color: AppColor.bottomAppBarTxtClr,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                      semanticsLabel: 'Option ${innerIndex + 1}: ${options[innerIndex]}',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget _TextInputField({required int index}) {
    return Obx(() {
      final controller = TextEditingController(
        text: quizController.selectedAnswers.length > index
            ? quizController.selectedAnswers[index]?.toString() ?? ''
            : '',
      );
      return TextField(
        controller: controller,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: 'Type your answer here...',
          hintStyle: TextStyle(
            color: AppColor.lightTextClr.withOpacity(0.6),
            fontFamily: 'Poppins',
            fontSize: _fontSizeBody,
          ),
          helperText: 'Provide a clear and concise answer.',
          helperStyle: TextStyle(
            color: AppColor.lightTextClr,
            fontSize: _fontSizeSmall,
            fontFamily: 'Poppins',
          ),
          filled: true,
          fillColor: AppColor.quizOptionCardClr.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(
          fontSize: _fontSizeBody,
          color: AppColor.bottomAppBarTxtClr,
          fontFamily: 'Poppins',
        ),
        onChanged: (value) {
          if (quizController.selectedAnswers.length > index) {
            quizController.selectedAnswers[index] = value;
            quizController.markedForReview.remove(index);
            Get.snackbar(
              'Answer Saved',
              'Your answer has been recorded',
              backgroundColor: AppColor.bgColor,
              colorText: Colors.white,
              duration: const Duration(seconds: 1),
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.multiline,
      );
    });
  }

  Widget _ActionButtons({required int index}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Tooltip(
            message: 'Save this question to review later',
            child: OutlinedButton.icon(
              onPressed: () {
                quizController.markedForReview.add(index);
                Get.snackbar(
                  'Marked for Review',
                  'Question ${index + 1} saved for review',
                  backgroundColor: AppColor.bgColor,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 1),
                  snackPosition: SnackPosition.TOP,
                );
              },
              icon: const Icon(
                Icons.bookmark_border,
                size: 18,
                color: AppColor.textClr,
                semanticLabel: 'Mark for review',
              ),
              label: Text(
                'Review',
                style: TextStyle(
                  fontSize: _fontSizeSmall,
                  color: AppColor.textClr,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                side: const BorderSide(color: AppColor.textClr),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(0, _buttonHeight),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Tooltip(
            message: 'Go to the next question',
            child: OutlinedButton.icon(
              onPressed: quizController.skipQuestion,
              icon: const Icon(
                Icons.arrow_forward,
                size: 18,
                color: AppColor.textClr,
                semanticLabel: 'Next question',
              ),
              label: Text(
                'Next',
                style: TextStyle(
                  fontSize: _fontSizeSmall,
                  color: AppColor.textClr,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                side: const BorderSide(color: AppColor.textClr),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(0, _buttonHeight),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _QuestionIndicator() {
    return SizedBox(
      height: Get.height * 0.05,
      child: Center(
        child: Obx(() {
          final questionCount =
              quizController.takeTestSeriesData.value.questionCount ?? 0;
          if (questionCount == 0) {
            return Semantics(
              label: 'No questions available',
              child: Text(
                'No questions available',
                style: TextStyle(
                  fontSize: _fontSizeBody,
                  color: AppColor.textClr,
                  fontFamily: 'Poppins',
                ),
              ),
            );
;
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: questionCount,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final isCurrent = quizController.currentPageIndex.value == index;
              final isMarked = quizController.markedForReview.contains(index);
              final isAnswered = quizController.selectedAnswers.length > index &&
                  quizController.selectedAnswers[index] != null;
              return GestureDetector(
                onTap: () {
                  quizController.pageController.value.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isMarked
                        ? const Color(0xffFFE500)
                        : isAnswered
                        ? AppColor.bgColor.withOpacity(0.7)
                        : isCurrent
                        ? AppColor.bgColor
                        : AppColor.quizOptionCardClr.withOpacity(0.8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: _fontSizeSmall,
                        color: isCurrent || isMarked || isAnswered
                            ? Colors.white
                            : AppColor.textClr,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                      semanticsLabel: 'Question ${index + 1}',
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Obx(() {
      final isLastQuestion = quizController.currentPageIndex.value ==
          (quizController.takeTestSeriesData.value.questionCount! - 1);
      return FloatingActionButton.extended(
        onPressed: () => _showSubmitDialog(Get.context!),
        backgroundColor: AppColor.bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        label: Text(
          isLastQuestion ? 'Submit Quiz' : 'Finish Early',
          style: TextStyle(
            fontSize: _fontSizeBody,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        icon: Icon(
          isLastQuestion ? Icons.check_circle : Icons.flag,
          color: Colors.white,
          size: 24,
          semanticLabel: isLastQuestion ? 'Submit quiz' : 'Finish early',
        ),
        elevation: 6,
        tooltip: 'Submit or end the quiz',
        extendedPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      );
    });
  }

  void _showSubmitDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(_padding),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.bgColor.withOpacity(0.1),
                ),
                child: const Icon(
                  Icons.info_outline,
                  size: 36,
                  color: AppColor.bgColor,
                  semanticLabel: 'Information',
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Ready to Submit?',
                style: TextStyle(
                  fontSize: _fontSizeTitle,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textClr,
                  fontFamily: 'Poppins',
                ),
                semanticsLabel: 'Ready to submit your quiz?',
              ),
              const SizedBox(height: 8),
              Obx(() => Text(
                'Answered ${quizController.selectedAnswers.where((e) => e != null).length} of ${quizController.takeTestSeriesData.value.questionCount ?? 0} questions',
                style: TextStyle(
                  fontSize: _fontSizeSmall,
                  color: AppColor.lightTextClr,
                  fontFamily: 'Poppins',
                ),
                semanticsLabel:
                'Answered ${quizController.selectedAnswers.where((e) => e != null).length} out of ${quizController.takeTestSeriesData.value.questionCount ?? 0} questions',
              )),
              const SizedBox(height: 8),
              Obx(() => Text(
                'Time Left: ${quizController.formatDuration(quizController.remainingTime.value)}',
                style: TextStyle(
                  fontSize: _fontSizeSmall,
                  color: AppColor.lightTextClr,
                  fontFamily: 'Poppins',
                ),
                semanticsLabel:
                'Time left: ${quizController.formatDuration(quizController.remainingTime.value)}',
              )),
              const SizedBox(height: 8),
              Obx(() => Text(
                'Marked for Review: ${quizController.markedForReview.length}',
                style: TextStyle(
                  fontSize: _fontSizeSmall,
                  color: AppColor.lightTextClr,
                  fontFamily: 'Poppins',
                ),
                semanticsLabel:
                'Marked for review: ${quizController.markedForReview.length} questions',
              )),
              const SizedBox(height: 16),
              _buildQuestionOverview(),
              const SizedBox(height: 16),
              Obx(() {
                final progress =
                quizController.takeTestSeriesData.value.questionCount == 0
                    ? 0.0
                    : quizController.selectedAnswers
                    .where((e) => e != null)
                    .length /
                    (quizController
                        .takeTestSeriesData.value.questionCount ??
                        1);
                return Container(
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: AppColor.dividerClr.withOpacity(0.2),
                  ),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColor.bgColor),
                    semanticsLabel: 'Progress: ${(progress * 100).toInt()}%',
                  ),
                );
              }),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColor.bgColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        minimumSize: const Size(0, _buttonHeight),
                      ),
                      child: Text(
                        'Continue Quiz',
                        style: TextStyle(
                          color: AppColor.bgColor,
                          fontWeight: FontWeight.w500,
                          fontSize: _fontSizeSmall,
                          fontFamily: 'Poppins',
                        ),
                        semanticsLabel: 'Continue quiz',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        quizController.submitApi();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.bgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        minimumSize: const Size(0, _buttonHeight),
                      ),
                      child: Text(
                        'Submit Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: _fontSizeSmall,
                          fontFamily: 'Poppins',
                        ),
                        semanticsLabel: 'Submit quiz now',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuestionOverview() {
    return Obx(() {
      final questionCount =
          quizController.takeTestSeriesData.value.questionCount ?? 0;
      if (questionCount == 0) return const SizedBox.shrink();
      return Container(
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: questionCount,
          itemBuilder: (context, index) {
            final isAnswered = quizController.selectedAnswers.length > index &&
                quizController.selectedAnswers[index] != null;
            final isMarked = quizController.markedForReview.contains(index);
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                quizController.pageController.value.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                width: 40,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isMarked
                      ? const Color(0xffFFE500)
                      : isAnswered
                      ? AppColor.bgColor.withOpacity(0.7)
                      : AppColor.quizOptionCardClr.withOpacity(0.8),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: _fontSizeSmall,
                      color: isAnswered || isMarked ? Colors.white : AppColor.textClr,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                    semanticsLabel: 'Question ${index + 1}',
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(_padding),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.bgColor.withOpacity(0.1),
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  size: 36,
                  color: AppColor.bgColor,
                  semanticLabel: 'Warning',
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Leave Quiz?',
                style: TextStyle(
                  fontSize: _fontSizeTitle,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textClr,
                  fontFamily: 'Poppins',
                ),
                semanticsLabel: 'Leave quiz?',
              ),
              const SizedBox(height: 8),
              Text(
                'Your answers will be saved, but you may not be able to continue later.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: _fontSizeSmall,
                  color: AppColor.lightTextClr,
                  fontFamily: 'Poppins',
                ),
                semanticsLabel:
                'Your answers will be saved, but you may not be able to continue later.',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColor.bgColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        minimumSize: const Size(0, _buttonHeight),
                      ),
                      child: Text(
                        'Stay',
                        style: TextStyle(
                          color: AppColor.bgColor,
                          fontWeight: FontWeight.w500,
                          fontSize: _fontSizeSmall,
                          fontFamily: 'Poppins',
                        ),
                        semanticsLabel: 'Stay in quiz',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.bgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        minimumSize: const Size(0, _buttonHeight),
                      ),
                      child: Text(
                        'Leave',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: _fontSizeSmall,
                          fontFamily: 'Poppins',
                        ),
                        semanticsLabel: 'Leave quiz',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}