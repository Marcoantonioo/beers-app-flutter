import 'package:app_miles/app_miles.dart';
import 'package:app_miles/presentation/widget/icon_button/icon_button_widget.dart';

class TextFieldLoginPassowrdWidget extends StatelessWidget {
  final Stream<String> stream;
  final Function(String) onChanged;
  final Stream<bool> visibilityStream;
  final Function(bool) onTapIcon;

  const TextFieldLoginPassowrdWidget({
    required this.stream,
    required this.onChanged,
    required this.visibilityStream,
    required this.onTapIcon,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 0, bottom: 0, top: 0),
      child: Column(
        children: [
          StreamBuilder<String>(
              stream: stream,
              builder: (context, snapshot) {
                final value = snapshot.data.toString();
                if (controller.text.isEmpty && snapshot.hasData) {
                  controller.text = value;
                }
                return StreamBuilder<bool>(
                    stream: visibilityStream,
                    builder: (context, snapshot) {
                      final isVisible = snapshot.data ?? false;
                      return TextFormField(
                        controller: controller,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Senha',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          counterText: '',
                          icon: const Icon(Icons.lock_outline, size: 16),
                          suffixIcon: IconButton(
                            onPressed: () => onTapIcon(!isVisible),
                            icon: Icon(isVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                        obscureText: !isVisible,
                        maxLines: 1,
                        maxLength: 8,
                        onChanged: onChanged,
                        keyboardType: TextInputType.text,
                      );
                    });
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
