import json

keys_en = {
  'signingIn': 'Signing in...',
  'loginSuccessful': 'Login Successful',
  'beginYourJourney': 'Begin Your Journey',
  'emailIsRequired': 'Email is required',
  'pleaseEnterValidEmail': 'Please enter a valid email',
  'passwordIsRequired': 'Password is required',
  'pleaseWait': 'Please wait',
  'signIn': 'Sign In',
  'signUp': 'Sign Up',
  'dontHaveAnAccount': 'Don\'t have an account?',
  'registerNow': 'Register now',
  'askMeAboutTourism': 'Ask me about Tourism',
  'typeYourMessage': 'Type your message',
  'editProfile': 'Edit Profile',
  'bookService': 'Book Service',
  'resetAll': 'Reset All',
  'failedToLoadReviews': 'Failed to load reviews',
  'anErrorOccurred': 'An error occurred',
  'noResultsFound': 'No results found',
  'tryAdjustingYourFilters': 'Try adjusting your filters'
}

keys_ar = {
  'signingIn': 'جاري تسجيل الدخول...',
  'loginSuccessful': 'تم تسجيل الدخول بنجاح',
  'beginYourJourney': 'ابدأ رحلتك',
  'emailIsRequired': 'البريد الإلكتروني مطلوب',
  'pleaseEnterValidEmail': 'يرجى إدخال بريد إلكتروني صحيح',
  'passwordIsRequired': 'كلمة المرور مطلوبة',
  'pleaseWait': 'يرجى الانتظار',
  'signIn': 'تسجيل الدخول',
  'signUp': 'إنشاء حساب',
  'dontHaveAnAccount': 'ليس لديك حساب؟',
  'registerNow': 'سجل الآن',
  'askMeAboutTourism': 'اسألني عن السياحة',
  'typeYourMessage': 'اكتب رسالتك',
  'editProfile': 'تعديل الملف الشخصي',
  'bookService': 'حجز خدمة',
  'resetAll': 'إعادة ضبط الكل',
  'failedToLoadReviews': 'فشل في تحميل التقييمات',
  'anErrorOccurred': 'حدث خطأ',
  'noResultsFound': 'لم يتم العثور على نتائج',
  'tryAdjustingYourFilters': 'حاول تعديل الفلاتر'
}

keys_fr = {
  'signingIn': 'Connexion en cours...',
  'loginSuccessful': 'Connexion réussie',
  'beginYourJourney': 'Commencez votre voyage',
  'emailIsRequired': 'L\'e-mail est requis',
  'pleaseEnterValidEmail': 'Veuillez entrer un e-mail valide',
  'passwordIsRequired': 'Le mot de passe est requis',
  'pleaseWait': 'Veuillez patienter',
  'signIn': 'Se connecter',
  'signUp': 'S\'inscrire',
  'dontHaveAnAccount': 'Vous n\'avez pas de compte ?',
  'registerNow': 'S\'inscrire maintenant',
  'askMeAboutTourism': 'Demandez-moi sur le tourisme',
  'typeYourMessage': 'Tapez votre message',
  'editProfile': 'Modifier le profil',
  'bookService': 'Réserver un service',
  'resetAll': 'Tout réinitialiser',
  'failedToLoadReviews': 'Échec du chargement des avis',
  'anErrorOccurred': 'Une erreur s\'est produite',
  'noResultsFound': 'Aucun résultat trouvé',
  'tryAdjustingYourFilters': 'Essayez d\'ajuster vos filtres'
}

for lang, new_keys in [('en', keys_en), ('ar', keys_ar), ('fr', keys_fr)]:
    filepath = f'd:/flutter/projects/tourismapp/lib/l10n/intl_{lang}.arb'
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except Exception:
        data = {}
    
    data.update(new_keys)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
