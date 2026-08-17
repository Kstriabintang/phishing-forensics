#!/usr/bin/env bash
# dissect_apk_static.sh — bedah APK 100% STATIS (tanpa menjalankan apa pun). Aman di Linux.
# Mencari: manifest, izin, endpoint HTTP, token Telegram/bot, C2, string mencurigakan.
# Usage: ./dissect_apk_static.sh <file.apk[.quarantine]>
set -uo pipefail
F="${1:?Usage: dissect_apk_static.sh <file.apk>}"
[ -f "$F" ] || { echo "file tak ada: $F"; exit 1; }
WORK="${F%.quarantine}.unpacked"; rm -rf "$WORK"; mkdir -p "$WORK"

echo "############ 1. Identitas berkas ############"
file "$F"; ls -la "$F"; sha256sum "$F"

echo; echo "############ 2. Isi arsip (unzip -l) ############"
unzip -l "$F" 2>/dev/null | head -40

echo; echo "############ 3. Ekstrak (statis) ############"
unzip -o -q "$F" -d "$WORK" 2>/dev/null && echo "-> $WORK"

echo; echo "############ 4. Manifest & izin ############"
if command -v aapt >/dev/null 2>&1; then
  aapt dump badging "$F" 2>/dev/null | grep -iE 'package|launchable-activity|uses-permission|application-label' | head -40
elif command -v apkanalyzer >/dev/null 2>&1; then
  apkanalyzer manifest print "$F" 2>/dev/null | head -60
else
  echo "(aapt/apkanalyzer tak ada — pasang: sudo pacman -S android-tools  ATAU  androguard)"
  echo "AndroidManifest.xml (biner) ada di: $WORK/AndroidManifest.xml (butuh decoder spt apktool)"
fi

echo; echo "############ 5. Endpoint HTTP/URL ############"
grep -raohE 'https?://[a-zA-Z0-9._~:/?#@!$&()*+,;=%-]+' "$WORK" 2>/dev/null | sort -u | head -60

echo; echo "############ 6. TOKEN TELEGRAM / BOT / CHAT_ID ############"
grep -raohE 'bot[0-9]{6,10}:[A-Za-z0-9_-]{30,40}|api\.telegram\.org/[^ "]+|chat_id=?[-0-9]+|sendMessage' "$WORK" 2>/dev/null | sort -u | head
echo "(kosong = tak ada token Telegram di string mentah; token bisa terenkripsi di DEX/native)"

echo; echo "############ 7. String mencurigakan lain ############"
grep -raohE '(firebase[a-z]*\.com|amazonaws\.com|\.php\?|/api/|SmsManager|READ_SMS|SEND_SMS|RECEIVE_SMS|getDeviceId|/gate|/panel|onhold|base64)' "$WORK" 2>/dev/null | sort -u | head -30

echo; echo "############ 8. DEX (butuh dekompilasi utk kode) ############"
ls -la "$WORK"/*.dex 2>/dev/null
echo "-> untuk kode: jadx-gui \"$F\"  atau  apktool d \"$F\"  (statis, aman)"
echo "[!] JANGAN pernah adb install / jalankan di emulator kecuali di sandbox terisolasi penuh."
