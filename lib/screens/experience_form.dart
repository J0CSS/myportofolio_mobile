import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPage();
}

class _ExperienceFormPage extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _description = "";
  String _category = "full-time";
  String _thumbnail = "";
  String _startedAt = "";
  String _endedAt = "";

  final Map<String, String> _categories = {
    'internship': 'Internship',
    'research': 'Research',
    'volunteer': 'Volunteer',
    'part-time': 'Part-Time',
    'full-time': 'Full-Time',
    'freelance': 'Freelance',
  };

  String? _validateThumbnail(String? value) {
    final url = value?.trim() ?? "";
    if (url.isEmpty) return null;

    final uri = Uri.tryParse(url);
    if (uri == null ||
        !uri.hasAuthority ||
        (uri.scheme != "http" && uri.scheme != "https")) {
      return "Masukkan URL thumbnail yang valid (http/https).";
    }
    return null;
  }

  DateTime? _parseDate(String? value) {
    final date = value?.trim() ?? "";
    if (date.isEmpty) return null;

    final match = RegExp(r"^(\d{4})-(\d{2})-(\d{2})$").firstMatch(date);
    if (match == null) return null;

    final year = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    final day = int.parse(match.group(3)!);
    final parsed = DateTime(year, month, day);
    if (parsed.year != year || parsed.month != month || parsed.day != day) {
      return null;
    }
    return parsed;
  }

  String? _validateStartedAt(String? value) {
    final date = value?.trim() ?? "";
    if (date.isEmpty) return null; // The model supplies a default date.
    if (_parseDate(date) == null) {
      return "Gunakan format tanggal YYYY-MM-DD yang valid.";
    }
    return null;
  }

  String? _validateEndedAt(String? value) {
    final date = value?.trim() ?? "";
    if (date.isEmpty) return null; // Empty means the experience is ongoing.

    final endDate = _parseDate(date);
    if (endDate == null) {
      return "Gunakan format tanggal YYYY-MM-DD yang valid.";
    }

    final start = _startedAt.trim();
    if (start.isNotEmpty) {
      final startDate = _parseDate(start);
      if (startDate != null && endDate.isBefore(startDate)) {
        return "Tanggal berakhir tidak boleh sebelum tanggal dimulai.";
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Experience Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Experience title ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Asisten Dosen",
                    labelText: "Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Pengalaman tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Experience description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Ceritakan Pengalamanmu",
                    labelText: "Deskripsi Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi pengalaman tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Experience category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _category,
                  items: _categories.entries
                      .map(
                        (category) => DropdownMenuItem(
                          value: category.key,
                          child: Text(category.value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue ?? _category;
                    });
                  },
                ),
              ),

              // === Thumbnail URL ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "https://drive.google.com/thumbnail?id=...",
                    labelText: "URL Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value ?? "";
                    });
                  },
                  validator: _validateThumbnail,
                ),
              ),

              // === Start date ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "YYYY-MM-DD",
                    labelText: "Tanggal Pengalaman Dimulai",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _startedAt = value ?? "";
                    });
                  },
                  validator: _validateStartedAt,
                ),
              ),

              // === End date ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "YYYY-MM-DD (kosongkan jika masih berlangsung)",
                    labelText: "Tanggal Pengalaman Berakhir",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _endedAt = value ?? "";
                    });
                  },
                  validator: _validateEndedAt,
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Pengalaman berhasil ditambahkan!',
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Pengalaman: $_title'),
                                    Text('Deskripsi: $_description'),
                                    Text('Kategori: ${_categories[_category]}'),
                                    Text('URL Thumbnail: $_thumbnail'),
                                    Text('Tanggal Dimulai: $_startedAt'),
                                    Text('Tanggal Berakhir: $_endedAt'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
