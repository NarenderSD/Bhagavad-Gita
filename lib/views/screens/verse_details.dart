import 'package:bhagavad_gita/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/gita_provider.dart';
import '../../controllers/theme_provider.dart';

class VerseDetails extends StatelessWidget {
  const VerseDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selChapter = GitaProvider.selChapter + 1;

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Scaffold(
        appBar: AppBar(
          backgroundColor:
              themeProvider.isDark ? Colors.black : Colors.brown.shade700,
          foregroundColor: Colors.white,
          title: Text(
              '$selChapter  ${GitaProvider.chaptersList[selChapter - 1]['name']}'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          actions: [
            Consumer<GitaProvider>(
              builder: (context, gp, child) => IconButton(
                onPressed: () {
                  GitaProvider.verseBookMark
                          .contains(GitaProvider.selVerse.toString())
                      ? gp.removeBookMark(GitaProvider.selVerse)
                      : gp.addBookMark(GitaProvider.selVerse);
                },
                icon: Icon(GitaProvider.verseBookMark
                        .contains(GitaProvider.selVerse.toString())
                    ? Icons.bookmark_remove
                    : Icons.bookmark_add),
              ),
            ),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                child: Text(
                  'Verse : ${GitaProvider.verseList[GitaProvider.selVerse - 1]['chapter_number']}.${GitaProvider.verseList[GitaProvider.selVerse - 1]['verse_number']} (${GitaProvider.selVerse})',
                  style: summaryTSB(
                      co: themeProvider.isDark
                          ? Colors.white70
                          : Colors.brown.shade800),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {},
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
                                : const AssetImage('assets/images/tilebkg.png'),
                            opacity: 0.8)),
                    child: ListTile(
                      title: Text(
                        GitaProvider.verseList[GitaProvider.selVerse - 1]
                            ['text'],
                        style: titleTSB(
                            fs: 17,
                            co: themeProvider.isDark
                                ? Colors.black87
                                : Colors.brown.shade800),
                      ),
                      subtitle: Text(
                        GitaProvider.vTranslationList[
                            GitaProvider.verseList[GitaProvider.selVerse - 1]
                                    ['verse_order'] -
                                1]['description'],
                        style: titleTSB(
                            fs: 17,
                            co: themeProvider.isDark
                                ? Colors.black54
                                : Colors.brown.shade600),
                      ),
                      trailing: const Icon(Icons.arrow_right_outlined),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '    ${GitaProvider.commentaryList[GitaProvider.selVerse - 1]['description']}',
                  style: summaryTSB(
                      co: themeProvider.isDark
                          ? Colors.white60
                          : Colors.brown.shade800),
                  textAlign: TextAlign.justify,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
