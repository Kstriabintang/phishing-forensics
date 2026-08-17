#!/usr/bin/env bash
# safe_fetch_apk.sh — unduh sampel APK/berkas ke KARANTINA dengan aman (tanpa eksekusi).
# Aman di Linux: APK = ZIP mati, tak ada runtime Android. JANGAN PERNAH install ke HP/emulator.
# Usage: ./safe_fetch_apk.sh <url> [nama_output]
set -euo pipefail

URL="${1:?Usage: safe_fetch_apk.sh <url> [nama]}"
NAME="${2:-sample_$(printf '%s' "$URL" | tr -c 'A-Za-z0-9' '_' | cut -c1-40)}"
QDIR="$(cd "$(dirname "$0")/../../_QUARANTINE_DO_NOT_EXECUTE" && pwd)"
UA="Mozilla/5.0 (Linux; Android 13; SM-G991B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Mobile Safari/537.36"
OUT="$QDIR/${NAME}.apk.quarantine"   # ekstensi .quarantine agar tak salah-klik-jalan

echo "[*] Karantina : $QDIR"
echo "[*] Unduh     : $URL"
# unduh; -f gagal pada 4xx/5xx; batasi ukuran 200MB; UA mobile ID
curl -fL --max-time 120 --max-filesize 209715200 \
     -A "$UA" -H "Accept-Language: id-ID,id;q=0.9" \
     -o "$OUT" "$URL"

chmod 644 "$OUT"          # pastikan TIDAK executable
SIZE=$(wc -c < "$OUT")
MAGIC=$(xxd -p -l 4 "$OUT" 2>/dev/null || od -An -tx1 -N4 "$OUT" | tr -d ' ')
SHA=$(sha256sum "$OUT" | cut -d' ' -f1)
MD5=$(md5sum "$OUT" | cut -d' ' -f1)

echo "[*] Tersimpan : $OUT ($SIZE bytes)"
echo "[*] Magic     : $MAGIC  (APK/ZIP valid = 504b0304)"
echo "[*] SHA256    : $SHA"
echo "[*] MD5       : $MD5"
case "$MAGIC" in
  504b0304|504b0506|504b0708) echo "[+] Terlihat ZIP/APK valid. Bedah STATIS: tools/dissect_apk_static.sh \"$OUT\"";;
  *) echo "[!] BUKAN ZIP/APK — mungkin HTML/redirect/decoy. Periksa: file \"$OUT\"; head -c 300 \"$OUT\"";;
esac
echo "[!] JANGAN install ke Android. Analisis STATIS saja."
# catat ke ledger sampel
printf '%s\t%s\t%s\t%s\t%s\n' "$(basename "$OUT")" "$SIZE" "$SHA" "$MD5" "$URL" >> "$QDIR/SAMPLES.tsv"
