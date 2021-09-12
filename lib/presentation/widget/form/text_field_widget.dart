import 'package:app_miles/app_miles.dart';

class TextFieldWidget extends StatelessWidget {
  final Stream<String> stream;
  final Function(String) onChanged;
  final String? label;
  final String? hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final int maxLength;
  final int maxLine;
  final bool enableBorder;
  final bool enableOutlineBorder;

  const TextFieldWidget(
      {required this.stream,
      required this.onChanged,
      this.label,
      this.hint,
      this.keyboardType,
      this.obscureText = false,
      this.hintStyle,
      this.labelStyle,
      this.maxLength = 100,
      this.maxLine = 2,
      this.style,
      this.enableBorder = false,
      this.enableOutlineBorder = false});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        final value = snapshot.data.toString();
        if (controller.text.isEmpty && snapshot.hasData) {
          controller.text = value;
        }
        return TextFormField(
          controller: controller,
          style: style,
          decoration: InputDecoration(
              enabledBorder: enableOutlineBorder
                  ? const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    )
                  : null,
              focusedBorder: enableOutlineBorder
                  ? const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    )
                  : null,
              counterText: '',
              border: enableBorder ? null : InputBorder.none,
              labelText: label,
              hintText: hint,
              hintStyle: hintStyle,
              labelStyle: labelStyle),
          textCapitalization: keyboardType == TextInputType.emailAddress
              ? TextCapitalization.none
              : TextCapitalization.sentences,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLength: maxLength,
          maxLines: maxLine,
        );
      },
    );
  }
}
