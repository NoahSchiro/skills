---
name: resume
description: Use this skill whenever the user wants a resume, CV, or one-pager tailored to a job posting — including culling a longer CV down to one page, rewriting bullets to match a job description, optimizing for Applicant Tracking Systems (ATS), or building a resume from scratch. Also use it any time the user mentions "resume," "CV," "one-pager," or pastes a job posting alongside their background and wants a tailored document. Resumes produced by this skill are always written in Typst and compiled to PDF. Trigger this even if the user only provides one of the two required inputs (their resume/background or a job posting) — the skill will ask for whichever is missing. Also covers the related but separate task of writing a tailored cover letter from the same CV + job posting (only when the user asks for a cover letter specifically, not automatically).
---
 
# Resume
 
Produce a one-page, ATS-optimized, Typst-authored resume that is tightly tailored to a specific job posting.
 
A resume that tries to say everything says nothing to an ATS or a hiring manager. The core job here isn't formatting — it's **editorial judgment**: given a person's full history and one specific job posting, decide what to keep, what to cut, and how to phrase what remains so it's obviously relevant, keyword-matchable, and fits on one page. Typst is the output format because it gives precise, ATS-safe control over spacing and layout without fighting a WYSIWYG editor.
 
## Step 0: Gather required inputs
 
You need **two things** before you can do anything useful:
 
1. **The person's background** — an existing resume/CV (uploaded file, pasted text) or, if they don't have one, a description of their experience.
2. **The job posting** — pasted text or a URL to fetch.
If either is missing, ask for it before proceeding. Don't guess at a job posting's requirements or invent experience — both defeat the purpose of tailoring.
 
If the resume or job posting is a URL, fetch it. If the resume is a file (PDF, docx, etc.), read it — check for relevant skills (`pdf-reading`, `docx`, `file-reading`) if you need help extracting it.
 
If the person's resume contains a LinkedIn and/or GitHub URL, and time/context permits, fetch or search them. People routinely leave good material off their CV — side projects, more complete work history, pinned repos that demonstrate exactly the skill a job posting wants. Treat what you find as *candidate material*, not automatically-included content: confirm anything non-obvious with the person before presenting it as fact on their resume (e.g. "I found a repo called X on your GitHub that looks relevant to this ML role — want me to include it?"). Never fabricate or embellish; if you can't verify something, leave it out.
 
## Step 1: Reverse-engineer the job posting
 
Before touching the resume, extract from the job posting:
- **Hard requirements** (years of experience, degree, certifications, tools/languages named explicitly)
- **Core responsibilities** (the verbs — what will this person actually do day to day?)
- **Keywords/phrases an ATS would scan for** — exact tool names, methodologies, job titles, industry terms. ATS systems frequently do literal string matching, so if the posting says "CI/CD pipelines," the resume should say "CI/CD pipelines," not "automated deployment workflows."
- **Implicit priorities** — what's mentioned first, repeated, or given a full paragraph tends to matter more than something in a single trailing clause.
Keep a running list of these keywords. You'll use it twice: once to decide what content survives the cut, and again at the end as a check.
 
## Step 2: Select and cut
 
Take the full inventory of the person's experience (resume + anything relevant surfaced from LinkedIn/GitHub) and score it against what you just extracted. For each job, project, or bullet point, ask: **does this help this specific application?** Not "is this impressive" in the abstract — impressive-but-irrelevant loses to relevant-but-modest almost every time on a one-page resume.
 
Practical cutting order when things don't fit:
1. Drop entire roles/projects that are old, unrelated, and short (e.g., a summer job from a decade ago in a different field).
2. Within a kept role, drop bullets that don't map to any requirement or keyword from the posting.
3. Compress remaining bullets — tighten language before you shrink font size or margins.
4. Font size and margins are a last resort, and only within ATS-safe bounds (see Step 4). Never go below 10pt body text or 0.5in margins to make things fit — cut more content instead.
Don't just delete — actively decide what to feature. If the person has five roles and the posting is for a backend engineering job, a role heavy on backend work should get more bullets and more detail than one that was mostly meetings, even if the latter is more recent.
 
## Step 3: Rewrite content
 
Every bullet point should follow this shape, adapted from the **STAR** method (Situation/Task, Action, Result) but compressed into one line:
 
> **[Action verb] + [what you did / the task] + [quantified or concrete result]**
 
- Every bullet starts with a strong action verb in past tense for past roles, present tense for the current one (*Led, Built, Reduced, Launched, Negotiated, Designed* — not *Responsible for* or *Helped with*).
- Prefer a number, percentage, dollar amount, or scale wherever the person's background supports one ("cut deploy time 40%" beats "improved deploy time"). Never invent a number that wasn't in the source material — if there's no metric available, keep the bullet qualitative rather than fabricating one.
- Weave in the posting's keywords naturally, only where they're actually true of the person's experience. Keyword-stuffing a bullet with something the person didn't do is worse than leaving it out — it fails both the ATS relevance check and, if they get an interview, an honest conversation.
- One line per bullet where possible; two only for the single most important accomplishment in the most relevant role.
## Step 4: Build the Typst document

Ideally, the provided typst document already gives a format to work off of. However, if the user provided a document type other than typst, you should use the template at `assets/resume_template.typ`. You can assume this format is ATS-safe.

Use `references/ats_formatting.md` to determine if the typst document is ATS-safe. If it is not, suggest changes before implementing them. The rules, in short:
 
- Single column, no tables, no text boxes, no icons standing in for words, no images.
- Standard section headers as plain text (`Experience`, `Education`, `Skills`, not creative alternatives).
- Contact info (name, phone, email, location, LinkedIn/GitHub) in the body of the page, not in a header/footer — many ATS parsers drop header/footer text entirely.
- A font from `references/ats_formatting.md`'s safe list (Liberation Sans/Carlito are installed in this environment and are metric-compatible with Arial/Calibri).
- Dates right-aligned or clearly separated, in a consistent format throughout.
Write the person's actual tailored content into the template structure — don't just fill placeholder text, adapt the layout itself if a section (e.g., Projects, Certifications) doesn't apply.
 
## Step 5: Compile and verify one page
 
Try using the `typst` CLI first. If that fails, use the python package for typst (`pip install typst --break-system-packages`).
 
After compiling, check the page count (the script reports it). **If it's more than one page, go back to Step 2 and cut more — don't shrink fonts/margins past the floor in Step 2 to force a fit.** Iterate: cut, recompile, check, repeat.
 
Once it's one page, do a final pass against your Step 1 keyword list: are the posting's most important terms present, and present truthfully? If an important keyword is missing and the person genuinely has that experience somewhere, work it in before finishing.
 
## Step 6: Deliver
 
Save both the `.typ` source and the compiled `.pdf` to the outputs directory and present them — the source lets the person tweak wording themselves later by themselves.
 
---
 
## Optional: Cover letter
 
Only do this when the user separately asks for a cover letter — it is not an automatic part of every resume request, since not every application wants or needs one.
 
Given the same CV and job posting already gathered above:
- 3-4 paragraphs, one page, plain prose (not bulleted) — this is the one place in the whole workflow that isn't a bulleted, ATS-parsed document, since cover letters are read by humans first.
- Opening paragraph: which role, and one sharp, specific reason the person is a fit (pull from the real overlap you found in Step 1/2, not generic enthusiasm).
- Middle paragraph(s): 1-2 concrete examples from their actual background that map directly to the posting's core responsibilities — reuse the STAR framing from the resume bullets but let it breathe into full sentences instead of compressed fragments.
- Closing: brief, confident, no groveling.
- Written as plain text. See `references/cover_letter.md` for a template and tone guidance.
- Never fabricate specifics about the company beyond what's in the posting or what the person tells you. You may perform a search the company if you need additional information. A wrong guess about the company reads worse than a generic line.
