import 'package:education_app/extensions/l10n.dart';
import 'package:education_app/model/subject.dart';
import 'package:education_app/repositories/course_repository.dart';
import 'package:education_app/repositories/instructor_repository.dart';
import 'package:education_app/repositories/subject_repository.dart';
import 'package:education_app/repositories/weekdays_repository.dart';
import 'package:education_app/routers/navigation_manager.dart';
import 'package:education_app/utilities/common_variables.dart';
import 'package:education_app/widgets/form_dropdown.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

enum FilterField { day, timeslot, duration, released }

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final double min = 0;
  final double max = 50;
  RangeValues range = RangeValues(12, 29);
  int selectedIndex = 0;
  final subjectRepo = SubjectRepository();
  final instructorRepo = InstructorRepository();
  final weekdaysRepo = WeekdaysRepository();
  final courseRepo = CourseRepository();
  List<Subject> subjects = [];
  List<dynamic> levels = [
    {'id': 1, 'en': 'Beginner', 'vi': 'Cơ bản'},
    {'id': 2, 'en': 'Advanced', 'vi': 'Trình độ cao'},
  ];
  List<dynamic> durations = [
    {'id': 1, 'en': '<1 hr', 'vi': '<1 giờ'},
    {'id': 2, 'en': '1-3 hr', 'vi': '1-3 giờ'},
    {'id': 3, 'en': '3-6 hr', 'vi': '3-6 giờ'},
    {'id': 4, 'en': '6+ hr', 'vi': '6+ giờ'},
  ];
  List<dynamic> releaseds = [
    {'id': 1, 'en': 'In last 3 Month', 'vi': 'Trong 3 tháng qua'},
    {'id': 2, 'en': 'In last 6 Month', 'vi': 'Trong 6 tháng qua'},
    {'id': 3, 'en': 'In last 1 Year', 'vi': 'Trong 1 năm qua'},
    {'id': 4, 'en': 'Over 1 Year', 'vi': 'Trên 1 năm'},
  ];
  List<dynamic> weekdays = [];
  List<dynamic> timeslotsList = [
    {'key': 'morning', 'en': 'Morning', 'vi': 'Buổi sáng'},
    {'key': 'afternoon', 'en': 'Afternoon', 'vi': 'Buổi chiều'},
    {'key': 'evening', 'en': 'Evening', 'vi': 'Buổi tối'},
  ];
  final List<Map<String, dynamic>> experienceList = [
    {'id': 1, 'en': '1 year', 'vi': '1 năm'},
    {'id': 2, 'en': '2 years', 'vi': '2 năm'},
    {'id': 3, 'en': '3 years', 'vi': '3 năm'},
    {'id': 4, 'en': '4 years', 'vi': '4 năm'},
    {'id': 5, 'en': '5+ years', 'vi': '5+ năm'},
  ];
  int? selectedSubjectId;
  int? selectedlevelId;
  int? selectedDurationId;
  int? selectedExperienceId;
  int? selectedReleasedId;
  Set<String> selectedDays = {};
  Set<String> timeslots = {};
  int rating = 0;
  final Map<FilterField, String?> errors = {
    FilterField.day: null,
    FilterField.timeslot: null,
  };

  @override
  void initState() {
    super.initState();
    fetchSubjects();
    fetchWeekdays();
  }

  Future<void> fetchWeekdays() async {
    final weekdaysList = await weekdaysRepo.loadWeekdays();
    setState(() {
      weekdays = weekdaysList;
    });
  }

  Future<void> fetchSubjects() async {
    final subjectsList = await subjectRepo.getSubject();
    setState(() {
      subjects = subjectsList;
    });
  }

  void onChangeSubject(int? value) {
    setState(() {
      selectedSubjectId = value;
    });
  }

  void onChangeExperience(int? value) {
    setState(() {
      selectedExperienceId = value;
    });
  }

  void onChangeLevel(int? value) {
    setState(() {
      selectedlevelId = value;
    });
  }

  void resetFilters() {
    setState(() {
      selectedSubjectId = null;
      selectedExperienceId = null;
      selectedlevelId = null;
      selectedDurationId = null;
      selectedReleasedId = null;
      selectedDays.clear();
      timeslots.clear();
      rating = 0;
      range = const RangeValues(12, 29);
    });
  }

  bool validate() {
    final l10n = context.l10n;
    errors.updateAll((key, value) => null);

    if (selectedIndex == 0) {
      if (selectedDays.isEmpty) {
        errors[FilterField.day] = l10n.errorSelectAtLeastOneDay;
      }
      if (timeslots.isEmpty) {
        errors[FilterField.timeslot] = l10n.errorSelectAtLeastOneTimeSlot;
      }
    }

    return errors.values.every((e) => e == null);
  }

  Future<void> applyFillter() async {
    setState(() {});
    if (!validate()) return;
    if (selectedIndex == 0) {
      final tutors = await instructorRepo.getInstructorsByKeys(
        selectedSubjectId,
        selectedDays.toList(),
        timeslots.toList(),
        selectedExperienceId,
        rating,
        range.start.toInt(),
        range.end.toInt(),
      );
      context.nav.tolistFilter(context, tutors, selectedIndex);
    } else {
      final courses = await courseRepo.getCoursesByKeys(
        selectedSubjectId,
        selectedlevelId,
        rating,
        range.start.toInt(),
        range.end.toInt(),
        selectedDurationId,
        selectedReleasedId,
      );
      context.nav.tolistFilter(context, courses, selectedIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leadingWidth: 40,
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_sharp),
          color: Colors.black,
          onPressed: () => context.nav.pop(context),
        ),
        title: Text(l10n.filters),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: commonMarkDownPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTypeFilterSession(context, width),
                      SizedBox(height: 20),
                      if (selectedIndex == 0) ...[
                        _buildFilterTutorsSession(context),
                      ],
                      if (selectedIndex == 1) ...[
                        _buildFilterCoursesSession(context),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: commonPaddingAll,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: resetFilters,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade500),
                        shadowColor: Colors.grey.shade300,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        l10n.resetFilters,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.03),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        applyFillter();
                      },
                      style: OutlinedButton.styleFrom(
                        shadowColor: HexColor('#9547ED'),
                        side: BorderSide(color: HexColor('#9547ED')),
                        backgroundColor: HexColor('#9547ED'),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        l10n.applyFilters,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _textWidth(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: const TextStyle(fontSize: 14)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.size.width;
  }

  Widget _buildTypeFilterSession(BuildContext context, double width) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.lookingFor,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildButton(
                text: l10n.tutors,
                isSelected: selectedIndex == 0,
                onTap: () {
                  if (selectedIndex != 0) {
                    resetFilters();
                    setState(() => selectedIndex = 0);
                  }
                },
              ),
            ),
            SizedBox(width: width * 0.03),
            Expanded(
              child: _buildButton(
                text: l10n.courses,
                isSelected: selectedIndex == 1,
                onTap: () {
                  if (selectedIndex != 1) {
                    resetFilters();
                    setState(() => selectedIndex = 1);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingSession(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.rating,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 1),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Wrap(
                runSpacing: 8,
                spacing: 8,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        rating = index + 1;
                      });
                    },
                    child: Icon(
                      index < rating
                          ? FluentIcons.star_24_filled
                          : FluentIcons.star_24_regular,
                      size: 28,
                      color: index < rating ? Colors.amber : Colors.grey,
                    ),
                  );
                }),
              ),
              Spacer(),
              Text(l10n.starsAndUp(rating)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSession(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final startX = ((range.start - min) / (max - min)) * width;
            final endX = ((range.end - min) / (max - min)) * width;

            final startText = '\$${range.start.toInt()}';
            final endText = '\$${range.end.toInt()}';

            final startTextWidth = _textWidth(startText);
            final endTextWidth = _textWidth(endText);

            return Stack(
              clipBehavior: Clip.none,
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    rangeThumbShape: BorderRangeThumbShape(
                      radius: 10,
                      borderWidth: 2,
                      fillColor: Colors.white,
                      borderColor: Colors.deepPurple,
                    ),
                    activeTrackColor: Colors.deepPurple,
                    inactiveTrackColor: Colors.grey.shade300,
                    overlayShape: SliderComponentShape.noOverlay,
                  ),
                  child: RangeSlider(
                    values: range,
                    min: min,
                    max: max,
                    onChanged: (values) {
                      setState(() {
                        range = values;
                      });
                    },
                  ),
                ),

                Positioned(
                  left: startX - startTextWidth / 2,
                  top: 40,
                  child: Text(
                    startText,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),

                Positioned(
                  left: endX - endTextWidth / 2,
                  top: 40,
                  child: Text(
                    endText,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildFilterTutorsSession(BuildContext context) {
    final l10n = context.l10n;
    final _locale = Localizations.localeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormDropdown<Subject>(
          title: l10n.subject,
          hintText: l10n.selectSubject,
          items: subjects,
          selectedId: selectedSubjectId,
          getId: (item) => item.id,
          getLabel: (item, locale) =>
              locale.languageCode == 'en' ? item.name : item.name,
          onChanged: (value) {
            setState(() => selectedSubjectId = value);
          },
        ),
        SizedBox(height: 20),
        Text(
          l10n.availability,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: weekdays.map((data) {
              final String key = data['key'];
              final bool isSelected = selectedDays.contains(key);
              return _buildButton(
                text: _locale == Locale('en') ? data['en'] : data['vi'],
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedDays.remove(key);
                    } else {
                      selectedDays.add(key);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ),
        _buildError(FilterField.day),
        SizedBox(height: 20),
        Text(
          l10n.timeslots,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: List.generate(timeslotsList.length, (index) {
            final data = timeslotsList[index];
            final String key = data['key'];
            final bool isSelected = timeslots.contains(key);

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == timeslotsList.length - 1 ? 0 : 8,
                ),
                child: _buildButton(
                  text: _locale == const Locale('en') ? data['en'] : data['vi'],
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        timeslots.remove(key);
                      } else {
                        timeslots.add(key);
                      }
                    });
                  },
                ),
              ),
            );
          }),
        ),
        _buildError(FilterField.timeslot),
        SizedBox(height: 20),
        FormDropdown<Map<String, dynamic>>(
          title: l10n.tutoringExperience,
          hintText: l10n.selectExperience,
          items: experienceList,
          selectedId: selectedExperienceId,
          getId: (item) => item['id'] as int,
          getLabel: (item, locale) =>
              locale.languageCode == 'en' ? item['en'] : item['vi'],
          onChanged: (value) {
            setState(() => selectedExperienceId = value);
          },
        ),
        //todo degrees
        // FormDropdown(title: 'Tutoring Experience', hintText: 'Select Experience', items: experienceList, selectedId: selectedExperienceId, onChanged: onChanged),
        SizedBox(height: 20),
        _buildRatingSession(context),
        SizedBox(height: 20),
        _buildPriceSession(context, l10n.hourlyRate),
        SizedBox(height: 50),
      ],
    );
  }

  Widget _buildFilterCoursesSession(BuildContext context) {
    final l10n = context.l10n;
    final _locale = Localizations.localeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormDropdown<Subject>(
          title: l10n.subject,
          hintText: l10n.selectSubject,
          items: subjects,
          selectedId: selectedSubjectId,
          getId: (item) => item.id,
          getLabel: (item, locale) =>
              locale.languageCode == 'en' ? item.name : item.name,
          onChanged: (value) {
            setState(() => selectedSubjectId = value);
          },
        ),
        SizedBox(height: 20),
        FormDropdown<dynamic>(
          title: 'Difficulty Level',
          hintText: 'Select Level',
          items: levels,
          selectedId: selectedlevelId,
          getId: (item) => item['id'],
          getLabel: (item, locale) =>
              locale.languageCode == 'en' ? item['en'] : item['vi'],
          onChanged: (value) {
            setState(() => selectedlevelId = value);
          },
        ),
        SizedBox(height: 20),
        _buildRatingSession(context),
        SizedBox(height: 20),
        _buildPriceSession(context, 'Price Range'),
        SizedBox(height: 50),
        Text(
          'Duration',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(durations.length, (index) {
            final data = durations[index];
            final int key = data['id'];
            final bool isSelected = selectedDurationId == key;

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == durations.length - 1 ? 0 : 8,
                ),
                child: _buildButton(
                  text: _locale == const Locale('en') ? data['en'] : data['vi'],
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      selectedDurationId = key;
                    });
                  },
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 20),
        FormDropdown(
          title: 'Released',
          hintText: 'Select Released',
          items: releaseds,
          selectedId: selectedReleasedId,
          getId: (item) => item['id'],
          getLabel: (item, locale) =>
              locale.languageCode == 'en' ? item['en'] : item['vi'],
          onChanged: (value) {
            setState(() => selectedReleasedId = value);
          },
        ),
        SizedBox(height: 5),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: commonPaddingAll,
        decoration: BoxDecoration(
          color: isSelected ? HexColor('#9547ED') : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: HexColor('#9547ED').withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
          border: Border.all(
            color: isSelected ? HexColor('#9547ED') : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildError(FilterField field) {
    final error = errors[field];
    if (error == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 13),
      ),
    );
  }
}

class BorderRangeThumbShape extends RangeSliderThumbShape {
  final double radius;
  final double borderWidth;
  final Color fillColor;
  final Color borderColor;

  BorderRangeThumbShape({
    this.radius = 10,
    this.borderWidth = 2,
    required this.fillColor,
    required this.borderColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(radius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool? isDiscrete,
    bool? isEnabled,
    bool? isOnTop,
    bool? isPressed,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
  }) {
    final Canvas canvas = context.canvas;

    // Fill
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    // Border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawCircle(center, radius, fillPaint);
    canvas.drawCircle(center, radius, borderPaint);
  }
}
