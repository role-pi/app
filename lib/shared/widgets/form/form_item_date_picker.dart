import 'package:auto_size_text/auto_size_text.dart';
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
                state.didChange(newDateTime);
                state.save();
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
  final Function(DateTime?) onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElasticButton(
        onPressed: () {
          ModalPopup(
              context: context,
              padding: EdgeInsets.only(top: 48),
              title: title,
              child: SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  initialDateTime: dateTime,
                  use24hFormat: true,
                  onDateTimeChanged: onDateTimeChanged,
                ),
              )).show();

          if (dateTime == null) {
            onDateTimeChanged(DateTime.now());
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: CupertinoDynamicColor.resolve(
              CupertinoColors.systemGrey6,
              context,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.all(12.0),
          alignment: Alignment.center,
          child: SizedBox(
            height: 28,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (dateTime != null)
                  GestureDetector(
                    onTap: () {
                      onDateTimeChanged(null);
                    },
                    child: Icon(CupertinoIcons.xmark_circle_fill,
                        color:
                            CupertinoColors.tertiaryLabel.resolveFrom(context),
                        size: 18.0),
                  ),
                SizedBox(width: 4),
                Expanded(
                  child: AutoSizeText(
                    dateTime == null
                        ? "__ /__ /__ __:__"
                        : '${dateTime!.day}/${dateTime!.month} ${dateTime!.hour.toString().padLeft(2, '0')}:${dateTime!.minute.toString().padLeft(2, '0')}',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: dateTime == null ? 0.5 : -1,
                      color: (dateTime == null
                              ? CupertinoColors.tertiaryLabel
                              : CupertinoColors.secondaryLabel)
                          .resolveFrom(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
