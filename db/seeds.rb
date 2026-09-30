# Sample projects so the site isn't empty on first run.
# Safe to run more than once: it only adds projects whose slug doesn't exist yet.
# Edit or delete these at /admin once you've added your own.

projects = [
  {
    title: "This portfolio",
    slug: "this-portfolio",
    summary: "A Ruby on Rails site with a password-protected admin for editing projects and reading messages.",
    role: "Solo project",
    tech_stack: "Ruby, Ruby on Rails, SQLite, HTML, CSS",
    year: Date.current.year,
    featured: true,
    position: 1,
    problem: <<~TEXT,
      I needed somewhere to show my work that was itself proof I can build things.
      A page builder would have been faster, but it wouldn't say anything about me as an engineer.
    TEXT
    approach: <<~TEXT,
      I built it as a small Rails app. Projects are stored in a SQLite database and written as short case studies, so each one explains the problem, how I built it, and what came of it.

      There's an admin area behind HTTP basic auth for adding and reordering projects. The contact form saves messages to the database, and it's protected with a rate limit and a hidden field that catches bots.

      It has model and integration tests, and light and dark themes that follow the visitor's system setting.
    TEXT
    outcome: <<~TEXT
      Replace this with what you learned. For example: how Rails routes a request to a controller, why the contact form needed a rate limit, or what you'd do differently next time.
    TEXT
  },
  {
    title: "Example: study group matcher",
    slug: "example-study-group-matcher",
    summary: "Replace this with one sentence on what the project does and who it's for.",
    role: "Team of 3, backend lead",
    tech_stack: "Java, Spring Boot, PostgreSQL",
    year: Date.current.year,
    featured: true,
    position: 2,
    problem: <<~TEXT,
      Describe the problem in two or three sentences: who had it, and why it mattered enough to build something.
    TEXT
    approach: <<~TEXT,
      Explain the one or two decisions that shaped the project, and why you made them. A recruiter learns more from "I chose X because Y" than from a list of features.
    TEXT
    outcome: <<~TEXT
      Say what happened: people who used it, a number that improved, a grade, or what you'd change now. Honest and small beats vague and big.
    TEXT
  },
  {
    title: "Example: sorting visualizer",
    slug: "example-sorting-visualizer",
    summary: "Replace this with one sentence on what the project does and who it's for.",
    role: "Solo project",
    tech_stack: "Java, JavaFX",
    year: Date.current.year - 1,
    featured: false,
    position: 3,
    problem: "Describe the problem.",
    approach: "Explain how you built it and why.",
    outcome: "Say what came of it."
  }
]

projects.each do |attributes|
  Project.find_or_create_by!(slug: attributes[:slug]) do |project|
    project.assign_attributes(attributes)
  end
end

puts "Projects in the database: #{Project.count}"
