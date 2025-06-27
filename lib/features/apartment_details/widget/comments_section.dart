import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/utils/preference_manager.dart';
import 'package:mo3tarib/features/add_edit_apartment/logic/apartment_cubit.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/comment_model.dart';
import '../../add_edit_apartment/model/apartment_model.dart';

class CommentsSection extends StatefulWidget {
  const CommentsSection({
    super.key,
    this.apartment,
  });

  final ApartmentModel? apartment;

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final TextEditingController _commentController = TextEditingController();
  late final String userId;

  final List<CommentModel> _localComments = [];

  @override
  void initState() {
    super.initState();
    userId = PreferenceManager.getUserId()!;
    context.read<ApartmentCubit>().getApartmentComments(widget.apartment!.id!);
  }

  void _handleSendComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    final newComment = CommentModel(
      text: text,
      userId: userId,
      userName: PreferenceManager.getUsername() ?? "أنت",
    );

    setState(() {
      _localComments.insert(0, newComment); // عرض فوري
    });

    _commentController.clear();

    // محاولة إرسال الـ API
    context.read<ApartmentCubit>().addComment(widget.apartment!.id!, text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApartmentCubit, ApartmentState>(
      buildWhen: (previous, current) =>
          current is ApartmentCommentLoading ||
          current is ApartmentCommentFailed ||
          current is ApartmentCommentLoaded,
      builder: (context, state) {
        List<CommentModel> apiComments = [];

        if (state is ApartmentCommentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ApartmentCommentFailed) {
          return Center(child: Text(state.message));
        }

        if (state is ApartmentCommentLoaded) {
          apiComments = state.comments;
        }

        final allComments = [..._localComments, ...apiComments];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'التعليقات',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 300,
              child: allComments.isEmpty
                  ? const Center(child: Text("لا توجد تعليقات بعد"))
                  : ListView.builder(
                      reverse: true,
                      itemCount: allComments.length,
                      padding: const EdgeInsets.only(bottom: 8),
                      itemBuilder: (context, index) {
                        final comment = allComments[index];
                        return buildCommentItem(comment, userId);
                      },
                    ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'أضف تعليقًا...',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _handleSendComment,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Colors.orange,
                  ),
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildCommentItem(CommentModel comment, userId) {
    final isCurrentUser = comment.userId == userId;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          // صورة المستخدم
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.blue.shade700,
            child: Text(
              (comment.userName?.substring(0, 1) ?? '?').toUpperCase(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(width: 12),

          // محتوى التعليق
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الاسم والتاريخ
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      comment.userName ?? 'مستخدم',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                    // Text(
                    //   comment. ?? '', // تأكد إنه موجود
                    //   style: TextStyle(
                    //     fontSize: 10.sp,
                    //     color: Colors.grey.shade600,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 6),

                // فقاعة النص
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: isCurrentUser
                        ? const Color(0xffE8F5E9)
                        : const Color(0xffF5F5F5),
                    borderRadius: BorderRadius.only(
                      topRight: const Radius.circular(12),
                      topLeft: const Radius.circular(12),
                      bottomRight: Radius.circular(isCurrentUser ? 0 : 12),
                      bottomLeft: Radius.circular(isCurrentUser ? 12 : 0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Text(
                    comment.text ?? '',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
