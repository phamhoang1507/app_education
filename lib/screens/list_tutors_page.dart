import 'package:education_app/extensions/l10n.dart';
import 'package:education_app/routers/navigation_manager.dart';
import 'package:education_app/utilities/common_variables.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ListTutorsPage extends StatelessWidget {
  final List<dynamic> items;
  const ListTutorsPage({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
        title: Text(l10n.filteredResults),
      ),
      body: Padding(
        padding: commonPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.allTutors,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            Expanded(
              child: items.isEmpty
                  ? Center(
                      child: Text(
                        l10n.noTutorsFound,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    )
                  : ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final data = items[index];

                        return InkWell(
                          onTap: () {
                            print(1);
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 65,
                                  height: 65,
                                  child: ClipOval(
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      alignment: Alignment.topCenter,
                                      child: Image.asset(data.image),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        data.specialization,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: HexColor('FB923C'),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 14,
                                              color: HexColor('FB923C'),
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              '${data.rating.toString()} (${data.reviewCount.toString()})',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: HexColor('FB923C'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.pricePerHour(
                                        data.price.toStringAsFixed(0),
                                      ),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: HexColor('#9547ED'),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '\$${data.price.toStringAsFixed(0)}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
