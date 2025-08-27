import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// A screen for viewing PDF documents from a network URL with enhanced UX and consistent app styling.
class PdfView extends StatefulWidget {
  const PdfView({super.key});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  // Arguments passed via GetX navigation
  final dynamic _arguments = Get.arguments;

  // Scroll controller for the CustomScrollView
  final ScrollController _scrollController = ScrollController();

  // PDF viewer controller for page navigation and zoom
  final PdfViewerController _pdfViewerController = PdfViewerController();

  // Cache manager for caching PDFs
  final DefaultCacheManager _cacheManager = DefaultCacheManager();

  // State variables for loading and error handling
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pdfViewerController.dispose();
    super.dispose();
  }

  /// Loads the PDF from cache or network, updating the UI state accordingly.
  Future<void> _loadPdf() async {
    try {
      final String pdfUrl = _arguments['link'] as String;
      // Check if PDF is cached
      final fileInfo = await _cacheManager.getFileFromCache(pdfUrl);
      if (fileInfo != null) {
        setState(() => _isLoading = false);
      } else {
        // Download and cache the PDF
        await _cacheManager.getSingleFile(pdfUrl);
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load PDF: $e';
      });
      _showErrorSnackBar(_errorMessage!);
    }
  }

  /// Displays an error snackbar with a styled message.
  void _showErrorSnackBar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: AppColor.scaffold1,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffold1,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          _buildAppBar(),
          _buildPdfViewer(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  /// Builds the SliverAppBar with a custom app bar styled with AppColor.
  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      toolbarHeight: Get.height * 0.2,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      flexibleSpace: CommonAppbar(
        title: 'PDF Viewer',
        isDrawerShow: false,
        isNotificationShow: false,
        onLeadingTap: () => Get.back(),
        clipper: CustomAppBarClipper(),
      ),
    );
  }

  /// Builds the PDF viewer or loading/error states.
  SliverFillRemaining _buildPdfViewer() {
    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? _buildLoadingIndicator()
            : _errorMessage != null
            ? _buildErrorWidget()
            : _buildPdfViewerWidget(),
      ),
    );
  }

  /// Builds a styled loading indicator using AppColor.
  Widget _buildLoadingIndicator() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColor.introBtnClr,
            strokeWidth: 3,
          ),
          SizedBox(height: 16),
          Text(
            'Loading PDF...',
            style: TextStyle(
              fontSize: 16,
              color: AppColor.lightTextClr,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds an error widget with a retry button styled with AppColor.
  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.redAccent,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            _errorMessage!,
            style: const TextStyle(
              fontSize: 16,
              color: AppColor.lightTextClr,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isLoading = true;
                _errorMessage = null;
              });
              _loadPdf();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.introBtnClr,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Retry',
              style: TextStyle(
                color: AppColor.scaffold1,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the PDF viewer widget with enhanced interactivity.
  Widget _buildPdfViewerWidget() {
    return SfPdfViewer.network(
      _arguments['link'],
      controller: _pdfViewerController,
      enableDoubleTapZooming: true,
      enableDocumentLinkAnnotation: true,
      onDocumentLoaded: (details) {
        setState(() => _isLoading = false);
      },
      onDocumentLoadFailed: (details) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to load PDF: ${details.description}';
        });
        _showErrorSnackBar(_errorMessage!);
      },
    );
  }

  /// Builds a floating action button for page navigation styled with AppColor.
  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _pdfViewerController.jumpToPage(1);
        Get.snackbar(
          'Navigated',
          'Jumped to page 1',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: AppColor.introBtnClr,
          colorText: AppColor.scaffold1,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
      },
      backgroundColor: AppColor.introBtnClr,
      child: const Icon(
        Icons.first_page,
        color: AppColor.scaffold1,
      ),
    );
  }
}