import 'package:flutter/material.dart';
import 'package:gopark/config/themes/app_colors.dart';
import 'package:gopark/config/themes/app_themes.dart';

class MorphDialog extends StatefulWidget {
  const MorphDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.cancelText,
    required this.acceptText,
    required this.onAcceptPressed,
    this.onCancelPressed,
    required this.loadingTitle,
    required this.loadingDescription,
  }) : super(key: key);

  final String title, description, loadingTitle, loadingDescription;
  final Text cancelText, acceptText;
  final Function(BuildContext)? onAcceptPressed;
  final Function(BuildContext)? onCancelPressed;

  @override
  State<MorphDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<MorphDialog> {
  late bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
                  !isAccepted ? widget.title : widget.loadingTitle,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            child: Text(
              !isAccepted ? widget.description : widget.loadingDescription,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          if (!isAccepted)
            SizedBox(
                height: size.height * 0.075,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              overlayColor: WidgetStateProperty.all<Color>(
                                  Colors.white.withOpacity(0.25)),
                              foregroundColor: WidgetStateProperty.all<Color>(
                                  LightColors.secondary.withOpacity(0.5)),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  LightColors.secondary),
                              elevation: WidgetStateProperty.all(0)),
                          onPressed: () {
                            widget.onCancelPressed?.call(context);
                          },
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: WidgetStateProperty.all(0)),
                            onPressed: () {
                              _switchState();
                              widget.onAcceptPressed?.call(context);
                            },
                            child: widget.acceptText),
                      ),
                    ],
                  ),
                ))
          else
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
        ],
      ),
    );
  }

  void _switchState() {
    isAccepted = !isAccepted;
    setState(() {});
  }
}
