import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final darkColorScheme = ShadColorScheme.fromName(
  'slate',
  brightness: Brightness.dark,
);
final lightTheme = ShadThemeData(
  brightness: Brightness.light,
  colorScheme: ShadColorScheme.fromName('blue'),
);

final darkTheme = ShadThemeData(
  brightness: Brightness.dark,
  accordionTheme: const ShadAccordionTheme(),
  progressTheme: ShadProgressTheme(color: darkColorScheme.primary),
  colorScheme: ShadColorScheme(
    background: darkColorScheme.background,
    foreground: darkColorScheme.foreground,
    card: darkColorScheme.secondary,
    cardForeground: darkColorScheme.cardForeground,
    popover: darkColorScheme.popover,
    popoverForeground: darkColorScheme.popoverForeground,
    primary: darkColorScheme.primary,
    primaryForeground: darkColorScheme.primaryForeground,
    secondary: darkColorScheme.secondary,
    secondaryForeground: darkColorScheme.secondaryForeground,
    muted: darkColorScheme.muted,
    mutedForeground: darkColorScheme.mutedForeground,
    accent: darkColorScheme.accent,
    accentForeground: darkColorScheme.accentForeground,
    destructive: darkColorScheme.destructive,
    destructiveForeground: darkColorScheme.destructiveForeground,
    border: darkColorScheme.border,
    input: darkColorScheme.input,
    ring: darkColorScheme.ring,
    selection: darkColorScheme.selection,
  ),
);
