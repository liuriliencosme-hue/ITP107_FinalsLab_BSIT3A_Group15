import 'package:flutter/material.dart';

import '../models/task.dart';
import '../theme.dart';
import '../utils/date_utils.dart';

/// One row in the to-do list: checkbox, title, date and an edit button.
class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onEdit;

  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final overdue = !task.isDone && isOverdue(task.date);
    final dateColor = overdue ? AppColors.danger : AppColors.textSecondary;
    final dateLabel = isToday(task.date) ? 'Today' : formatDate(task.date);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(
            color: task.isDone ? AppColors.success : AppColors.accent,
            width: 4,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        onTap: onEdit,
        leading: Checkbox(
          value: task.isDone,
          onChanged: (_) => onToggle(),
          activeColor: AppColors.success,
          side: const BorderSide(color: AppColors.textSecondary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: task.isDone ? AppColors.textSecondary : AppColors.textPrimary,
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Icon(Icons.calendar_today_rounded, size: 14, color: dateColor),
              const SizedBox(width: 6),
              Text(
                overdue ? '$dateLabel  •  Overdue' : dateLabel,
                style: TextStyle(fontSize: 13, color: dateColor),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          tooltip: 'Edit task',
          icon: const Icon(Icons.edit_rounded, color: AppColors.accent),
          onPressed: onEdit,
        ),
      ),
    );
  }
}
