# Deep-Dive Ronde 2 — Lapisan yang Lebih Dalam

Menjawab: *"masih ada yang bisa dibedah lebih dalam? bisa dapat key dll?"* — Ya, ada beberapa lapis lagi. Hasilnya di bawah. **Tidak ada key/token bocor** (opsec operator solid), tetapi kita membuktikan **infrastruktur & produk baru** yang signifikan.

## 1. Analitik: self-hosted Plausible (bukti niat komersial + ID kampanye)
`tj.16gift.com/js/script.js` = skrip **Plausible Analytics** self-hosted (signature `currentScript`+`data-api`+`/api/event`+"Ignoring Event"). POST `tj.16gift.com/api/event` membawa:
```json
{"n":"pageview","u":"https://kuota-gratis-81gb98.1grd.xyz/?hut-ri-81=98","d":"id-data01","r":null}
```
- **`data-domain = id-data01`** = nama "site" internal operator untuk kampanye kuota (skema: `id`=Indonesia, `data`, `01` → ada id-data02, my-data01, dst).
- Dashboard **`plausible.16gift.com`** ADA tapi **tidak publik** (403 / "not found" untuk stats) → operator memantau performa, tapi statistik tidak bocor.

## 2. PRODUK KEDUA: Telegram Mini App "Quiz" (scam hadiah/referral)
`16gift.com/` (root) = **Telegram Mini App** — memuat `telegram.org/js/telegram-web-app.js`, membaca `Telegram.WebApp.initDataUnsafe.user` + `start_param`, lalu memanggil backend:
```
GET 16gift.com/njb/api.php?cmd=get_user_info&uid=<tgid>&psid=<ref>&first_name=...&lang=...
```
- **Backend nyata:** `njb/api.php` dengan skema perintah (`cmd=`) + kode status → `{"ok":false,"status":4002,"msg":"Parameters error"}` (butuh initData Telegram valid; ter-gate).
- **Sistem referral:** `psid` diambil dari `start_param` (16 char pertama) → skema rujukan/undang-teman.
- **Alur:** `start_param=wallet` → `payout.php`; `=test` → `intro.php`; selain itu → `index.php`. Adanya **`payout.php`** menandakan iming-iming "penarikan saldo" (pola scam earn-to-payout: tugas/undang-teman → saldo palsu → syarat penarikan).
- Telemetri kuis: `tj.657g.xyz/js/script.js` dengan **`data-domain = "bot.com"`** (nama site Plausible untuk produk kuis).

## 3. Domain/infra baru ronde ini
| Aset | Peran | Registrar | Dibuat | Host |
|---|---|---|---|---|
| `16gift.com` (root) | Telegram Mini App quiz + backend `njb/api.php` | Hefei Juming (CN) | 2023-12-30 | Cloudflare |
| `tj.16gift.com` | Plausible telemetry (kuota, site `id-data01`) | — | — | Cloudflare |
| `plausible.16gift.com` | Plausible dashboard (403, privat) | — | — | Cloudflare |
| `657g.xyz` / `tj.657g.xyz` | Plausible telemetry (kuis, site `bot.com`) | Dynadot | 2026-07-31 | Cloudflare |
| `zs.obqj3.com` | subdomain ad-network (crt.sh; tak merespons) | NameCheap | 2022-03-14 | — |

## 4. Uji "cari key" — hasil (opsec operator)
| Cek | Hasil |
|---|---|
| `/.git/config`, `/.git/HEAD` (INAP) | **403** (diblok) |
| `/.env`, `/.well-known/security.txt` (INAP) | **403** |
| `.env`/`.git`/`config.php`/`admin` (Hetzner) | **200 kosong** (catch-all cloaker, bukan file nyata); `/vendor/` 403 |
| `njb/api.php` | JSON ter-gate `status:4002` (tanpa initData valid) |
| `njb/`, `njb/cdn/` | **403** (listing diblok) |
| `njb/index.php/intro.php/payout.php` | **404** tanpa sesi Telegram valid |
| dashboard Plausible | **tidak publik** |
| token Telegram / API key di client | **tidak ada** |

➡️ **Tidak ada rahasia terekspos.** Operator menerapkan opsec konsisten (dotfile 403, listing 403, API ter-gate, secret server-side). Bot token Telegram ada **server-side** (untuk memvalidasi `initData` via HMAC) — tak pernah muncul di klien.

## 5. Kesimpulan ronde 2
- Operator ini **multi-produk & profesional**: (a) funnel CPA "kuota gratis" + (b) **scam hadiah/referral Telegram Mini App**, berbagi **infra analitik Plausible** & pola telemetri `tj.<domain>`.
- Skema penamaan kampanye internal terungkap: **`id-data01`** (kuota), **`bot.com`** (kuis) → memungkinkan pelacakan kampanye lain.
- **Atribusi Mandarin** menguat: registrar `16gift.com` = Hefei Juming (CN), pola `tj`=统计.
- **Tidak ada "kunci"** untuk diambil — bukan karena kurang gali, tapi karena **opsec mereka rapi**. Jalur realistis menembus lebih jauh = level hukum/penyedia (bukan teknis dari luar).

*Bukti: `evidence/telegram-quiz/` (16gift_quiz.html, main.js), respons api.php. Snapshot 2026-08-18.*
