import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/models/test_progress_model/test_progress_model.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/extension/dimmention/dimmention.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';

// Controller to manage expansion state of question cards
class ResultScreenController extends GetxController {
  late List<RxBool> isExpandedList;

  void initializeExpansionStates(int questionCount) {
    isExpandedList = List.generate(questionCount, (_) => false.obs);
  }

  void toggleExpansion(int index) {
    isExpandedList[index].value = !isExpandedList[index].value;
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  // Constants for consistent styling, matching QuizViewScreen
  static const double _padding = 16.0;
  static const double _cardMargin = 8.0;
  static const double _fontSizeTitle = 18.0;
  static const double _fontSizeBody = 14.0;
  static const double _fontSizeSmall = 13.0;
  static const double _buttonHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    final TestProgressData? progressData = Get.arguments['progressData'];

    // Initialize controller and expansion states if progressData is available
    final ResultScreenController controller = Get.put(ResultScreenController());
    if (progressData != null && progressData.questions != null) {
      controller.initializeExpansionStates(progressData.questions!.length);
    }

    if (progressData == null) {
      return Scaffold(
        backgroundColor: AppColor.scaffold2,
        body: Center(
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
                'No results available',
                style: TextStyle(
                  fontSize: _fontSizeBody,
                  color: AppColor.textClr,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
                semanticsLabel: 'No results available',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Get.offAllNamed('/testSeriesView'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.bgColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  minimumSize: const Size(120, _buttonHeight),
                ),
                child: Text(
                  'Back to Home',
                  style: TextStyle(
                    fontSize: _fontSizeSmall,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  semanticsLabel: 'Back to home',
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.scaffold2,
      body: CustomScrollView(
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
              title: progressData.testTitle ?? 'Quiz Result',
              isNotificationShow: false,
              onLeadingTap: () => Get.offAllNamed('/testSeriesView'),
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
                  _buildSummaryCard(progressData),
                  SizedBox(height: Get.height * 0.02),
                  Text(
                    'Question Details',
                    style: TextStyle(
                      fontSize: _fontSizeTitle,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textClr,
                      fontFamily: 'Poppins',
                    ),
                    semanticsLabel: 'Question Details',
                  ),
                  SizedBox(height: Get.height * 0.01),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final question = progressData.questions![index];
                return _buildQuestionCard(question, index, controller);
              },
              childCount: progressData.questions?.length ?? 0,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(_padding),
              child: ElevatedButton(
                onPressed: () => Get.offAllNamed('/testSeriesView'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.bgColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  minimumSize: Size(double.infinity, _buttonHeight),
                ),
                child: Text(
                  'Back to Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _fontSizeBody,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                  semanticsLabel: 'Back to home',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(TestProgressData progressData) {
    return AnimatedContainer(
      width: double.infinity,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      // margin: const EdgeInsets.symmetric(horizontal: _cardMargin),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Score',
                style: TextStyle(
                  fontSize: _fontSizeTitle,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textClr,
                  fontFamily: 'Poppins',
                ),
                semanticsLabel: 'Your Score',
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: progressData.score! / progressData.totalMarks! >= 0.6
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${(progressData.score! / progressData.totalMarks! * 100).toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: _fontSizeBody,
                    fontWeight: FontWeight.w600,
                    color: progressData.score! / progressData.totalMarks! >= 0.6
                        ? Colors.green
                        : Colors.red,
                    fontFamily: 'Poppins',
                  ),
                  semanticsLabel: 'Score percentage',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${progressData.score} / ${progressData.totalMarks}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: AppColor.quizTextClr,
              fontFamily: 'Poppins',
            ),
            semanticsLabel:
            'Score: ${progressData.score} out of ${progressData.totalMarks}',
          ),
          const SizedBox(height: 16),
          _buildSummaryRow(
            icon: Icons.check_circle,
            label: 'Completed',
            value: progressData.isCompleted ?? false ? 'Yes' : 'No',
            color: progressData.isCompleted ?? false ? Colors.green : Colors.red,
          ),
          _buildSummaryRow(
            icon: Icons.timer,
            label: 'Duration',
            value: progressData.meta?.duration ?? 'N/A',
          ),
          _buildSummaryRow(
            icon: Icons.calendar_today,
            label: 'Test Date',
            value: progressData.meta?.testDate ?? 'N/A',
          ),
          _buildSummaryRow(
            icon: Icons.access_time,
            label: 'Submitted At',
            value: progressData.meta?.submittedAt ?? 'N/A',
          ),
          _buildSummaryRow(
            icon: Icons.person,
            label: 'Created By',
            value: progressData.creatorName ?? 'N/A',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required IconData icon,
    required String label,
    required String value,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
        Icon(
        icon,
        size: 18,
        color: color ?? AppColor.lightTextClr,
        semanticLabel: label,
      ),
      const SizedBox(width: 8),
      Text(
        '$label: ',
        style: TextStyle(
          fontSize: _fontSizeSmall,
          color: AppColor.lightTextClr,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            fontSize: _fontSizeSmall,
            color: color ?? AppColor.lightTextClr,
            fontFamily: 'Poppins',
          ),
          semanticsLabel: '$label: $value',
        ),
      ),
      ],
    ),
    );
  }

  Widget _buildQuestionCard(ProgressQuestion question, int index, ResultScreenController controller) {
    return Obx(() {
      final isExpanded = controller.isExpandedList[index];
      return GestureDetector(
        onTap: () => controller.toggleExpansion(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(
            horizontal: _cardMargin,
            vertical: _cardMargin / 2,
          ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${index + 1}',
                    style: TextStyle(
                      fontSize: _fontSizeBody,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textClr,
                      fontFamily: 'Poppins',
                    ),
                    semanticsLabel: 'Question ${index + 1}',
                  ),
                  Row(
                    children: [
                      Icon(
                        question.isCorrect ?? false
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: question.isCorrect ?? false
                            ? Colors.green
                            : Colors.red,
                        size: 20,
                        semanticLabel: question.isCorrect ?? false
                            ? 'Correct'
                            : 'Incorrect',
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isExpanded.value
                            ? Icons.expand_less
                            : Icons.expand_more,
                        color: AppColor.textClr,
                        size: 20,
                        semanticLabel: isExpanded.value ? 'Collapse' : 'Expand',
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
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
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: isExpanded.value
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (question.questionType == 'multiple-choice') ...[
                      const SizedBox(height: 12),
                      Text(
                        'Options:',
                        style: TextStyle(
                          fontSize: _fontSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColor.lightTextClr,
                          fontFamily: 'Poppins',
                        ),
                        semanticsLabel: 'Options',
                      ),
                      ...?question.options?.asMap().entries.map((entry) {
                        final optionIndex = entry.key;
                        final option = entry.value;
                        final isStudentAnswer = question.studentAnswer ==
                            String.fromCharCode(65 + optionIndex);
                        final isCorrectAnswer =
                            question.correctAnswer == option;
                        return Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isStudentAnswer
                                      ? (isCorrectAnswer
                                      ? Colors.green
                                      : Colors.red)
                                      : isCorrectAnswer
                                      ? Colors.green
                                      : Colors.transparent,
                                  border: Border.all(
                                    color:
                                    isStudentAnswer || isCorrectAnswer
                                        ? (isCorrectAnswer
                                        ? Colors.green
                                        : Colors.red)
                                        : AppColor.dividerClr,
                                  ),
                                ),
                                child: isStudentAnswer
                                    ? Icon(
                                  isCorrectAnswer
                                      ? Icons.check
                                      : Icons.close,
                                  size: 16,
                                  color: Colors.white,
                                  semanticLabel: isCorrectAnswer
                                      ? 'Correct'
                                      : 'Incorrect',
                                )
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  '${String.fromCharCode(65 + optionIndex)}. $option',
                                  style: TextStyle(
                                    fontSize: _fontSizeSmall,
                                    color: isCorrectAnswer
                                        ? Colors.green
                                        : AppColor.bottomAppBarTxtClr,
                                    fontWeight: isCorrectAnswer
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                    fontFamily: 'Poppins',
                                  ),
                                  semanticsLabel:
                                  'Option ${String.fromCharCode(65 + optionIndex)}: $option',
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                    const SizedBox(height: 12),
                    Text(
                      'Your Answer: ${question.studentAnswer ?? "Not answered"}',
                      style: TextStyle(
                        fontSize: _fontSizeSmall,
                        color: question.isCorrect ?? false
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                      semanticsLabel:
                      'Your Answer: ${question.studentAnswer ?? "Not answered"}',
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Correct Answer: ${question.correctAnswer ?? "N/A"}',
                      style: TextStyle(
                        fontSize: _fontSizeSmall,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                      semanticsLabel:
                      'Correct Answer: ${question.correctAnswer ?? "N/A"}',
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Marks: ${question.marks ?? 0}',
                      style: TextStyle(
                        fontSize: _fontSizeSmall,
                        color: AppColor.lightTextClr,
                        fontFamily: 'Poppins',
                      ),
                      semanticsLabel: 'Marks: ${question.marks ?? 0}',
                    ),
                  ],
                )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      );
    });
  }
}