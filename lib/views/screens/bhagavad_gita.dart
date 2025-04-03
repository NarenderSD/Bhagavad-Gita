import 'package:bhagavad_gita/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/gita_provider.dart';
import '../../controllers/theme_provider.dart';

class BhagavadGita extends StatefulWidget {
  const BhagavadGita({Key? key}) : super(key: key);

  @override
  State<BhagavadGita> createState() => _BhagavadGitaState();
}

class _BhagavadGitaState extends State<BhagavadGita> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GitaProvider>(
      builder: (context, gp, child) => Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => Scaffold(
          body: GitaProvider.chaptersList.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: true,
                      snap: false,
                      floating: false,
                      expandedHeight: 120,
                      collapsedHeight: 60,
                      backgroundColor: themeProvider.isDark
                          ? Colors.black
                          : Colors.brown.shade700,
                      foregroundColor: Colors.white,
                      flexibleSpace: FlexibleSpaceBar(
                        expandedTitleScale: 1,
                        title: const Text('Bhagavad Gita'),
                        background: Image.asset(
                          "assets/images/appbar.png",
                          opacity: const AlwaysStoppedAnimation(.6),
                          fit: BoxFit.cover,
                        ),
                      ),
                      leading: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('bookmark_screen');
                        },
                        icon: const Icon(Icons.bookmark),
                      ),
                      actions: [
                        Consumer<ThemeProvider>(
                          builder: (context, themeProvider, child) =>
                              IconButton(
                                  onPressed: () {
                                    themeProvider
                                        .setDarkTheme(!themeProvider.isDark);
                                  },
                                  icon: Icon(themeProvider.isDark
                                      ? Icons.light_mode_rounded
                                      : Icons.dark_mode_rounded)),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(0.5),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                GitaProvider.selChapter = index;
                                Navigator.of(context)
                                    .pushNamed('chapter_screen');
                              },
                              child: Ink(
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
                                                'assets/images/tilebkg.png'))),
                                child: ListTile(
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color: themeProvider.isDark
                                              ? Colors.black.withOpacity(0.1)
                                              : Colors.brown.withOpacity(0.1),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/chapter/${index + 1}.png'))),
                                  ),
                                  title: Row(
                                    children: [
                                      SizedBox(
                                        width: 35,
                                        child: Text(
                                          '${index + 1}',
                                          style: titleTSB(
                                              co: themeProvider.isDark
                                                  ? Colors.black87
                                                  : Colors.brown.shade800),
                                        ),
                                      ),
                                      Text(
                                        GitaProvider.chaptersList[index]
                                            ['name'],
                                        style: titleTSB(
                                            co: themeProvider.isDark
                                                ? Colors.black87
                                                : Colors.brown.shade800),
                                      ),
                                    ],
                                  ),
                                  trailing:
                                      const Icon(Icons.arrow_right_outlined),
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: 18,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
