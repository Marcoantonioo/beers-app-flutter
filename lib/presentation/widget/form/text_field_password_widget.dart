import 'package:app_miles/app_miles.dart';
import 'package:app_miles/presentation/widget/icon_button/icon_button_widget.dart';

class TextFieldPassowrdWidget extends StatelessWidget {
  final Stream<String> stream;
  final Function(String) onChanged;
  final Stream<bool> visibilityStream;
  final Function(bool) onTapIcon;

  const TextFieldPassowrdWidget({
    required this.stream,
    required this.onChanged,
    required this.visibilityStream,
    required this.onTapIcon,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return StreamBuilder<String>(
      stream: stream,
      builder: (_, snapshot) {
        if (controller.text.isEmpty) {
          controller.text = snapshot.data.toString();
        }
        return StreamBuilder<bool>(
          stream: visibilityStream,
          builder: (_, snapshot) {
            final isVisible = snapshot.data ?? false;
            return TextFormField(
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: 20,
                  ),
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',
                hintText: '*********',
                hintStyle: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.grey, fontSize: 14),
                suffixIcon: IconButtonWidget(
                  onPressed: () => onTapIcon(!isVisible),
                  icon: isVisible ? Icons.visibility_off : Icons.visibility,
                ),
              ),
              maxLines: 1,
              maxLength: 8,
              onChanged: onChanged,
              obscureText: !isVisible,
              keyboardType: TextInputType.text,
            );
          },
        );
      },
    );
  }
}
