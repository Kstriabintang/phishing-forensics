# 🛡️ Phishing & Threat-Intelligence Forensic Case Files

Defensive **threat-intelligence and phishing-forensics** case files. Each case documents a
real-world scam campaign observed in the wild, dissected using **passive, read-only** techniques,
with full chain-of-custody (raw evidence + SHA-256 manifests), screenshots, IOC lists, print-ready
reports, and ready-to-send abuse drafts.

> **Purpose:** understanding, documenting, and **reporting** malicious infrastructure for takedown.
> Not for offensive use. All network interactions are passive (DNS / WHOIS / CT / passive-DNS +
> sandboxed browser renders) — no exploitation, no data submitted to attacker infrastructure.

---

## 📁 Cases

### [`2026-08-18_kuota-gratis-81gb-hutri81`](2026-08-18_kuota-gratis-81gb-hutri81/) — "Kuota Gratis 81GB HUT RI ke-81"

WhatsApp free-data reward-bait scam → multi-network CPA/ad-fraud funnel with a device-fingerprint
cloaker. Two real origins de-cloaked (INAP Chicago + Hetzner Helsinki), a **500+ domain network**
mapped and tagged, a second product line (Telegram Mini App quiz), and a **2018 Chinese
online-gambling lineage**. Officially declared a hoax by **Kemenkomdigi (Indonesia)**.

<table>
<tr>
<td width="33%" valign="top"><a href="2026-08-18_kuota-gratis-81gb-hutri81/"><img src="2026-08-18_kuota-gratis-81gb-hutri81/screenshots/01_landing_merdeka_81gb.png" width="100%" alt="Landing 81GB"></a></td>
<td width="33%" valign="top"><img src="2026-08-18_kuota-gratis-81gb-hutri81/screenshots/03_cloaker_free-gf920_loading.png" width="100%" alt="Cloaker"></td>
<td width="33%" valign="top"><img src="2026-08-18_kuota-gratis-81gb-hutri81/screenshots/05_telegram_quiz_16gift.png" width="100%" alt="Telegram quiz"></td>
</tr>
<tr>
<td align="center"><sub><b>Landing "81 GB" bait</b></sub></td>
<td align="center"><sub><b>Fingerprint cloaker</b></sub></td>
<td align="center"><sub><b>Telegram "quiz" scam</b></sub></td>
</tr>
</table>

**→ Start with the case [README](2026-08-18_kuota-gratis-81gb-hutri81/README.md) and
[master dossier](2026-08-18_kuota-gratis-81gb-hutri81/DIGITAL-TRACES-DOSSIER.md).**

---

## 🧭 Case layout (standard)

```
<case>/
├── README.md                    # case landing page
├── DIGITAL-TRACES-DOSSIER.md    # master consolidated report
├── SCREENSHOTS.md               # visual evidence gallery
├── IOC.txt                      # indicators of compromise
├── screenshots/                 # PNG evidence
├── report/                      # print-ready PDF
├── analysis/                    # deep-dives, host inventory, abuse drafts
├── evidence/                    # raw captures + SHA256SUMS.txt (chain-of-custody)
└── tools/                       # safe, static-only helper scripts
```

## 🔒 Safety

- `_QUARANTINE_DO_NOT_EXECUTE/` (git-ignored) holds any potentially-malicious sample, treated as
  **inert data** — static analysis only, never executed/installed.
- **No secrets** (API keys, tokens, credentials) are committed. See [`.gitignore`](.gitignore).

## ⚖️ Disclaimer & License

For defensive security research, education, and abuse reporting only. The author is not affiliated
with any documented malicious infrastructure. Tools are provided under the MIT License
(see [`LICENSE`](LICENSE)); written analysis is shared for defensive purposes. Indicators may go
stale as attacker infrastructure rotates.
