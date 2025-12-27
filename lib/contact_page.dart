import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final String _supportEmail = "destek@fluxyai.com";

  // Form verilerini alıp Mail Uygulamasını açar
  Future<void> _sendEmail() async {
    final String name = _nameController.text;
    final String message = _messageController.text;

    if (name.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lütfen isim ve mesaj alanlarını doldurun."),
        ),
      );
      return;
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: _supportEmail,
      query: 'subject=Fluxy AI İletişim Formu: $name&body=$message',
    );

    if (!await launchUrl(emailLaunchUri)) {
      debugPrint('Mail uygulaması açılamadı.');
    }
  }

  Future<void> _launchLink(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      debugPrint('Link açılamadı: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Image.asset('assets/logo.png', height: 28), // Logon varsa
            const SizedBox(width: 10),
            const Text(
              "İletişim",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Arka Plan Efekti
          Positioned.fill(
            child: Opacity(
              opacity: 0.03,
              child: Image.network(
                "https://t3.ftcdn.net/jpg/03/53/83/92/360_F_353839266_8yihGle8jV21x4f2Q4f2Q4f2Q4f2Q4f2.jpg",
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: isMobile
                    ? Column(children: _buildContent(true))
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildContent(false),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildContent(bool isMobile) {
    return [
      // SOL TARAF: İLETİŞİM BİLGİLERİ
      Expanded(
        flex: isMobile ? 0 : 4,
        child: FadeInLeft(
          duration: const Duration(milliseconds: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bize Ulaşın",
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Sorularınız mı var?\nBizimle konuşun.",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Fluxy AI hakkında önerilerinizi, iş birliği tekliflerinizi veya yaşadığınız sorunları duymaktan memnuniyet duyarız.",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),

              _contactInfoCard(
                Icons.email,
                "E-posta",
                _supportEmail,
                () => _sendEmail(),
              ),
              _contactInfoCard(
                FontAwesomeIcons.instagram,
                "Instagram",
                "@fluxyai_app",
                () => _launchLink("https://instagram.com"),
              ),
              _contactInfoCard(
                FontAwesomeIcons.twitter,
                "Twitter / X",
                "@fluxyai",
                () => _launchLink("https://twitter.com"),
              ),
            ],
          ),
        ),
      ),

      if (!isMobile) const SizedBox(width: 80),
      if (isMobile) const SizedBox(height: 50),

      // SAĞ TARAF: FORM
      Expanded(
        flex: isMobile ? 0 : 5,
        child: FadeInRight(
          duration: const Duration(milliseconds: 800),
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color(0xFF121212),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Mesaj Gönder",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                _buildTextField(
                  "Adınız Soyadınız",
                  Icons.person,
                  _nameController,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  "E-posta Adresiniz",
                  Icons.email,
                  _emailController,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  "Mesajınız",
                  Icons.message,
                  _messageController,
                  maxLines: 5,
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _sendEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "GÖNDER",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.grey[600], size: 20),
              prefixIconConstraints: const BoxConstraints(minWidth: 50),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _contactInfoCard(
    IconData icon,
    String title,
    String value,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.amber, size: 20),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[700], size: 14),
          ],
        ),
      ),
    );
  }
}
