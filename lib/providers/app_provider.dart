import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../models/chat.dart';
import '../models/interest.dart';

/// App State Provider
/// Manages global app state including navigation, users, chats, and interests
class AppProvider with ChangeNotifier {
  // Navigation state
  int _currentTabIndex = 0;
  String? _selectedUserId;
  String? _selectedChatUserId;

  // User data
  final List<UserProfile> _users = [];
  final List<ChatConversation> _conversations = [];
  final List<Interest> _availableInterests = [];
  final List<String> _selectedInterests = [];

  // Auth state
  bool _isAuthenticated = false;
  bool _hasCompletedOnboarding = false;
  bool _hasSelectedInterests = false;

  // Getters
  int get currentTabIndex => _currentTabIndex;
  String? get selectedUserId => _selectedUserId;
  String? get selectedChatUserId => _selectedChatUserId;
  List<UserProfile> get users => _users;
  List<ChatConversation> get conversations => _conversations;
  List<Interest> get availableInterests => _availableInterests;
  List<String> get selectedInterests => _selectedInterests;
  bool get isAuthenticated => _isAuthenticated;
  bool get hasCompletedOnboarding => _hasCompletedOnboarding;
  bool get hasSelectedInterests => _hasSelectedInterests;

  // Navigation methods
  void setTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }

  void selectUser(String userId) {
    _selectedUserId = userId;
    notifyListeners();
  }

  void selectChatUser(String userId) {
    _selectedChatUserId = userId;
    notifyListeners();
  }

  void clearSelectedUser() {
    _selectedUserId = null;
    notifyListeners();
  }

  void clearSelectedChatUser() {
    _selectedChatUserId = null;
    notifyListeners();
  }

  // Auth methods
  void setAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  void setOnboardingCompleted(bool value) {
    _hasCompletedOnboarding = value;
    notifyListeners();
  }

  void setInterestsSelected(bool value) {
    _hasSelectedInterests = value;
    notifyListeners();
  }

  // Interest methods
  void toggleInterest(String interestId) {
    if (_selectedInterests.contains(interestId)) {
      _selectedInterests.remove(interestId);
    } else {
      _selectedInterests.add(interestId);
    }
    notifyListeners();
  }

  void setAvailableInterests(List<Interest> interests) {
    _availableInterests.clear();
    _availableInterests.addAll(interests);
    notifyListeners();
  }

  // User methods
  void setUsers(List<UserProfile> users) {
    _users.clear();
    _users.addAll(users);
    notifyListeners();
  }

  void removeUser(String userId) {
    _users.removeWhere((user) => user.id == userId);
    notifyListeners();
  }

  UserProfile? getUserById(String userId) {
    try {
      return _users.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }

  // Chat methods
  void setConversations(List<ChatConversation> conversations) {
    _conversations.clear();
    _conversations.addAll(conversations);
    notifyListeners();
  }

  void addMessage(String userId, ChatMessage message) {
    final conversationIndex = _conversations.indexWhere(
      (c) => c.userId == userId,
    );
    if (conversationIndex != -1) {
      _conversations[conversationIndex].messages.add(message);
      notifyListeners();
    }
  }

  ChatConversation? getConversationByUserId(String userId) {
    try {
      return _conversations.firstWhere((c) => c.userId == userId);
    } catch (e) {
      return null;
    }
  }

  void markConversationAsRead(String userId) {
    final conversationIndex = _conversations.indexWhere(
      (c) => c.userId == userId,
    );
    if (conversationIndex != -1) {
      final conversation = _conversations[conversationIndex];
      _conversations[conversationIndex] = ChatConversation(
        userId: conversation.userId,
        name: conversation.name,
        avatar: conversation.avatar,
        lastMessage: conversation.lastMessage,
        timestamp: conversation.timestamp,
        unread: 0,
        online: conversation.online,
        messages: conversation.messages,
      );
      notifyListeners();
    }
  }
}
