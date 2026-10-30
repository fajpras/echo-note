import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/note_item.dart';
import '../theme/app_theme.dart';

class NoteDetailScreen extends StatefulWidget {
  final NoteItem note;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const NoteDetailScreen({
    super.key,
    required this.note,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul dan isi tidak boleh kosong')),
      );
      return;
    }

    setState(() {
      widget.note.title = title;
      widget.note.content = content;
      _isEditing = false;
    });
    widget.onUpdate();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Catatan berhasil diperbarui'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkCard
            : AppColors.pureWhite,
        shape: Border.all(color: AppColors.pureBlack, width: 2),
        title: const Text(
          'HAPUS CATATAN?',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        content: const Text(
          'Catatan ini akan dihapus secara permanen.',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('BATAL', style: TextStyle(color: AppColors.pureBlack)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.pureBlack, width: 1.5),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              widget.onDelete();
              Navigator.of(context).pop();
            },
            child: const Text('HAPUS', style: TextStyle(fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(
      text: '${widget.note.title}\n\n${widget.note.content}',
    ));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Teks catatan disalin ke clipboard!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
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
        title: Text(
          _isEditing ? 'EDIT CATATAN' : 'BACA CATATAN',
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit_outlined),
            onPressed: () {
              if (_isEditing) {
                _saveChanges();
              } else {
                setState(() => _isEditing = true);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.copy_outlined),
            onPressed: _copyToClipboard,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: _confirmDelete,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.neonLime,
                  border: Border.all(color: AppColors.pureBlack, width: 2),
                ),
                child: Text(
                  widget.note.category,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: AppColors.pureBlack,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.pureWhite,
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  widget.note.date,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                  ),
                ),
              ),
            ],
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
                if (_isEditing) ...[
                  Text(
                    'JUDUL',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkBg : AppColors.creamBg,
                      border: Border.all(
                        color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: _titleController,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                      ),
                      decoration: const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'ISI CATATAN',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkBg : AppColors.creamBg,
                      border: Border.all(
                        color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: TextField(
                      controller: _contentController,
                      maxLines: 12,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                      ),
                      decoration: const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _saveChanges,
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.electricBlue,
                        border: Border.all(color: AppColors.pureBlack, width: 2),
                      ),
                      child: const Center(
                        child: Text(
                          'SIMPAN PERUBAHAN',
                          style: TextStyle(
                            color: AppColors.pureWhite,
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Text(
                    widget.note.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      height: 1.2,
                      color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Divider(
                    color: isDark ? AppColors.darkBorder : AppColors.pureBlack.withValues(alpha: 0.15),
                    thickness: 1.5,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.note.content,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.pureWhite.withValues(alpha: 0.9) : AppColors.pureBlack.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : AppColors.pureWhite,
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.note.content.split(' ').where((w) => w.isNotEmpty).length} KATA',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: isDark ? AppColors.mutedGrey : AppColors.pureBlack.withValues(alpha: 0.6),
                  ),
                ),
                Text(
                  '${widget.note.content.length} KARAKTER',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: isDark ? AppColors.mutedGrey : AppColors.pureBlack.withValues(alpha: 0.6),
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
