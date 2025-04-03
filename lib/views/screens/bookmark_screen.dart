import 'package:bhagavad_gita/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/gita_provider.dart';
import '../../controllers/theme_provider.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Scaffold(
        appBar: AppBar(
          backgroundColor:
              themeProvider.isDark ? Colors.black : Colors.brown.shade700,
          foregroundColor: Colors.white,
          title: const Text('Bookmark Verse'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          actions: [
            IconButton(
              onPressed: () {
                themeProvider.setDarkTheme(!themeProvider.isDark);
              },
              icon: Icon(themeProvider.isDark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: Consumer<GitaProvider>(
          builder: (context, gp, child) => GitaProvider.verseBookMark.isEmpty
              ? SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'No one bookmark added...',
                      style: summaryTSB(
                          co: themeProvider.isDark
                              ? Colors.white70
                              : Colors.brown.shade800),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(16),
                        child: Text(
                          'Verses : ${GitaProvider.verseBookMark.length}',
                          style: summaryTSB(
                              co: themeProvider.isDark
                                  ? Colors.white70
                                  : Colors.brown.shade800),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                      ...GitaProvider.verseBookMark.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 16, bottom: 16, right: 16),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              GitaProvider.selVerse = int.parse(e);
                              Navigator.of(context).pushNamed('verse_details');
                            },
                            child: Ink(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: themeProvider.isDark
                                        ? Colors.black.withOpacity(0.1)
                                        : Colors.brown.withOpacity(0.1),
                                  ),
                                  color: themeProvider.isDark
                                      ? Colors.black.withOpacity(0.3)
                                      : Colors.brown.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: themeProvider.isDark
                                          ? const AssetImage(
                                              'assets/images/tilebkg-dark.png')
                                          : const AssetImage(
                                              'assets/images/tilebkg.png'),
                                      opacity: 0.8)),
                              child: ListTile(
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Text(
                                        GitaProvider.verseList[int.parse(e) - 1]
                                            ['text'],
                                        style: titleTSB(
                                            fs: 17,
                                            co: themeProvider.isDark
                                                ? Colors.black87
                                                : Colors.brown.shade800),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        icon: const Icon(
                                            Icons.bookmark_remove_outlined),
                                        onPressed: () {
                                          gp.removeBookMark(int.parse(e));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 14,
                                      child: Text(
                                        GitaProvider.vTranslationList[
                                            int.parse(e) - 1]['description'],
                                        style: titleTSB(
                                            fs: 17,
                                            co: themeProvider.isDark
                                                ? Colors.black54
                                                : Colors.brown.shade600),
                                      ),
                                    ),
                                    const Expanded(
                                        flex: 1,
                                        child:
                                            Icon(Icons.arrow_right_outlined)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
