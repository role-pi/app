import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/modal_popup.dart';

class FormItemDatePicker extends FormField<DateTime> {
  FormItemDatePicker({
    Key? key,
    title,
    required DateTime? initialValue,
    FormFieldSetter<DateTime>? onSaved,
    FormFieldValidator<DateTime>? validator,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: AutovalidateMode.always,
          initialValue: initialValue,
          builder: (FormFieldState<DateTime> state) {
            return _DatePickerButton(
              title: title,
              dateTime: state.value,
              onDateTimeChanged: (newDateTime) {
                state.save();
                state.didChange(newDateTime);
              },
            );
          },
        );

  @override
  FormFieldState<DateTime> createState() => FormFieldState<DateTime>();
}

class _DatePickerButton extends StatelessWidget {
  const _DatePickerButton({
    required this.title,
    required this.dateTime,
    required this.onDateTimeChanged,
  });

  final String title;
  final DateTime? dateTime;
  final Function(DateTime) onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElasticButton(
        onTap: () => ModalPopup(
          context: context,
          title: title,
          height: 320,
          child: SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              initialDateTime: dateTime,
              use24hFormat: true,
              onDateTimeChanged: onDateTimeChanged,
            ),
          ),
        ).show(),
        child: Container(
          decoration: BoxDecoration(
            color: CupertinoDynamicColor.resolve(
              CupertinoColors.systemGrey6,
              context,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Text(
            dateTime == null
                ? ""
                : '${dateTime!.day}/${dateTime!.month} ${dateTime!.hour}:${dateTime!.minute}',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.0,
              color: CupertinoColors.secondaryLabel.resolveFrom(context),
            ),
          ),
        ),
      ),
    );
  }
}
