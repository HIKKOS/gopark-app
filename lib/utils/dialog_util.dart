import 'package:flutter/material.dart';
import 'package:gopark/config/themes/app_colors.dart';
import 'package:gopark/config/themes/app_themes.dart';
import 'package:gopark/presentation/widgets/morph_dialog.dart';
import 'package:gopark/utils/navigation_key.dart';
import 'package:gopark/utils/navigation_util.dart';

class Dialogs {
  static GlobalKey<NavigatorState> navigatorKey = NavigationKey.navigatorKey;
  static AlertDialog _buildDialog(
      {required String title,
      required String description,
      required String acceptText,
      VoidCallback? onAcceptPressed}) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Builder(
          builder: (context) => Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppTheme.borderRadius / 2),
                  topRight: Radius.circular(AppTheme.borderRadius / 2),
                ),
                color: LightColors.secondary,
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
                  onPressed: onAcceptPressed,
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  static Future<dynamic> showAlert(
      {required String title,
      required String description,
      required String acceptText,
      VoidCallback? onAcceptPressed}) {
    final dialog = _buildDialog(
        title: title,
        acceptText: acceptText,
        description: description,
        onAcceptPressed: onAcceptPressed);
    return showDialog(
        context: navigatorKey.currentState!.context,
        builder: (context) {
          return dialog;
        });
  }

  static Future<dynamic> showMorph({
    required String title,
    required String description,
    required String loadingTitle,
    String loadingDescription = 'Espere un momento...',
    required Future Function(BuildContext) onAcceptPressed,
    Function(BuildContext)? onCancelPressed,
    String acceptText = 'Aceptar',
    String cancelText = 'Cancelar',
    Color? acceptTextColor,
  }) {
    bool isLocked = true;

    return showDialog(
        context: navigatorKey.currentState!.context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => isLocked,
            child: MorphDialog(
              description: description,
              title: title,
              loadingDescription: loadingDescription,
              loadingTitle: loadingTitle,
              onAcceptPressed: (BuildContext context) async {
                isLocked = false;
                Navigation.unFocus();
                await onAcceptPressed.call(context);
                Navigation.pop(true);
              },
              onCancelPressed: (BuildContext context) async {
                isLocked = false;
                Navigation.unFocus();
                onCancelPressed?.call(context);
                Navigation.pop(false);
              },
              cancelText:
                  Text(cancelText, style: const TextStyle(fontSize: 18)),
              acceptText: Text(
                acceptText,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: acceptTextColor),
              ),
            ),
          );
        });
  }
}
/* 
  static Future<dynamic> showMorph(
      {required String title,
      required String description,
      required RefreshCallback onAcceptPressed}) {
    return showDialog(
        context: navigatorKey.currentState!.context,
        builder: (context) {
          return _buildMorp(
              description: description,
              title: title,
              onAcceptPressed: () async {
                await onAcceptPressed();
                Navigation.pop();
              });
        });
  }
} */