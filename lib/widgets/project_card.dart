import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ProjectItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ProjectItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // Menggunakan warna dari backgroundColor item.
      color: item.backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // Aksi ketika kartu ditekan oleh pengguna.
        onTap: () async {
          if (item.name == "Lihat Proyek") {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const ProjectListScreen(),
              ),
            );
          } else if (item.name == "Tambah Proyek") {
            final allowed = await ensureLoggedIn(context);
            if (!context.mounted || !allowed) return;
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const ProjectFormPage(),
              ),
            );
          } else if (item.name == "Login") {
            final loggedIn = await Navigator.push<bool>(
              context,
              MaterialPageRoute<bool>(
                builder: (_) => const LoginScreen(),
              ),
            );
            if (context.mounted && loggedIn == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged in.')),
              );
            }
          } else if (item.name == "Logout") {
            final messenger = ScaffoldMessenger.of(context);
            try {
              await context.read<AuthState>().logout();
              messenger.showSnackBar(
                const SnackBar(content: Text('Logged out.')),
              );
            } on ApiException catch (error) {
              messenger.showSnackBar(
                SnackBar(
                  content: Text(
                    'Logged out locally; server returned HTTP ${error.statusCode}.',
                  ),
                ),
              );
            } catch (_) {
              messenger.showSnackBar(
                const SnackBar(
                  content: Text('Logged out locally; server sign-out failed.'),
                ),
              );
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
