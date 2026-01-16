import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/response_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jiji AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4B9C9C)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        fontFamily: 'Roboto', 
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  bool _showResponse = false;
  String _responseText = '';
  final String _defaultInput = "Explain RAG";

  // Data for Rag as given in sample image
  final String _ragExplanation = 
      "Retrieval-Augmented Generation (RAG) combines search with large language models to improve the accuracy of generated answers by providing relevant information from external data sources.\n\n"
      "• Retrieves data from external sources\n"
      "• Uses a language model to generate answers using this data\n"
      "• Enhances the accuracy of responses";

  void _handleSearch() {
    if (_searchController.text.isNotEmpty) {
      setState(() {
        _showResponse = true;
        _responseText = _searchController.text;
      });
    }
  }

  Future<void> _launchYouTube(String query) async {
    final Uri url = Uri.parse('https://www.youtube.com/results?search_query=${Uri.encodeComponent(query)}');
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
       debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              const Text(
                'Jiji',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900, 
                  color: Colors.black87,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your AI Friend',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w400,
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Avatar Image
              Container(
                width: 200, 
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  
                  gradient: LinearGradient(
                    colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ClipOval(
                  child: Icon(
                    Icons.face_3, 
                    size: 160,
                    color: Colors.teal[700],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey[400], size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: _defaultInput, 
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => _handleSearch(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send_rounded),
                      color: const Color(0xFF4B9C9C),
                      onPressed: _handleSearch,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

             
              if (_showResponse)
                ResponseCard(
                  title: 'Jiji says',
                  content: _responseText.toLowerCase().contains('rag') 
                      ? _ragExplanation 
                      : "Here is what I found about \"$_responseText\".\n\n"
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.\n\n"
                        "• Lorem ipsum dolor sit amet\n"
                        "• Consectetur adipiscing elit\n"
                        "• Sed do eiusmod tempor incididunt",
                  attachments: [
                    // Dynamic YouTube Card
                    AttachmentCard(
                      title: 'What is "$_responseText"?',
                      subtitle: 'YouTube Video',
                      icon: Icons.play_circle_fill,
                      iconColor: const Color(0xFFEF5350), 
                      buttonText: 'Watch',
                      onTap: () => _launchYouTube(_responseText),
                    ),
                   
                    if (_responseText.toLowerCase().contains('rag'))
                      AttachmentCard(
                        title: 'Presentation on RAG',
                        subtitle: 'PowerPoint Presentation',
                        icon: Icons.pie_chart, 
                        iconColor: const Color(0xFFE57373),
                        buttonText: 'Open',
                         onTap: () {},
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
