import 'package:app_miles/app_miles.dart';

class TextFieldLoginWidget extends StatelessWidget {
  final Stream<String> stream;
  final Function(String) onChanged;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final EdgeInsetsGeometry? padding;
  final String? hint;

  const TextFieldLoginWidget({
    required this.stream,
    required this.onChanged,
    this.keyboardType,
    this.maxLines,
    this.maxLength,
    this.padding,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Column(
        children: [
          StreamBuilder<String>(
              stream: stream,
              builder: (context, snapshot) {
                final value = snapshot.data.toString();
                if (controller.text.isEmpty && snapshot.hasData) {
                  controller.text = value;
                }
                return TextFormField(
                  controller: controller,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: hint,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusColor: Colors.black54,
                    counterText: '',
                    icon: const Icon(Icons.email_outlined, size: 16),
                  ),
                  maxLines: maxLines ?? 1,
                  maxLength: maxLength ?? 41,
                  onChanged: onChanged,
                  keyboardType: keyboardType ?? TextInputType.emailAddress,
                );
              }),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 0.3,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
