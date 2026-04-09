import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/empty_state.dart';

class ChatPage extends StatelessWidget {
  final String conversationId;

  const ChatPage({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Andi Pratama'),
            Text(
              'Online',
              style: theme.textTheme.labelSmall?.copyWith(
                color: const Color(0xFF16A34A),
                fontSize: 10,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.r),
              children: [
                _DateSeparator(theme: theme, date: 'Hari Ini'),
                SizedBox(height: 8.h),
                _MessageBubble(
                  message: 'Halo, apakah produk ini masih tersedia?',
                  time: '14:30',
                  isMe: false,
                  theme: theme,
                ),
                SizedBox(height: 8.h),
                _MessageBubble(
                  message: 'Halo! Masih tersedia kak. Bisa langsung dipesan ya.',
                  time: '14:32',
                  isMe: true,
                  theme: theme,
                ),
                SizedBox(height: 8.h),
                _MessageBubble(
                  message: 'Boleh minta foto detailnya? Dan apa bisa nego?',
                  time: '14:35',
                  isMe: false,
                  theme: theme,
                ),
                SizedBox(height: 8.h),
                _MessageBubble(
                  message: 'Bisa kak, ini fotonya ya. Nego tipis boleh 😊',
                  time: '14:38',
                  isMe: true,
                  theme: theme,
                ),
                SizedBox(height: 8.h),
                _MessageBubble(
                  message: 'Kalau Rp 20.000.000 bagaimana? Bisa cod jaksel?',
                  time: '14:40',
                  isMe: false,
                  theme: theme,
                ),
              ],
            ),
          ),
          // Input Bar
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: theme.colorScheme.outline.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.attach_file,
                      color: theme.colorScheme.outline,
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Text(
                        'Ketik pesan...',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateSeparator extends StatelessWidget {
  final ThemeData theme;
  final String date;

  const _DateSeparator({required this.theme, required this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          date,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final ThemeData theme;

  const _MessageBubble({
    required this.message,
    required this.time,
    required this.isMe,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 280.w,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: isMe
              ? theme.colorScheme.primary
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: isMe ? Radius.circular(16.r) : Radius.circular(4.r),
            bottomRight: isMe ? Radius.circular(4.r) : Radius.circular(16.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isMe
                    ? Colors.white
                    : theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              time,
              style: theme.textTheme.labelSmall?.copyWith(
                color: isMe
                    ? Colors.white.withValues(alpha: 0.7)
                    : theme.colorScheme.onSurface.withValues(alpha: 0.4),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
