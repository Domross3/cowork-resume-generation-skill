# Layout Constants & the Whitespace Audit Loop

Goal: iterate until (a) no bullet "dangles" — no multi-line bullet whose last line is nearly empty — and (b) content fills as close to one full printed page as possible without spilling to a second.

## Layout constants (US Letter)

Build the resume as a single self-contained HTML file:

- `@page { size: letter; margin: 0.5in; }`
- body `max-width: 7.5in`, ~10pt serif (Georgia works well), `line-height` ~1.25
- Letter content height at 0.5in margins ≈ **960px at 96dpi** — that is the page-fill denominator.
- Line-length calibration at these settings: ~100 chars/line at 10pt body. One-line bullets ≤96 chars; two-line bullets 185–198 chars. Use this to draft, but trust the audit to verify.

Start from `assets/template.html`, which already contains the styles and the audit script below.

## The audit script

Embedded before `</body>`; only activates when the URL contains `?audit`, so it never appears in the printed PDF.

```html
<script>
if (location.search.includes('audit')) {
  addEventListener('load', () => {
    const lh = el => { const v = parseFloat(getComputedStyle(el).lineHeight); return isNaN(v) ? parseFloat(getComputedStyle(el).fontSize) * 1.2 : v; };
    const rows = [];
    document.querySelectorAll('li, .skills p, .note').forEach(el => {
      const r = el.getBoundingClientRect(); if (r.height < 2) return;
      const lines = Math.round(r.height / lh(el));
      const range = document.createRange(); range.selectNodeContents(el);
      const rects = Array.from(range.getClientRects()).filter(x => x.width > 1 && x.height > 2);
      const last = rects[rects.length - 1];
      const fill = last ? Math.round(100 * last.width / r.width) : 0;
      const flag = (lines > 1 && fill < 50) ? 'DANGLE' : (lines === 1 && fill < 80 && !el.classList.contains('note') ? 'SHORT' : 'ok');
      rows.push(`${flag} | lines=${lines} fill=${fill}% | ${el.textContent.trim().slice(0, 48)}`);
    });
    const pagePx = 10 * 96; // 960px = one Letter page at 0.5in margins
    const used = document.body.scrollHeight - 48; // minus on-screen body padding
    const pre = document.createElement('pre');
    pre.id = 'auditbox';
    pre.style.cssText = 'font-size:11px;background:#ffc;padding:8px;margin-bottom:16px;white-space:pre-wrap;line-height:1.35;';
    pre.textContent = `AUDIT-REPORT\npage-fill=${Math.round(100 * used / pagePx)}% (content ${used}px of ${pagePx}px)\n` + rows.join('\n') + '\nEND-AUDIT';
    document.body.insertBefore(pre, document.body.firstChild);
  });
}
</script>
```

The report prints page-fill % at the top, then one line per bullet: flag, rendered line count, last-line fill %, text.

- `DANGLE` = a 2+ line bullet whose last line is <50% full → tighten it down a line OR add substance until the last line fills past ~80%.
- `SHORT` = a 1-line bullet under 80% full → add a defensible detail and run it toward the end of the line.
- `ok` = leave it.

## Reading the audit — three paths, in order of preference

1. **Claude-in-Chrome extension** (if connected): `tabs_context_mcp` → `navigate` to `file:///<abs-path>.html?audit=1` → `javascript_tool` to read `document.getElementById('auditbox').textContent`. Bump the cache-buster each pass (`?audit=2`, `?audit=3`, …) to force reloads. Fully automated.
2. **Headless Chromium via shell** (no extension needed): run `scripts/audit.sh <abs-path-to-resume.html>`. It finds a Chrome/Chromium binary, dumps the rendered DOM with `--headless`, and prints just the AUDIT-REPORT block. Each run is a fresh process — no cache-buster needed. If no browser binary exists in the environment, fall through to path 3.
3. **Manual** (always works): ask the user to open `file:///<abs-path>.html?audit=1` in any Chromium-based browser and paste the yellow report text (or a screenshot) back into chat. Batch your edits so the user only has to do this 2–3 times, not ten.

If desktop screen control is available and Chrome can be opened but not scripted, a screenshot + zoom into the yellow box also works as a fallback for path 1.

## The loop

1. Generate → read audit → for each DANGLE/SHORT, edit per the rules above → re-read. Repeat.
2. Stop when there are **zero DANGLE/SHORT flags and page-fill is 95–97%**.

Decision rules (important):

- **Fill the page with content, not air.** If the layout comes in short, ADD a bullet, a course, or a project from the profile rather than inflating line-height or margins. (Tiny line-height/margin nudges are a last resort only.) This is why the profile holds surplus content.
- **Never let fill hit 101%+** — that silently becomes a second printed page. Leave ~3% headroom (target ~97%) because Chrome's PDF rasterizer rounds up.
- **Trust the audit over any heuristic.** It measures the actual rendered page at true print width. A narrower browser window makes bullets look longer than they print — the char-per-line numbers are for drafting only.
- **One-line bullets should run to near the end of the line** — coursework and skills lists especially; there's always one more relevant item in the profile.

## Export

Open the file fresh WITHOUT `?audit`. Chrome → ⌘P (Ctrl+P) → **uncheck "Headers and footers"** (Chrome's date/URL/page-number stamps steal vertical space and can force a 2nd page) → Margins: Default (the page sets its own) → Save as PDF. Verify: exactly one page. If a headless browser is available, `scripts/audit.sh --pdf` produces the PDF the same way; still have the user spot-check it.
