import 'package:aventura_historia/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    group('lightTheme', () {
      test('uses Material 3', () {
        expect(AppTheme.lightTheme.useMaterial3, isTrue);
      });

      test('has light brightness', () {
        expect(AppTheme.lightTheme.brightness, Brightness.light);
      });

      test('has primary color', () {
        expect(AppTheme.lightTheme.colorScheme.primary, isNotNull);
      });

      test('app bar is centered', () {
        expect(AppTheme.lightTheme.appBarTheme.centerTitle, isTrue);
      });

      test('app bar has elevation', () {
        expect(AppTheme.lightTheme.appBarTheme.elevation, 2);
      });

      test('app bar title text style is white', () {
        final textStyle = AppTheme.lightTheme.appBarTheme.titleTextStyle!;
        expect(textStyle.color, Colors.white);
      });

      test('app bar title text is bold', () {
        final textStyle = AppTheme.lightTheme.appBarTheme.titleTextStyle!;
        expect(textStyle.fontWeight, FontWeight.bold);
      });

      test('app bar title text size is 22', () {
        final textStyle = AppTheme.lightTheme.appBarTheme.titleTextStyle!;
        expect(textStyle.fontSize, 22);
      });

      test('cards have elevation', () {
        expect(AppTheme.lightTheme.cardTheme.elevation, 4);
      });

      test('cards have rounded corners', () {
        final shape =
            AppTheme.lightTheme.cardTheme.shape as RoundedRectangleBorder;
        expect(shape.borderRadius, BorderRadius.circular(16));
      });

      test('buttons have proper padding', () {
        final buttonStyle = AppTheme.lightTheme.elevatedButtonTheme.style!;
        expect(buttonStyle.padding, isNotNull);
      });

      test('button text is bold', () {
        final buttonStyle = AppTheme.lightTheme.elevatedButtonTheme.style!;
        final textStyle = buttonStyle.textStyle!.resolve({})!;
        expect(textStyle.fontWeight, FontWeight.bold);
      });

      test('text theme has correct sizes', () {
        final textTheme = AppTheme.lightTheme.textTheme;
        expect(textTheme.displayLarge!.fontSize, 32);
        expect(textTheme.displayMedium!.fontSize, 28);
        expect(textTheme.titleLarge!.fontSize, 24);
        expect(textTheme.titleMedium!.fontSize, 20);
        expect(textTheme.bodyLarge!.fontSize, 18);
        expect(textTheme.bodyMedium!.fontSize, 16);
        expect(textTheme.bodySmall!.fontSize, 14);
      });
    });

    group('darkTheme', () {
      test('uses Material 3', () {
        expect(AppTheme.darkTheme.useMaterial3, isTrue);
      });

      test('has dark brightness', () {
        expect(AppTheme.darkTheme.brightness, Brightness.dark);
      });

      test('has primary color', () {
        expect(AppTheme.darkTheme.colorScheme.primary, isNotNull);
      });

      test('app bar is centered', () {
        expect(AppTheme.darkTheme.appBarTheme.centerTitle, isTrue);
      });

      test('app bar has elevation', () {
        expect(AppTheme.darkTheme.appBarTheme.elevation, 2);
      });

      test('cards have elevation', () {
        expect(AppTheme.darkTheme.cardTheme.elevation, 4);
      });

      test('cards have rounded corners', () {
        final shape =
            AppTheme.darkTheme.cardTheme.shape as RoundedRectangleBorder;
        expect(shape.borderRadius, BorderRadius.circular(16));
      });

      test('buttons have proper padding', () {
        final buttonStyle = AppTheme.darkTheme.elevatedButtonTheme.style!;
        expect(buttonStyle.padding, isNotNull);
      });

      test('button text is bold', () {
        final buttonStyle = AppTheme.darkTheme.elevatedButtonTheme.style!;
        final textStyle = buttonStyle.textStyle!.resolve({})!;
        expect(textStyle.fontWeight, FontWeight.bold);
      });
    });
  });
}
