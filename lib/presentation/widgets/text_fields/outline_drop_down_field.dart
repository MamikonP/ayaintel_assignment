import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../../l10n/l10n.dart';
import '../../widgets.dart';

class OutlineDropDownField extends StatefulWidget {
  const OutlineDropDownField({
    super.key,
    required this.options,
    required this.label,
    this.hintText = '',
    this.validator,
    this.onChanged,
    this.selectable = false,
  });

  final List<String> options;
  final String label;
  final String hintText;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onChanged;
  final bool selectable;

  @override
  State<OutlineDropDownField> createState() => _OutlineDropDownFieldState();
}

class _OutlineDropDownFieldState extends State<OutlineDropDownField>
    with AuthControllerMixin {
  final List<String> selectedItems = [];
  late final ValueNotifier<String> _controllerNotifier;
  String _selectedItem = '';

  @override
  void initState() {
    super.initState();
    _controllerNotifier = ValueNotifier('');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DropdownButtonHideUnderline(
          child: ValueListenableBuilder(
            valueListenable: _controllerNotifier,
            builder: (context, value, child) =>
                DropdownButtonFormField2<String>(
              validator: widget.validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              menuItemStyleData: MenuItemStyleData(
                padding: kMedium.all,
                selectedMenuItemBuilder: (context, child) => ColoredBox(
                  color: AppTheme.currentThemeOf(context).colorScheme.primary,
                  child: child,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: searchController,
                searchInnerWidgetHeight: kTextFieldHeight,
                searchInnerWidget: Padding(
                  padding: kMedium.bottom,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppTheme.currentThemeOf(context).borderColor,
                          width: kBorderWidth,
                        ),
                      ),
                    ),
                    child: OutlineTextField(
                      controller: searchController,
                      hintText: L10n.of(context).tr.lblSearch,
                      outlined: false,
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppTheme.currentThemeOf(context)
                            .colorScheme
                            .secondary,
                      ),
                    ),
                  ),
                ),
              ),
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  if (widget.selectable) {
                    widget.onChanged?.call(_selectedItem);
                  }
                  searchController.clear();
                }
              },
              value: widget.selectable && selectedItems.isNotEmpty
                  ? selectedItems.last
                  : value.isEmpty
                      ? null
                      : value,
              onChanged: (String? newValue) {
                onFieldUpdated(newValue);
              },
              iconStyleData: IconStyleData(
                icon: const Icon(Icons.keyboard_arrow_down_sharp),
                iconEnabledColor: AppTheme.currentThemeOf(context).secondary,
                openMenuIcon: const Icon(Icons.keyboard_arrow_up_sharp),
              ),
              selectedItemBuilder: (context) {
                return widget.options.map(
                  (item) {
                    return Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                          widget.selectable && selectedItems.isNotEmpty
                              ? selectedItems.join(',')
                              : item,
                          style: AppTheme.currentThemeOf(context).bodyText1),
                    );
                  },
                ).toList();
              },
              items: widget.options
                  .toSet()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  key: ValueKey(value),
                  enabled: !widget.selectable,
                  child: !widget.selectable
                      ? Text(value.isNotEmpty ? value : '',
                          style: AppTheme.currentThemeOf(context).bodyText1)
                      : StatefulBuilder(
                          builder: (context, menuSetState) {
                            final isSelected = selectedItems.contains(value);
                            return InkWell(
                              onTap: () {
                                isSelected
                                    ? selectedItems.remove(value)
                                    : selectedItems.add(value);
                                _controllerNotifier.value =
                                    selectedItems.isNotEmpty
                                        ? selectedItems.last
                                        : '';
                                _selectedItem = selectedItems.join(',');
                                menuSetState(() {});
                              },
                              child: Container(
                                height: double.infinity,
                                padding: kLarge.horizontal,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(value.isNotEmpty ? value : '',
                                          style:
                                              AppTheme.currentThemeOf(context)
                                                  .bodyText1),
                                    ),
                                    Checkbox.adaptive(
                                      checkColor:
                                          AppTheme.currentThemeOf(context)
                                              .colorScheme
                                              .onPrimary,
                                      activeColor:
                                          AppTheme.currentThemeOf(context)
                                              .colorScheme
                                              .primary,
                                      fillColor: WidgetStatePropertyAll(
                                          AppTheme.currentThemeOf(context)
                                              .colorScheme
                                              .primary),
                                      value: isSelected,
                                      onChanged: (v) {
                                        isSelected
                                            ? selectedItems.remove(value)
                                            : selectedItems.add(value);
                                        _controllerNotifier.value =
                                            selectedItems.isNotEmpty
                                                ? selectedItems.last
                                                : '';
                                        _selectedItem = selectedItems.join(',');
                                        menuSetState(() {});
                                      },
                                    ),
                                    kLarge.h,
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                );
              }).toList(),
              decoration: DefaultDecoration.of(context).copyWith(
                labelText: widget.label,
                contentPadding: _controllerNotifier.value.isEmpty
                    ? kMedium.all
                    : kMedium.vertical,
                labelStyle: AppTheme.currentThemeOf(context).bodyText1,
              ),
              isExpanded: true,
            ),
          ),
        ),
      ],
    );
  }

  void onFieldUpdated(String? value) {
    _controllerNotifier.value = value ?? '';
    widget.onChanged?.call(value);
  }
}
