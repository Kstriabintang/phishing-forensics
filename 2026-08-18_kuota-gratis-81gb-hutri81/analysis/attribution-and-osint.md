# Atribusi & OSINT — Lapisan Terdalam

Deep-dive ronde 3: OSINT pasif (Wayback, passive-DNS, media, feed) — **tanpa** serangan aktif. Menghasilkan bukti atribusi terkuat + korelasi eksternal.

## 1. LINEAGE — `gf920.com` = situs judi Tiongkok "和信娱乐城" (2018)

Wayback Machine (snapshot 2018-08-05) membuktikan `gf920.com` dulunya **portal login judi/lotre online Mandarin**:
- Judul: **和信娱乐城** (Héxìn Yúlèchéng / "Hexin Entertainment City"), grup **和信集团娱乐城**.
- Form login: `name="userName"` (账号/akun), `name="userPwd"` (密码/sandi), `name="loginVcode"` (captcha 看不清?点击更换), `name="loginHTML"`.
- Konten: **彩票投注** (taruhan lotre), 会员 (member), QQ, 微信 (WeChat).
- URL historis berbahasa Mandarin: `/账号` (account), `/密码` (password), `/验证码` (OTP).

**Arti:** cloaker backbone kampanye (`free.gf920.com`, 2026) **berakar dari infrastruktur judi online Tiongkok** (2018). Domain aged di-repurpose. Ini menempatkan operator di **ekosistem gambling/CPA-affiliate berbahasa Mandarin** — cocok dengan registrar Tiongkok (west.cn, Hefei Juming), telemetri `tj`=统计, dan pola cloaking→CPA. Bukti: `evidence/wayback/gf920.com_2018_hexin-gambling-login.html` · screenshot `screenshots/04_gf920_2018_hexin-gambling-login.png`.

**Identifier operator era-2018 (dari arsip publik):** halaman itu mencantumkan kontak agen/afiliasi:
- **QQ: `752562222`** (代理加盟QQ / agen-afiliasi)
- **WeChat: `widlc6588`** (微信)
- **Domain "mudah diingat": `hx1.vip`** (易记域名; "hx"=和信/Hexin)
- Menu lengkap situs judi: 彩票投注 (lotre), 真人视讯 (live casino), 电子游戏 (slot), 体育竞技 (sport), 存款取款 (depo/wd), 加盟合作 (afiliasi), 零审核极速提款 ("QUICK WITHDRAWAL").

> Catatan kehati-hatian: identifier ini milik **era judi 2018** domain tsb. Operator 2026 me-*repurpose* domain; identitas bisa sama atau berbeda. Dicatat sebagai **lead OSINT historis**, bukan atribusi final individu.

**Produk Telegram "Quiz" (screenshot `05`)** = scam **"Play & Win / Withdrawal"** (earn-to-payout): klaim "500K+ Withdrawal Amount", "Easy monthly income $300", bukti-bayar palsu **"@Putri123 was just paid 609.56 to their Venmo"** — memakai **pola nama palsu "Putri" yang sama** seperti scam kuota (`names` cookie) → memperkuat kaitan satu operator.

`16gift.com` (Wayback 2012): dulunya toko hadiah/bunga Tiongkok (`FlowerOnline`, ASP) → domain aged di-repurpose jadi telemetry+Telegram-quiz. Aged domain = reputasi lebih baik untuk lolos filter.

## 2. Cluster Hetzner diperluas + CROSS-LINK ke cluster sekunder

OTX passive-DNS `95.217.42.163` → ~16 domain "media/serv/track". Liveness (2026-08-18):
- **Hidup di 95.217.42.163 (Hetzner):** `baitechi.com`, `doubletrk.com`, `smartmediasrv.com`, `srvmediahost.com`, `srvmedianet.com`, `srvnewmedia.com` (6, HTTP 200).
- **`mediaservingcd.com` → `104.219.250.37`** = **cluster Namecheap Phoenix** (yang sebelumnya kita temukan dari origin INAP!) → **membuktikan origin INAP, Hetzner, dan Namecheap-PHX satu operator** (penamaan "media*" & "srv*" konsisten).
- `openvisiting.com` → Cloudflare (403, hidup). Sisanya NODNS (dirotasi keluar).
- Nama menonjol: `letsdothisbrutus.com`, `mefemediaagency.com`, `progmediaserve.com` (codename/agency-style).

## 3. Korelasi eksternal — kampanye SUDAH dikonfirmasi otoritas

Media & pemerintah Indonesia telah mengonfirmasi scam ini (pencarian publik):
- **Kemenkomdigi (Kominfo) menyatakan HOAKS** — "Kuota Gratis 81 GB Spesial HUT RI".
- Liputan: akurat.co, Tribun (Kaltim/Priangan), RRI, Pikiran Rakyat, NETIZ, dll.
- Modus dilaporkan: minta **nama/alamat/info Telegram & WhatsApp**, syarat **share ke 5 grup / 15 kontak**, pelaku **mengumpulkan database nomor aktif** untuk transaksi ilegal / **pinjol** tanpa izin; risiko **WhatsApp dibajak**.

**Nuansa penting:** laporan publik menyebut varian **pengumpul data (data-harvesting/phishing)**. Varian yang KITA bedah teknis (`1grd.xyz`→cloaker→CPA) **tidak** meng-exfiltrate data — ia dimonetisasi via **RTB/CPA**. → Kampanye "81GB" punya **beberapa varian** dengan monetisasi berbeda (data-harvesting DAN ad-fraud), kemungkinan dari operator/kit yang sama atau afiliasi berbeda. Keduanya nyata & berbahaya.

## 4. Konteks industri (cloaking-as-a-service)
Pola kita (fingerprint JS + anti-bot + RTB rotasi) konsisten dengan **Cloaking-as-a-Service (CaaS)** yang didokumentasikan peneliti (mis. Varonis "1Campaign", Malwarebytes). Cloaker menyajikan halaman bersih ke scanner, konten nyata ke korban — persis perilaku `free.gf920.com`.

## 5. Batas (etika/hukum) — tidak dilewati
Menembus lebih jauh (menebak `api.php`, akses dashboard Plausible, banner-grab intrusif, kompromi server) = **serangan aktif/ilegal**, di luar lingkup. Semua di atas **pasif/OSINT**. Token bot Telegram & kredensial dashboard tetap server-side → tidak dapat (dan tidak boleh) diambil dari luar. Jalur nyata berikutnya = **pelaporan** (draft siap) agar penyedia/aparat menindak.

*Sumber OSINT: Internet Archive (Wayback), OTX AlienVault, pencarian publik/berita Indonesia. Snapshot 2026-08-18.*
