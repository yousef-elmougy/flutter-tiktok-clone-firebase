import '../../lib_exports.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.maxLine = 1,
    this.labelText,
    this.onSaved,
    this.onChanged,
    this.onTap,
    this.initialValue,
    this.controller,
    this.border,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.enabled = true,
    this.obscureText = false,
    this.validator,
    this.maxLength,
    this.textInputAction = TextInputAction.next,
    this.labelHintStyle,
    this.filled = false,
    this.fillColor,
    this.keyboardType,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.hintText,
  });

  final int maxLine;
  final int? maxLength;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final InputBorder? border;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool filled;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final TextInputAction textInputAction;
  final TextStyle? labelHintStyle;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) => TextFormField(
        textInputAction: textInputAction,
        controller: controller,
        keyboardType: keyboardType,
        autofocus: autofocus,
        readOnly: readOnly,
        onFieldSubmitted: onFieldSubmitted,
        initialValue: initialValue,
        obscureText: obscureText,
        enabled: enabled,
        onTap: onTap,
        textAlign: textAlign,
        inputFormatters: inputFormatters,
        validator: validator ??
            (value) => value?.isEmpty ?? false || value == null
                ? 'Field is Required'
                : null,
        onSaved: onSaved,
        onChanged: onChanged,
        cursorColor: kWhiteColor,
        decoration: InputDecoration(
          fillColor: fillColor,
          filled: filled,
          enabledBorder: border ?? buildBorder(),
          errorBorder: border ?? buildBorder(Colors.red),
          focusedBorder: border ?? buildBorder(kWhiteColor),
          border: border ?? buildBorder(),
          hintText: hintText,
          labelText: labelText,
          hintStyle: labelHintStyle,
          labelStyle: labelHintStyle ?? const TextStyle(color: kGrayColor),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          suffixIconColor: kGrayColor,
          prefixIconColor: kGrayColor,
        ),
        maxLines: maxLine,
        maxLength: maxLength,
      );

  OutlineInputBorder buildBorder([Color? color]) => OutlineInputBorder(
        borderSide: BorderSide(color: color ?? kGrayColor),
        // borderRadius: BorderRadius.circular(15),
      );
}
