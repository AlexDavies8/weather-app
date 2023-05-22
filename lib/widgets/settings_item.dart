import 'package:flutter/material.dart';

/// A widget representing a single location in the location list or setting on the settings page
class SettingsItem extends StatelessWidget {
  final Function? onTap;
  final Widget? leading;
  final Widget? trailing;
  final String text;

  const SettingsItem({
    required this.text,
    this.onTap,
    this.leading,
    this.trailing,
    super.key
  });

  /// A factory constructor for creating a SettingsItem with a toggle switch
  factory SettingsItem.toggle({
    required String text,
    required bool value,
    required Function(bool) onChanged,
    leading,
  }) => SettingsItem(
    text: text,
    onTap: () => onChanged(!value),
    trailing: SizedBox(height: 20, child: Switch(value: value, onChanged: onChanged)),
    leading: leading
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        hoverColor: theme.hoverColor,
        onTap: () => onTap?.call(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            children: [
              leading == null ? null : Padding(padding: const EdgeInsets.only(right: 20), child: leading),
              Expanded(child: Text(text, style: const TextStyle(fontSize: 18))),
              trailing == null ? null : Padding(padding: const EdgeInsets.only(left: 20), child: trailing)
            ].whereType<Widget>().toList()
          )
        )
      ),
    );
  }
}