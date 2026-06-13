import 'package:flutter/material.dart';
import 'package:tasks_manager/l10n/app_localizations.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;

  const CustomButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      child: Text(AppLocalizations.of(context)!.addTask),
    );
  }
}
