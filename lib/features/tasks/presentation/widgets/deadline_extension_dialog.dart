import 'package:flutter/material.dart';

class DeadlineExtensionDialog extends StatefulWidget {
  final DateTime currentDeadline;
  final ValueChanged<DateTime> onExtended;

  const DeadlineExtensionDialog({
    super.key,
    required this.currentDeadline,
    required this.onExtended,
  });

  @override
  State<DeadlineExtensionDialog> createState() =>
      _DeadlineExtensionDialogState();
}

class _DeadlineExtensionDialogState extends State<DeadlineExtensionDialog> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.currentDeadline.add(const Duration(days: 1));
    _selectedTime = TimeOfDay.fromDateTime(widget.currentDeadline);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.update_rounded,
                    color: cs.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Extend Deadline',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                    Text(
                      'One-time extension only',
                      style: TextStyle(
                        fontSize: 13,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            _InfoRow(
              label: 'Current',
              value: _formatDateTime(widget.currentDeadline),
              cs: cs,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _PickerTile(
                    icon: Icons.calendar_today_rounded,
                    label: _selectedDate != null
                        ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                        : 'Select date',
                    onTap: _pickDate,
                    cs: cs,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _PickerTile(
                    icon: Icons.access_time_rounded,
                    label: _selectedTime != null
                        ? '${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                        : 'Select time',
                    onTap: _pickTime,
                    cs: cs,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _confirm,
                child: const Text('Extend Deadline'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? widget.currentDeadline,
      firstDate: widget.currentDeadline.add(const Duration(days: 1)),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  void _confirm() {
    if (_selectedDate == null || _selectedTime == null) return;
    final newDeadline = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );
    if (newDeadline.isBefore(widget.currentDeadline) ||
        newDeadline.isAtSameMomentAs(widget.currentDeadline)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('New deadline must be later than current')),
      );
      return;
    }
    widget.onExtended(newDeadline);
    Navigator.pop(context);
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final ColorScheme cs;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _PickerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final ColorScheme cs;

  const _PickerTile({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: cs.outlineVariant),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: cs.primary),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: cs.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
