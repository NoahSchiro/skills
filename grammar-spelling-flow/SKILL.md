---
name: grammar-spelling-flow-check
description: Use this skill whenever the user pastes or shares a piece of text and asks for a grammar check, spell check, proofread, or flow/awkward-sentence check — including phrases like "check this for errors," "proofread this," "does this sound awkward," or "fix the grammar/spelling." This skill ONLY reports errors in three categories (Grammar, Spelling, Flow) as a bulleted list; it never rewrites, edits, or stylistically improves the text, and never outputs a corrected version of the whole passage. Use this instead of just rewriting the text yourself whenever the user wants an error report rather than a rewrite.
---

# Grammar, Spelling & Flow Check

## Purpose

Report grammar errors, spelling errors, and awkward/flow issues in a piece of text the user pastes in. Nothing else. This is a diagnostic report, not an edit or a rewrite.

## Strict rules

- **Never rewrite the text.** Do not output a "corrected version" of the full passage.
- **Only touch grammar, spelling, and flow.** Do not comment on content, factual accuracy, formatting, or anything else.
- **Do not modify or reproduce the passage as a whole.** Only quote the specific erroneous snippet in each bullet, not surrounding context beyond what's needed to locate it.

## Output format

Always report using exactly these three sections, in this order, even if a section is empty:

```
**Grammar**
- "erroneous text" -> "fixed text"
- ...

**Spelling**
- "erroneous text" -> "fixed text"
- ...

**Flow**
- "erroneous text" -> "fixed text"
- ...
```

- Each bullet: the exact erroneous snippet from the original text, an arrow (`->`), then the fixed version of just that snippet.
- Keep each snippet as short as possible while still being unambiguous (usually a few words to a clause, not a whole sentence, unless the whole sentence is the problem).
- If a section has no errors, write a single bullet: `- No errors found.`
- Do not add a summary, preamble, closing remarks, or overall assessment. Do not restate or reprint the full input text anywhere in the response.

## Category definitions

- **Grammar**: subject-verb agreement, verb tense, article usage, pronoun agreement, punctuation that creates a grammatical error (run-ons, comma splices, missing commas that change meaning), incorrect word forms (e.g. "effect" used as a verb where "affect" is meant, in a way that's grammatically wrong rather than just a spelling mix-up).
- **Spelling**: misspelled words, typos, wrong homophone where it's a pure spelling mix-up (e.g. "there"/"their"/"they're" used incorrectly is fine to classify here rather than grammar. Use judgment, but don't double-report the same instance in both sections).
- **Flow**: sentences that are awkward, confusing, hard to parse, or structurally clunky enough to disrupt reading. If a sentence is correct and clear, leave it alone even if a punchier version exists. *If* applicable, one *concise* bulletpoint may be left in this section about the overall structuring of the writing, but only if there is truly some structural error with the whole text.

## Process

1. Read the pasted text carefully, sentence by sentence.
2. Identify only genuine errors — when in doubt about whether something is a real error vs. a stylistic preference, leave it out.
3. Classify each finding into exactly one of the three categories (don't double-count the same issue in two sections).
4. Produce the three-section bulleted report per the format above. Do not include anything else in the response.
