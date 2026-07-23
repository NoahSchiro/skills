# ATS formatting rules

Applicant Tracking Systems parse resumes by extracting text from the PDF in reading order and pattern-matching it against sections/fields. Anything that breaks clean text extraction can silently drop content from what a recruiter or algorithm ever sees, even though the PDF looks fine to a human. Follow these rules:

## Layout
- **Single column only.** Multi-column layouts (e.g., skills sidebar next to experience) get read in the wrong order by many parsers, scrambling sentences or interleaving unrelated lines.
- **No tables.** Typst tables render visually fine but many ATS text extractors read table cells in an unpredictable order, or skip them.
- **No text inside images, icons, or shapes.** Any text that isn't real, selectable text (e.g., a name rendered as a logo/graphic) is invisible to an ATS. Don't use icon glyphs (phone/email/LinkedIn icons) as the only way information is conveyed — a plain-text label is safer, e.g. `Email: jane@example.com` not just an envelope icon.
- **No headers/footers for content that matters.** Many parsers ignore the PDF header/footer regions entirely. Contact info goes in the main body, at the top of the page.
- **No columns of dates in a separate visual block far from the role/title they belong to** — keep date ranges adjacent to the role they describe.

## Text
- **Standard section headings**: `Experience` (or `Work Experience`), `Education`, `Skills`, `Projects`, `Certifications`. Creative renames ("Where I've Made an Impact") aren't reliably recognized as the section an ATS is looking for.
- **Standard bullet characters** (`•` or `-`). Avoid custom glyphs or emoji as bullets.
- **Consistent date format** throughout, e.g. `Jan 2022 – Present`.
- **Spell out both the acronym and full term at least once** for important qualifications if there's any ambiguity (e.g., "Search Engine Optimization (SEO)") since some ATS keyword matches are literal strings.
- **Avoid special characters** for emphasis where a normal character will do (don't use unicode bold/italic look-alike characters — use Typst's actual `*bold*` markup, which produces real bold text with the underlying character preserved for extraction).

## Fonts
Use widely-supported, metric-compatible fonts, since exotic fonts can either fail to embed properly or render inconsistently across parsers:
- Liberation Sans (metric-compatible with Arial) — installed by default in this environment.
- Carlito (metric-compatible with Calibri) — installed by default in this environment.
- Liberation Serif (metric-compatible with Times New Roman) — installed by default in this environment.

Body text: 10-11pt. Name/header: 16-20pt. Section headings: 11-13pt, bold and/or small-caps is fine as long as it's real text.

## Margins and length
- Margins: 0.5in to 1in. Don't go below 0.5in to force content to fit — cut content instead (see SKILL.md Step 2).
- One page. This is a hard target for this skill, not a suggestion — recruiters and ATS-adjacent workflows both penalize multi-page resumes for early/mid-career roles. (Very senior/academic CVs with a long publication list are the one common exception; if the person's situation genuinely warrants a second page — extensive publications, patents, or 15+ years of directly relevant senior experience — confirm with them rather than assuming.)

## Links
- Typst's `#link("https://...")[text]` produces a real, clickable, extractable hyperlink — use this for LinkedIn/GitHub/portfolio links rather than typing the URL as an image or a non-linked string with a separate visual "button" styling.
- Keep the visible link text short (e.g. `linkedin.com/in/janedoe`) rather than a long tracking URL.
