# تشغيل وفحص مشروع Flutter

# تنظيف المشروع
Write-Output "تنظيف المشروع..."
flutter clean

# جلب الحزم
Write-Output "جلب الحزم..."
flutter pub get

# تحليل الكود
Write-Output "تحليل الكود..."
flutter analyze

# تشغيل المشروع على كروم
Write-Output "تشغيل المشروع على كروم..."
flutter run -d chrome

# تشغيل المشروع على جهاز أندرويد (إذا متصل)
Write-Output "تشغيل المشروع على جهاز أندرويد..."
flutter devices
flutter run -d android

# بناء APK
Write-Output "بناء نسخة APK..."
flutter build apk --release

# بناء AAB
Write-Output "بناء نسخة AAB..."
flutter build appbundle --release

Write-Output "✅ تم تشغيل وفحص المشروع بنجاح"
