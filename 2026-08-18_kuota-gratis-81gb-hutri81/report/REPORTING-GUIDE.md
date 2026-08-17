# 📮 Panduan Pelaporan (Takedown)

Cara mengirim laporan kasus ini. Ada 2 jenis kanal: **FORM WEB** (cepat, cukup tempel teks) dan
**EMAIL abuse** (untuk penyedia hosting/registrar). Draft email siap-kirim ada di
[`../analysis/abuse-reports/`](../analysis/abuse-reports/). Lampiran yang dianjurkan di setiap
laporan: **`DIGITAL-TRACES-DOSSIER.pdf`** (folder ini) + `screenshots/01_landing_merdeka_81gb.png` +
`../IOC.txt`.

---

## ✅ PRIORITAS 1 — Cepat & berdampak (form web, tanpa email, ±15 menit)

| # | Kanal | Cara | Isi |
|---|---|---|---|
| 1 | **Kemenkomdigi — Aduan Konten** | Buka **https://aduankonten.id/** → kategori **Penipuan** | Tempel isi `../analysis/abuse-reports/kominfo-bssn_ID.txt`; lampirkan PDF + screenshot |
| 2 | **Cloudflare Abuse** | **https://abuse.cloudflare.com/** → **Phishing** | Tempel `../analysis/abuse-reports/cloudflare.txt` (daftar domain + link urlscan) |
| 3 | **Google Safe Browsing** | **https://safebrowsing.google.com/safebrowsing/report_phish/** | Masukkan `https://kuota-gratis-81gb98.1grd.xyz/?hut-ri-81=98` (agar diblokir di Chrome/Android) |
| 4 | **WhatsApp** | Di chat pesan itu → **Laporkan** | Report in-app + kabari pengirim (dia korban) |

> **Kanal #1 (aduankonten.id) paling penting** untuk konteks Indonesia — ini jalur resmi pemerintah.

---

## ✉️ PRIORITAS 2 — Email abuse (takedown server & domain)

Kirim dari email pribadimu (Gmail/Outlook dll). **Subjek & isi** sudah ada di file draft; **lampirkan**
PDF + screenshot. Boo­leh dikirim satu per satu.

| Kirim ke | Untuk | Draft |
|---|---|---|
| **abuse@hetzner.com** | Origin asli #2 (95.217.42.163) + 6 domain srvmedia | `hetzner.txt` |
| **abuse@inap.com** (cc noc@inap.com) | Origin asli #1 (108.178.23.116) | `inap.txt` |
| **abuse@namecheap.com** | srvmediahost / sramms / obqj3 / sssifmobisignal | `namecheap.txt` |
| **abuse@west.cn** | Domain 1grd.xyz | `registrars.txt` |
| **abuse@diymysite.com** | Domain gf920.com, 626cdn.com | `registrars.txt` |
| **AWS** (form) | https://support.aws.amazon.com/#/contacts/report-abuse | `aws.txt` |

---

## 🏛️ PRIORITAS 3 — Otoritas Indonesia (opsional, dampak nasional)

| Kanal | Cara |
|---|---|
| **BSSN / CSIRT** | Email **pengaduan@bssn.go.id** & **cert@bssn.go.id** — subjek di `kominfo-bssn_ID.txt`, lampirkan PDF |
| **Lapor.go.id** | https://www.lapor.go.id/ (kanal pengaduan pemerintah) |
| **Operator seluler** | Lapor ke CS Telkomsel/Indosat/XL/Tri/Smartfren (scam mengklaim "semua operator") |

---

## 📋 Checklist status

```
[ ] aduankonten.id (Kominfo)          dikirim: ____  tiket: ______
[ ] Cloudflare abuse (Phishing)       dikirim: ____  ref:   ______
[ ] Google Safe Browsing              dikirim: ____
[ ] WhatsApp report                   dikirim: ____
[ ] Email Hetzner (95.217.42.163)     dikirim: ____
[ ] Email INAP (108.178.23.116)       dikirim: ____
[ ] Email Namecheap                   dikirim: ____
[ ] Email west.cn / diymysite.com     dikirim: ____
[ ] AWS abuse (mms.sramms.space)      dikirim: ____
[ ] BSSN / CSIRT                       dikirim: ____
```

## Tips
- Sertakan **link hasil urlscan** (di `../REFERENCES.md`) — bukti render independen mempercepat verifikasi.
- Tidak perlu identitas untuk kebanyakan abuse desk; boleh anonim.
- Simpan nomor tiket/balasan di checklist untuk tindak lanjut.
- Surat pengantar singkat siap-pakai: [`../analysis/abuse-reports/COVER-LETTER.txt`](../analysis/abuse-reports/COVER-LETTER.txt).
