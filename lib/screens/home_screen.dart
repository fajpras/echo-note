import 'package:flutter/material.dart';
import '../models/note_item.dart';
import '../theme/app_theme.dart';
import 'add_note_screen.dart';
import 'note_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const HomeScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'SEMUA';

  final List<String> _categories = [
    'SEMUA',
    'KULIAH',
    'TUGAS',
    'IDE',
    'PRIBADI'
  ];

  final List<NoteItem> _notes = [
    NoteItem(
      id: '1',
      title: 'Jadwal Kuliah PPB & Praktikum',
      category: 'KULIAH',
      date: '30 Okt 2026',
      content:
          'Setiap hari Jumat jam 08.00 WIB ruang Lab 3. Materi seputar widget lifecycle, state management, dan navigasi modular Flutter.',
      isPinned: true,
    ),
    NoteItem(
      id: '2',
      title: 'Tugas Akhir Semester Aplikasi Mobile',
      category: 'TUGAS',
      date: '28 Okt 2026',
      content:
          'Desain antarmuka dengan tema kontras tinggi. Fitur CRUD lokal menggunakan model terpisah dan tata letak responsif.',
      isPinned: true,
    ),
    NoteItem(
      id: '3',
      title: 'Ide Fitur Pengingat Deadline',
      category: 'IDE',
      date: '25 Okt 2026',
      content:
          'Tambahkan notifikasi lokal saat batas pengumpulan tugas tinggal 2 jam lagi agar tidak terlewat.',
      isPinned: false,
    ),
    NoteItem(
      id: '4',
      title: 'Catatan Belanja Bulanan Kos',
      category: 'PRIBADI',
      date: '20 Okt 2026',
      content:
          'Beli air galon, detergen, kertas HVS A4, dan snack untuk lembur coding.',
      isPinned: false,
    ),
  ];

  List<NoteItem> get _filteredNotes {
    final query = _searchController.text.trim().toLowerCase();
    return _notes.where((note) {
      final matchesCategory = _selectedCategory == 'SEMUA' ||
          note.category.toUpperCase() == _selectedCategory.toUpperCase();
      final matchesQuery = query.isEmpty ||
          note.title.toLowerCase().contains(query) ||
          note.content.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList()
      ..sort((a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return 0;
      });
  }

  void _addNote(NoteItem note) {
    setState(() {
      _notes.insert(0, note);
    });
  }

  void _deleteNote(String id) {
    setState(() {
      _notes.removeWhere((item) => item.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Catatan berhasil dihapus'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _togglePin(NoteItem note) {
    setState(() {
      note.isPinned = !note.isPinned;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentList = _filteredNotes;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.creamBg,
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
            width: 2,
          ),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.neonLime,
                border: Border.all(color: AppColors.pureBlack, width: 2),
              ),
              child: const Icon(
                Icons.edit_note,
                color: AppColors.pureBlack,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'ECONOTES',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
            ),
            onPressed: widget.onToggleTheme,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : AppColors.pureWhite,
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
                  width: 2,
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkBg : AppColors.creamBg,
                    border: Border.all(
                      color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
                      width: 2,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    style: TextStyle(
                      color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Cari catatan...',
                      hintStyle: TextStyle(
                        color: isDark ? AppColors.mutedGrey : AppColors.pureBlack.withValues(alpha: 0.5),
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon: const Icon(Icons.search, color: AppColors.pureBlack, size: 20),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18, color: AppColors.pureBlack),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
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
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.neonLime
                                  : (isDark ? AppColors.darkBg : AppColors.creamBg),
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${currentList.length} CATATAN',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                  ),
                ),
                if (_selectedCategory != 'SEMUA')
                  GestureDetector(
                    onTap: () => setState(() => _selectedCategory = 'SEMUA'),
                    child: const Text(
                      'TAMPILKAN SEMUA',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: AppColors.electricBlue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: currentList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_alt_outlined,
                          size: 56,
                          color: isDark ? AppColors.mutedGrey : AppColors.pureBlack.withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Belum ada catatan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tekan tombol + di bawah untuk membuat catatan',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.mutedGrey : AppColors.pureBlack.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
                    itemCount: currentList.length,
                    itemBuilder: (context, index) {
                      final note = currentList[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkCard : AppColors.pureWhite,
                          border: Border.all(
                            color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isDark ? Colors.black54 : AppColors.pureBlack,
                              offset: const Offset(3, 3),
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: () async {
                            final deletedId = await Navigator.of(context).push<String>(
                              MaterialPageRoute(
                                builder: (context) => NoteDetailScreen(
                                  note: note,
                                  onDelete: () => _deleteNote(note.id),
                                  onUpdate: () => setState(() {}),
                                ),
                              ),
                            );
                            if (deletedId != null) {
                              _deleteNote(deletedId);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: AppColors.neonLime,
                                        border: Border.all(color: AppColors.pureBlack, width: 1.5),
                                      ),
                                      child: Text(
                                        note.category,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.pureBlack,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          note.date,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: isDark ? AppColors.mutedGrey : AppColors.pureBlack.withValues(alpha: 0.6),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        GestureDetector(
                                          onTap: () => _togglePin(note),
                                          child: Icon(
                                            note.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                                            size: 16,
                                            color: note.isPinned ? AppColors.electricBlue : AppColors.pureBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  note.title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  note.content,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                    color: isDark ? AppColors.pureWhite.withValues(alpha: 0.8) : AppColors.pureBlack.withValues(alpha: 0.75),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          final newNote = await Navigator.of(context).push<NoteItem>(
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
          if (newNote != null) {
            _addNote(newNote);
          }
        },
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.neonLime,
            border: Border.all(color: AppColors.pureBlack, width: 2),
            boxShadow: const [
              BoxShadow(
                color: AppColors.pureBlack,
                offset: Offset(4, 4),
              )
            ],
          ),
          child: const Center(
            child: Icon(Icons.add, size: 30, color: AppColors.pureBlack),
          ),
        ),
      ),
    );
  }
}
