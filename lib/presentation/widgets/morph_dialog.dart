import 'package:flutter/material.dart';
import 'package:gopark/config/themes/app_colors.dart';
import 'package:gopark/config/themes/app_themes.dart';

final _style = ElevatedButton.styleFrom(
  backgroundColor: LightColors.primary,
  foregroundColor: Colors.white,
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
);

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius * 2),
      ),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  !isAccepted ? widget.title : widget.loadingTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: LightColors.primary,
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
                        child: TextButton(
                          style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppTheme.borderRadius))),
                              side: WidgetStateProperty.all(
                                  const BorderSide(color: LightColors.primary)),
                              shadowColor:
                                  WidgetStateProperty.all(Colors.black54),
                              overlayColor: WidgetStateProperty.all(
                                  LightColors.primaryObscure)),
                          onPressed: () {
                            widget.onCancelPressed?.call(context);
                          },
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(
                                color: Color.fromRGBO(37, 105, 229, 1),
                                fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                            style: _style,
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
