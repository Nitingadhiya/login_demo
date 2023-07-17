import 'package:login_demo/common/theme/app_css.dart';
import 'package:login_demo/controllers/common/app_controller.dart';
import 'package:login_demo/extensions/spacing.dart';
import 'package:login_demo/extensions/textstyle_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  var appCtrl = Get.isRegistered<AppController>() ? Get.find<AppController>() : Get.put(AppController());

  final String? title;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final GestureTapCallback? onTap;
  final TextStyle? style;
  final Color? color;
  final Widget? icon;
  final Widget? suffixIcon;
  final double? width;
  final Border? border;
  final bool? iconCenter;
  final bool? borderOnly;
  final bool isClickable;
  final TextAlign textAlign;

  CustomButton({
    Key? key,
    this.title,
    this.padding,
    this.radius = 30,
    this.onTap,
    this.style,
    this.color,
    this.icon,
    this.suffixIcon,
    this.width,
    this.border,
    this.iconCenter = false,
    this.borderOnly = false,
    this.isClickable = false,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isClickable,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          color: borderOnly == true ? appCtrl.appTheme.white : color ?? appCtrl.appTheme.primary,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                padding: padding ?? const EdgeInsets.all(Insets.i16),
                width: width ?? MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: borderOnly == true ? Border.all(color: appCtrl.appTheme.border) : border,
                  borderRadius: radius > 0 ? BorderRadius.circular(radius) : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null)
                      Row(
                        children: [
                          icon ?? const HSpace(0),
                          if (title != null) const HSpace(10),
                        ],
                      ),
                    if (title != null)
                      Expanded(
                        flex: iconCenter == true ? 0 : 1,
                        child: Text(
                          title ?? '',
                          style: style ?? AppCss.paragraphSemiBold.textColor(borderOnly == true ? appCtrl.appTheme.black : Colors.white),
                          textAlign: textAlign,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    if (suffixIcon != null)
                      Row(
                        children: [
                          suffixIcon ?? const HSpace(0),
                          if (title != null) const HSpace(10),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}