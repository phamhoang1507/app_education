import 'package:education_app/model/subject.dart';
import 'package:education_app/repositories/subject_repository.dart';
import 'package:education_app/utilities/all_card.dart';
import 'package:education_app/utilities/common_variables.dart';
import 'package:education_app/widgets/form_search.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubjectPage extends StatelessWidget {
  const SubjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectRepo = SubjectRepository();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_sharp,
            color: Colors.black,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Live Tutoring',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: commonPaddingAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormSearch(),
                  const SizedBox(height: 16),
                  const Text(
                    'All Live Subject Tutoring',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: FutureBuilder<List<Subject>>(
                future: subjectRepo.getSubject(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Lỗi: ${snapshot.error}'));
                  }
                  final List<Subject> subjects = snapshot.data ?? [];
                  if (subjects.isEmpty) {
                    return const Center(child: Text('Không có dữ liệu'));
                  }

                  return SingleChildScrollView(
                    child: Wrap(
                      spacing: 25,
                      runSpacing: 10,
                      alignment: WrapAlignment.start,
                      children: subjects
                          .map((subject) => buildSubjectCard(subject))
                          .toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
