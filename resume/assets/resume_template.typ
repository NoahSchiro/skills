#set document(title: "Name Resume")

#set page(
  paper: "us-letter",
  margin: (x: 0.5in, y: 0.5in),
)

#set text(font: "Liberation Sans", size: 10.5pt)
#set par(
  justify: false,
  leading: 0.6em // Slightly less than single space
)

// ---- Colors & Rules ----
#let accent = black

// ---- Helper: Section Header ----
#let section(title) = {
  text(weight: "bold", size: 11pt, smallcaps(title))
  v(-8pt)
  line(length: 100%, stroke: 0.75pt + accent)
}

// ---- Subheading: company/school + date + title + location ----
#let subheading(top-left, top-right, bottom-left, bottom-right) = {
  grid(
    columns: (1fr, auto),
    rows:    (12pt, auto),
    text(weight: "bold", top-left),
    text(weight: "bold", size: 9.5pt, top-right),
    text(style: "italic", size: 9.5pt, bottom-left),
    text(style: "italic", size: 9.5pt, bottom-right),
  )
  v(-4pt)
}

// ---- Project Heading ----
#let project-heading(left, right) = {
  grid(
    columns: (1fr, auto),
    text(size: 9.5pt, left),
    text(weight: "bold", size: 9.5pt, right),
  )
  v(-4pt)
}

// ---- Bullet list ----
#let items(..bullets) = {
  set list(indent: 5pt, marker: [•], spacing: 4pt)
  set text(size: 9.5pt)
  list(..bullets)
  v(-4pt)
}


// ==================== HEADING ====================
#align(center)[
  #text(size: 22pt, weight: "bold", smallcaps("John Doe"))
  #v(-17pt)
  City, State
  #v(-10pt)
  #text(size: 9.5pt)[
    Phone Number
    #h(8pt)
    #link("mailto:email")[email]
    #h(8pt)
    #link("linked in full link")[linkedin.com/in/name-in-kebab-case]
    #h(8pt)
    #link("github link")[github.com/account]
    #h(8pt)
    #link("personal website")[personal website]
  ]
]

// ==================== EDUCATION ====================
#section("Education")

#subheading(
)

// ==================== EXPERIENCE ====================
#section("Experience")

#subheading(
)
#items(
)

#subheading(
)
#items(
)

#subheading(
)
#items(
)

// ==================== PROJECTS ====================
#section("Projects")

#project-heading(
)
#items(
)

#project-heading(
)
#items(
)

#project-heading(
)
#items(
)

// ==================== FOSS ====================
#section("Open Source Contributions")

#project-heading(
)
#items(
)

#project-heading(
)
#items(
)

// ==================== SKILLS ====================
#section("Technical Skills")

#set text(size: 9.5pt)
// This is where we really try to keyword match. Examples:
//- *Technologies*: Python, C, C++, Cuda, Rust, Go, SQL, PyTorch, JupyterLab, AWS, GCP, Kubernetes, Docker
//- *Certifications*: TS\//SCI, Google Big Data and ML Fundamentals Certification
