@echo off
cls

echo =========================================
echo   TARIHLI YEDEKLEME VE GIT OTOMASYONU
echo =========================================

:: 1. Tarihi al (YYYY_MM_DD)
for /f %%a in ('powershell -NoProfile -Command "Get-Date -Format 'yyyy_MM_dd'"') do set TARIH=%%a
set "HEDEF_KLASOR=yedek_%TARIH%"

echo [*] Hedef Klasor: %HEDEF_KLASOR%
echo.

:: 2. Klasor yoksa olustur
if not exist "%HEDEF_KLASOR%" (
    echo [+] Klasor olusturuluyor...
    mkdir "%HEDEF_KLASOR%"
)

:: 3. Dosyayi kopyala
echo [+] Dosya kopyalaniyor...
copy yedekler\arsiv.txt "%HEDEF_KLASOR%\" >nul

echo.
echo =========================================
echo         GIT SENKRONIZASYONU
echo =========================================

:: 4. Git adimlari
echo [+] Degisiklikler hazirlik alanina ekleniyor (git add)...
git add .

echo [+] Paket olusturuluyor (git commit)...
git commit -m "Otomatik yedekleme: %TARIH%"

echo [+] Uzak depoya gonderiliyor (git push)...
git push origin main

echo.
echo =========================================
echo       TUM ISLEMLER TAMAMLANDI!
echo =========================================
pause