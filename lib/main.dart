import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FormBuilder Demo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.supportedLocales,
      theme: ThemeData(useMaterial3: true),
      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CodePage(
      title: 'Flutter Form Builder',
      child: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Complete Form'),
            trailing: const Icon(Icons.arrow_right_sharp),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const CodePage(
                      title: 'Complete Form',
                      child: CompleteForm(),
                    );
                  },
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Custom Fields'),
            trailing: const Icon(Icons.arrow_right_sharp),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const CodePage(
                      title: 'Custom Fields',
                      child: CustomFields(),
                    );
                  },
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Signup Form'),
            trailing: const Icon(Icons.arrow_right_sharp),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const CodePage(
                      title: 'Signup Form',
                      child: SignupForm(),
                    );
                  },
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Dynamic Form'),
            trailing: const Icon(Icons.arrow_right_sharp),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const CodePage(
                      title: 'Dynamic Form',
                      child: DynamicFields(),
                    );
                  },
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Conditional Form'),
            trailing: const Icon(Icons.arrow_right_sharp),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const CodePage(
                      title: 'Conditional Form',
                      child: ConditionalFields(),
                    );
                  },
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Related Fields'),
            trailing: const Icon(Icons.arrow_right_sharp),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const CodePage(
                      title: 'Related Fields',
                      child: RelatedFields(),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// code_page.dart

class CodePage extends StatelessWidget {
  final String title;
  final Widget child;

  const CodePage({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: child,
      ),
    );
  }
}

// sources\complete_form.dart

class CompleteForm extends StatefulWidget {
  const CompleteForm({Key? key}) : super(key: key);

  @override
  State<CompleteForm> createState() {
    return _CompleteFormState();
  }
}

class _CompleteFormState extends State<CompleteForm> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _ageHasError = false;
  bool _genderHasError = false;

  var genderOptions = ['Male', 'Female', 'Other'];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FormBuilder(
            key: _formKey,
            // enabled: false,
            onChanged: () {
              _formKey.currentState!.save();
              debugPrint(_formKey.currentState!.value.toString());
            },
            autovalidateMode: AutovalidateMode.disabled,
            initialValue: const {
              'movie_rating': 5,
              'best_language': 'Dart',
              'age': '13',
              'gender': 'Male',
              'languages_filter': ['Dart']
            },
            skipDisabled: true,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 15),
                FormBuilderDateTimePicker(
                  name: 'date',
                  initialEntryMode: DatePickerEntryMode.calendar,
                  initialValue: DateTime.now(),
                  inputType: InputType.both,
                  decoration: InputDecoration(
                    labelText: 'Appointment Time',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['date']?.didChange(null);
                      },
                    ),
                  ),
                  initialTime: const TimeOfDay(hour: 8, minute: 0),
                  // locale: const Locale.fromSubtags(languageCode: 'fr'),
                ),
                FormBuilderDateRangePicker(
                  name: 'date_range',
                  firstDate: DateTime(1970),
                  lastDate: DateTime(2030),
                  format: DateFormat('yyyy-MM-dd'),
                  onChanged: _onChanged,
                  decoration: InputDecoration(
                    labelText: 'Date Range',
                    helperText: 'Helper text',
                    hintText: 'Hint text',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['date_range']
                            ?.didChange(null);
                      },
                    ),
                  ),
                ),
                FormBuilderSlider(
                  name: 'slider',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.min(6),
                  ]),
                  onChanged: _onChanged,
                  min: 0.0,
                  max: 10.0,
                  initialValue: 7.0,
                  divisions: 20,
                  activeColor: Colors.red,
                  inactiveColor: Colors.pink[100],
                  decoration: const InputDecoration(
                    labelText: 'Number of things',
                  ),
                ),
                FormBuilderRangeSlider(
                  name: 'range_slider',
                  onChanged: _onChanged,
                  min: 0.0,
                  max: 100.0,
                  initialValue: const RangeValues(4, 7),
                  divisions: 20,
                  maxValueWidget: (max) => TextButton(
                    onPressed: () {
                      _formKey.currentState?.patchValue(
                        {'range_slider': const RangeValues(4, 100)},
                      );
                    },
                    child: Text(max),
                  ),
                  activeColor: Colors.red,
                  inactiveColor: Colors.pink[100],
                  decoration: const InputDecoration(labelText: 'Price Range'),
                ),
                FormBuilderCheckbox(
                  name: 'accept_terms',
                  initialValue: false,
                  onChanged: _onChanged,
                  title: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'I have read and agree to the ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: TextStyle(color: Colors.blue),
                          // Flutter doesn't allow a button inside a button
                          // https://github.com/flutter/flutter/issues/31437#issuecomment-492411086
                          /*
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('launch url');
                            },
                          */
                        ),
                      ],
                    ),
                  ),
                  validator: FormBuilderValidators.equal(
                    true,
                    errorText:
                        'You must accept terms and conditions to continue',
                  ),
                ),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.always,
                  name: 'age',
                  decoration: InputDecoration(
                    labelText: 'Age',
                    suffixIcon: _ageHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _ageHasError =
                          !(_formKey.currentState?.fields['age']?.validate() ??
                              false);
                    });
                  },
                  // valueTransformer: (text) => num.tryParse(text),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.max(70),
                  ]),
                  // initialValue: '12',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                FormBuilderDropdown<String>(
                  name: 'gender',
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    suffix: _genderHasError
                        ? const Icon(Icons.error)
                        : const Icon(Icons.check),
                    hintText: 'Select Gender',
                  ),
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                  items: genderOptions
                      .map((gender) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _genderHasError = !(_formKey
                              .currentState?.fields['gender']
                              ?.validate() ??
                          false);
                    });
                  },
                  valueTransformer: (val) => val?.toString(),
                ),
                FormBuilderRadioGroup<String>(
                  decoration: const InputDecoration(
                    labelText: 'My chosen language',
                  ),
                  initialValue: null,
                  name: 'best_language',
                  onChanged: _onChanged,
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                  options: ['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                      .map((lang) => FormBuilderFieldOption(
                            value: lang,
                            child: Text(lang),
                          ))
                      .toList(growable: false),
                  controlAffinity: ControlAffinity.trailing,
                ),
                FormBuilderSwitch(
                  title: const Text('I Accept the terms and conditions'),
                  name: 'accept_terms_switch',
                  initialValue: true,
                  onChanged: _onChanged,
                ),
                FormBuilderCheckboxGroup<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: 'The language of my people'),
                  name: 'languages',
                  // initialValue: const ['Dart'],
                  options: const [
                    FormBuilderFieldOption(value: 'Dart'),
                    FormBuilderFieldOption(value: 'Kotlin'),
                    FormBuilderFieldOption(value: 'Java'),
                    FormBuilderFieldOption(value: 'Swift'),
                    FormBuilderFieldOption(value: 'Objective-C'),
                  ],
                  onChanged: _onChanged,
                  separator: const VerticalDivider(
                    width: 10,
                    thickness: 5,
                    color: Colors.red,
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.minLength(1),
                    FormBuilderValidators.maxLength(3),
                  ]),
                ),
                FormBuilderFilterChip<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: 'The language of my people'),
                  name: 'languages_filter',
                  selectedColor: Colors.red,
                  options: const [
                    FormBuilderChipOption(
                      value: 'Dart',
                      avatar: CircleAvatar(child: Text('D')),
                    ),
                    FormBuilderChipOption(
                      value: 'Kotlin',
                      avatar: CircleAvatar(child: Text('K')),
                    ),
                    FormBuilderChipOption(
                      value: 'Java',
                      avatar: CircleAvatar(child: Text('J')),
                    ),
                    FormBuilderChipOption(
                      value: 'Swift',
                      avatar: CircleAvatar(child: Text('S')),
                    ),
                    FormBuilderChipOption(
                      value: 'Objective-C',
                      avatar: CircleAvatar(child: Text('O')),
                    ),
                  ],
                  onChanged: _onChanged,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.minLength(1),
                    FormBuilderValidators.maxLength(3),
                  ]),
                ),
                FormBuilderChoiceChip<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText:
                          'Ok, if I had to choose one language, it would be:'),
                  name: 'languages_choice',
                  initialValue: 'Dart',
                  options: const [
                    FormBuilderChipOption(
                      value: 'Dart',
                      avatar: CircleAvatar(child: Text('D')),
                    ),
                    FormBuilderChipOption(
                      value: 'Kotlin',
                      avatar: CircleAvatar(child: Text('K')),
                    ),
                    FormBuilderChipOption(
                      value: 'Java',
                      avatar: CircleAvatar(child: Text('J')),
                    ),
                    FormBuilderChipOption(
                      value: 'Swift',
                      avatar: CircleAvatar(child: Text('S')),
                    ),
                    FormBuilderChipOption(
                      value: 'Objective-C',
                      avatar: CircleAvatar(child: Text('O')),
                    ),
                  ],
                  onChanged: _onChanged,
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      debugPrint(_formKey.currentState?.value.toString());
                    } else {
                      debugPrint(_formKey.currentState?.value.toString());
                      debugPrint('validation failed');
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                  },
                  // color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    'Reset',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// sources\conditional_fields.dart

class ConditionalFields extends StatefulWidget {
  const ConditionalFields({Key? key}) : super(key: key);

  @override
  State<ConditionalFields> createState() => _ConditionalFieldsState();
}

class _ConditionalFieldsState extends State<ConditionalFields> {
  final _formKey = GlobalKey<FormBuilderState>();
  int? option;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          FormBuilderDropdown<int>(
            name: 'options',
            validator: FormBuilderValidators.required(),
            decoration: const InputDecoration(
              label: Text('Select the option'),
            ),
            onChanged: (value) {
              setState(() {
                option = value;
              });
            },
            items: const [
              DropdownMenuItem(value: 0, child: Text('Show textfield')),
              DropdownMenuItem(value: 1, child: Text('Show info text')),
            ],
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: option == 0,
            // Can use to recreate completely the field
            // maintainState: false,
            child: FormBuilderTextField(
              name: 'textfield',
              validator: FormBuilderValidators.minLength(4),
              decoration: const InputDecoration(
                label: Text('Magic field'),
              ),
            ),
          ),
          Visibility(
            visible: option == 1,
            child: const Text('Magic info'),
          ),
          const SizedBox(height: 10),
          MaterialButton(
            color: Theme.of(context).colorScheme.secondary,
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _formKey.currentState!.saveAndValidate();
              debugPrint(_formKey.currentState?.instantValue.toString() ?? '');
            },
          ),
        ],
      ),
    );
  }
}

// sources\custom_fields.dart

class CustomFields extends StatefulWidget {
  const CustomFields({Key? key}) : super(key: key);

  @override
  State<CustomFields> createState() => _CustomFieldsState();
}

class _CustomFieldsState extends State<CustomFields> {
  final _formKey = GlobalKey<FormBuilderState>();

  static const List<String> _kOptions = <String>[
    'pikachu',
    'bulbasaur',
    'charmander',
    'squirtle',
    'caterpie',
  ];

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          FormBuilderField<DateTime?>(
            name: 'date',
            builder: (FormFieldState field) {
              return InputDatePickerFormField(
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
                onDateSubmitted: (value) => field.didChange(value),
                errorInvalidText: field.errorText,
                onDateSaved: (value) => field.didChange(value),
              );
            },
          ),
          const SizedBox(height: 10),
          FormBuilderField<bool>(
            name: 'terms',
            builder: (FormFieldState field) {
              return CheckboxListTile(
                title: const Text('I Accept the terms and conditions'),
                value: field.value ?? false,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) => field.didChange(value),
              );
            },
          ),
          const SizedBox(height: 10),
          FormBuilderField<String?>(
            name: 'name',
            builder: (FormFieldState field) {
              return Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  return _kOptions.where((String option) {
                    return option.contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  field.didChange(selection);
                },
              );
            },
            autovalidateMode: AutovalidateMode.always,
            validator: (valueCandidate) {
              if (valueCandidate?.isEmpty ?? true) {
                return 'This field is required.';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      debugPrint(_formKey.currentState!.value.toString());
                    } else {
                      debugPrint("validation failed");
                    }
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  child: const Text(
                    "Reset",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _formKey.currentState!.reset();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// sources\dynamic_fields.dart

class DynamicFields extends StatefulWidget {
  const DynamicFields({Key? key}) : super(key: key);

  @override
  State<DynamicFields> createState() => _DynamicFieldsState();
}

class _DynamicFieldsState extends State<DynamicFields> {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<Widget> fields = [];
  String savedValue = '';

  @override
  void initState() {
    savedValue = _formKey.currentState?.value.toString() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      // IMPORTANT to remove all references from dynamic field when delete
      clearValueOnUnregister: true,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            FormBuilderTextField(
              name: 'name',
              validator: FormBuilderValidators.required(),
              decoration: const InputDecoration(
                label: Text('Started field'),
              ),
            ),
            ...fields,
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _formKey.currentState!.saveAndValidate();
                      setState(() {
                        savedValue =
                            _formKey.currentState?.value.toString() ?? '';
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    child: const Text(
                      "Add field",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        fields.add(NewTextField(
                          name: 'name_${fields.length}',
                          onDelete: () {
                            setState(() {
                              fields.removeAt(fields.length - 1);
                            });
                          },
                        ));
                      });
                    },
                  ),
                ),
              ],
            ),
            const Divider(height: 40),
            Text('Saved value: $savedValue'),
          ],
        ),
      ),
    );
  }
}

class NewTextField extends StatelessWidget {
  const NewTextField({
    super.key,
    required this.name,
    this.onDelete,
  });
  final String name;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: FormBuilderTextField(
              name: name,
              validator: FormBuilderValidators.minLength(4),
              // decoration: const InputDecoration(
              //   label: Text('New field'),
              // ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

// sources\related_fields.dart

class RelatedFields extends StatefulWidget {
  const RelatedFields({Key? key}) : super(key: key);

  @override
  State<RelatedFields> createState() => _RelatedFieldsState();
}

class _RelatedFieldsState extends State<RelatedFields> {
  final _formKey = GlobalKey<FormBuilderState>();
  String country = '';
  String city = '';
  List<String> cities = [];

  @override
  void initState() {
    country = _allCountries.first;
    city = _allUsaCities.first;
    cities = _allUsaCities;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          FormBuilderDropdown<String>(
            name: 'country',
            decoration: const InputDecoration(
              label: Text('Countries'),
            ),
            initialValue: country,
            onChanged: (value) {
              setState(() {
                country = value ?? '';
                city = '';
                changeCities();
              });
            },
            items: _allCountries
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          FormBuilderDropdown<String>(
            name: 'city',
            decoration: const InputDecoration(
              label: Text('Cities'),
            ),
            initialValue: city,
            items: cities
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          MaterialButton(
            color: Theme.of(context).colorScheme.secondary,
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _formKey.currentState!.saveAndValidate();
              debugPrint(_formKey.currentState?.instantValue.toString() ?? '');
            },
          ),
        ],
      ),
    );
  }

  void changeCities() {
    switch (country) {
      case 'France':
        cities = _allFranceCities;
        break;
      case 'United States':
        cities = _allUsaCities;
        break;
      default:
        cities = [];
    }
  }
}

const _allCountries = [
  'United States',
  'France',
];

const _allUsaCities = [
  'California',
  'Another city',
];

const _allFranceCities = [
  'Paris',
  'Another city',
];

// sources\signup_form.dart

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'full_name',
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              key: _emailFieldKey,
              name: 'email',
              decoration: const InputDecoration(labelText: 'Email'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: 'password',
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(6),
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: 'confirm_password',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                suffixIcon: (_formKey.currentState?.fields['confirm_password']
                            ?.hasError ??
                        false)
                    ? const Icon(Icons.error, color: Colors.red)
                    : const Icon(Icons.check, color: Colors.green),
              ),
              obscureText: true,
              validator: (value) =>
                  _formKey.currentState?.fields['password']?.value != value
                      ? 'No coinciden'
                      : null,
            ),
            const SizedBox(height: 10),
            FormBuilderFieldDecoration<bool>(
              name: 'test',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.equal(true),
              ]),
              // initialValue: true,
              decoration: const InputDecoration(labelText: 'Accept Terms?'),
              builder: (FormFieldState<bool?> field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    errorText: field.errorText,
                  ),
                  child: SwitchListTile(
                    title: const Text(
                        'I have read and accept the terms of service.'),
                    onChanged: field.didChange,
                    value: field.value ?? false,
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            MaterialButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  if (true) {
                    // Either invalidate using Form Key
                    _formKey.currentState?.fields['email']
                        ?.invalidate('Email already taken.');
                    // OR invalidate using Field Key
                    // _emailFieldKey.currentState?.invalidate('Email already taken.');
                  }
                }
                debugPrint(_formKey.currentState?.value.toString());
              },
              child:
                  const Text('Signup', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
