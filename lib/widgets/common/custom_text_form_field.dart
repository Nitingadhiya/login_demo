import 'package:login_demo/config.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  var appCtrl = Get.isRegistered<AppController>() ? Get.find<AppController>() : Get.put(AppController());

  final TextEditingController? controller;
  final String? hint;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final int? errorMaxLines;
  final double? radius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? suffixIconPadding;
  final TextStyle? style, counterStyle;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? padding;
  final Color? fillColor;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final int? maxLength;
  final bool showCounter;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final bool showBoarder;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isDense;
  final bool autofocus;
  final InputBorder? inputBorder;
  final AutovalidateMode? autoValidateMode;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;

  CustomTextFormField({
    Key? key,
    this.controller,
    this.hint,
    this.hintText,
    this.labelText,
    this.errorText,
    this.errorMaxLines,
    this.radius,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconPadding,
    this.style,
    this.counterStyle,
    this.obscureText = false,
    this.validator,
    this.padding,
    this.fillColor,
    this.maxLines = 1,
    this.minLines = 1,
    this.keyboardType,
    this.enabled = true,
    this.maxLength,
    this.showCounter = false,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onChanged,
    this.showBoarder = true,
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.focusNode,
    this.textInputAction,
    this.inputFormatters,
    this.isDense,
    this.autofocus = false,
    this.inputBorder,
    this.autoValidateMode,
    this.textCapitalization = TextCapitalization.sentences,
    this.autofillHints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 36),
      borderSide: BorderSide(width: 1, style: showBoarder ? BorderStyle.solid : BorderStyle.none, color: appCtrl.appTheme.border),
    );

    return TextFormField(
      controller: controller,
      style: style ?? AppCss.paragraph,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLines: maxLines,
      minLines: minLines,
      enabled: enabled,
      maxLength: maxLength,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      focusNode: focusNode,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      autofocus: autofocus,
      autovalidateMode: autoValidateMode,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        enabledBorder: inputBorder,
        disabledBorder: inputBorder,
        border: inputBorder,
        focusedBorder: inputBorder,
        errorBorder: inputBorder,
        focusedErrorBorder: inputBorder,
        errorStyle: (style ?? AppCss.paragraphSmall).textColor(appCtrl.appTheme.error),
        filled: true,
        fillColor: fillColor ?? appCtrl.appTheme.lightGray,
        contentPadding: padding ?? const EdgeInsets.symmetric(horizontal: 12),
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,
        errorMaxLines: errorMaxLines ?? 2,
        counterText: showCounter ? null : '',
        counterStyle: counterStyle ?? AppCss.paragraph,
        isDense: isDense,
        prefixIcon: prefixIcon != null ? Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14), child: prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Padding(padding: EdgeInsets.symmetric(horizontal: suffixIconPadding ?? 12), child: suffixIcon) : null,
      ),
      autofillHints: autofillHints,
    );
  }
}