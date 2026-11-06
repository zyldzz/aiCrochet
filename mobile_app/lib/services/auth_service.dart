Future<String?> login(String email, String password) async {
  await Future.delayed(const Duration(milliseconds: 600));
  if (password == "hatali") return "Eposta veya şifre hatalı";
  return null;
}

Future<String?> register(String name, String email, String password) async {
  await Future.delayed(const Duration(milliseconds: 600));
  if (email == 'a@a.com') return 'Bu e-posta zaten kayıtlı.';
  return null;
}
