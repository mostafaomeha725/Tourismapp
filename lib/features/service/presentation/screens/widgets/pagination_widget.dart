import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/arrorw_button.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/pagination_number_chip.dart';

class PaginationWidget extends StatefulWidget {
  final int totalPages;
  final int currentPage;
  final Function(int) onPageChanged;

  const PaginationWidget({
    super.key,
    required this.totalPages,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  final ScrollController _scrollController = ScrollController();

  static const double _chipDefaultWidth = 42;
  static const double _chipActiveWidth = 48;
  static const double _chipHorizontalPadding = 4;

  @override
  void initState() {
    super.initState();
    _scrollToCurrentPage(jump: true);
  }

  @override
  void didUpdateWidget(covariant PaginationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPage != widget.currentPage ||
        oldWidget.totalPages != widget.totalPages) {
      _scrollToCurrentPage();
    }
  }

  void _scrollToCurrentPage({bool jump = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients || widget.totalPages <= 0) {
        return;
      }

      final safeCurrentPage = widget.currentPage.clamp(1, widget.totalPages);
      final pageIndex = safeCurrentPage - 1;
      final viewportWidth = _scrollController.position.viewportDimension;
      final itemExtent = _chipDefaultWidth + (_chipHorizontalPadding * 2);
      final itemLeadingOffset = pageIndex * itemExtent;
      final activeItemCenter = itemLeadingOffset + (_chipActiveWidth / 2);
      final rawOffset = activeItemCenter - (viewportWidth / 2);
      final targetOffset = rawOffset.clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      );

      if (jump) {
        _scrollController.jumpTo(targetOffset);
        return;
      }

      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canGoPrevious = widget.currentPage > 1;
    final canGoNext = widget.currentPage < widget.totalPages;
    final isCompactPagination = widget.totalPages <= 3;

    final pageChips = List.generate(widget.totalPages, (index) {
      final pageNum = index + 1;
      final isActive = pageNum == widget.currentPage;

      return PaginationNumberChip(
        pageNum: pageNum,
        isActive: isActive,
        onTap: () => widget.onPageChanged(pageNum),
      );
    });

    return Padding(
      padding: EdgeInsets.fromLTRB(4.w, 12.h, 4.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: AppText(
              'Page ${widget.currentPage} of ${widget.totalPages}',
              style: font12w700.copyWith(color: const Color(0xFF64748B)),
              alignment: AlignmentDirectional.center,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: const Color(0xFFE6EBF2), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withOpacity(0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: isCompactPagination
                ? Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ArrowNavButton(
                          icon: Icons.chevron_left,
                          isEnabled: canGoPrevious,
                          onTap: () =>
                              widget.onPageChanged(widget.currentPage - 1),
                        ),
                        SizedBox(width: 6.w),
                        ...pageChips,
                        SizedBox(width: 6.w),
                        ArrowNavButton(
                          icon: Icons.chevron_right,
                          isEnabled: canGoNext,
                          onTap: () =>
                              widget.onPageChanged(widget.currentPage + 1),
                        ),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      ArrowNavButton(
                        icon: Icons.chevron_left,
                        isEnabled: canGoPrevious,
                        onTap: () =>
                            widget.onPageChanged(widget.currentPage - 1),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(children: pageChips),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      ArrowNavButton(
                        icon: Icons.chevron_right,
                        isEnabled: canGoNext,
                        onTap: () =>
                            widget.onPageChanged(widget.currentPage + 1),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
