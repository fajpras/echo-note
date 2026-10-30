import 'package:flutter/material.dart';
import '../models/note_item.dart';
import '../theme/app_theme.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedCategory = 'KULIAH';

  final List<String> _categories = [
    'KULIAH',
    'TUGAS',
    'IDE',
    'PRIBADI'
  ];

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.pureBlack,
          content: const Text(
            'Judul dan isi catatan tidak boleh kosong',
            style: TextStyle(
              color: AppColors.neonLime,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          shape: Border.all(color: AppColors.neonLime, width: 2),
        ),
      );
      return;
    }

    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    final now = DateTime.now();
    final dateStr = '${now.day} ${months[now.month - 1]} ${now.year}';

    final newNote = NoteItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      category: _selectedCategory,
      date: dateStr,
      content: content,
      isPinned: false,
    );

    Navigator.of(context).pop(newNote);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.creamBg,
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
            width: 2,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'TULIS CATATAN BARU',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                _titleController.clear();
                _contentController.clear();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.pureWhite,
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
                    width: 1.5,
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.restart_alt, size: 14),
                    SizedBox(width: 4),
                    Text(
                      'RESET',
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          Text(
            'KATEGORI CATATAN',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
              color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.neonLime
                            : (isDark ? AppColors.darkCard : AppColors.pureWhite),
                        border: Border.all(
                          color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
                          width: 2,
                        ),
                        boxShadow: isSelected
                            ? const [
                                BoxShadow(
                                  color: AppColors.pureBlack,
                                  offset: Offset(2, 2),
                                )
                              ]
                            : null,
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.pureBlack
                              : (isDark ? AppColors.pureWhite : AppColors.pureBlack),
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : AppColors.pureWhite,
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black54 : AppColors.pureBlack,
                  offset: const Offset(4, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'JUDUL CATATAN',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkBg : AppColors.creamBg,
                    border: Border.all(
                      color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
                      width: 2,
                    ),
                  ),
                  child: TextField(
                    controller: _titleController,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Tulis judul catatan...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'ISI CATATAN',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkBg : AppColors.creamBg,
                    border: Border.all(
                      color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
                      width: 2,
                    ),
                  ),
                  child: TextField(
                    controller: _contentController,
                    maxLines: 9,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.45,
                      color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Ketik isi catatanmu di sini...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _saveNote,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.electricBlue,
                      border: Border.all(color: AppColors.pureBlack, width: 2),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.pureBlack,
                          offset: Offset(3, 3),
                        )
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SIMPAN CATATAN',
                          style: TextStyle(
                            color: AppColors.pureWhite,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.check, size: 18, color: AppColors.pureWhite),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
