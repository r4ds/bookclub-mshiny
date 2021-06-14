# 2021-05-18: Discussion with Colin Fay

Colin Fay has kindly accepted an invite to talk to our Mastering Shiny bookclub members.
At the point that Colin joins us, we have studied the first two parts of Mastering Shiny.
The next parts of the book go in-depth on the reactive computational  model underpinning
Shiny and some engineering practices (modularity, testing) that help when building
larger Shiny apps.

Colin is a Shiny expert who was one of the technical reviewers for "Mastering Shiny".
He works at ThinkR in France, and is an author of the book
["Engineering Production-Grade Shiny Apps"](https://engineering-shiny.org/)
and of the [{golem} framework](https://thinkr-open.github.io/golem/) for building Shiy Apps.

We asked the mastering-shiny bookclub attendees how they would like the meeting with
Colin organising:
"Would you like a q+a, would you like to see one of Colin's apps, or get his feedback on
your own shiny code/projects, would you like him to do a talk?"

The feedback was:
- [Lalit] Some tips and tricks while developing apps
- [Priyanka] some of his preferred ways of troubleshooting and testing Shiny (and R scripts
 in general)
- [Layla] Walk-through of one of his apps
- [Federica] App walk-through and tips

It was discussed that if we had a Q&A then we should prepare some questions beforehand.

----

## Questions for Colin
(add any questions in an appropriate subsection, or add a new subsection if your question
doesn't quite fit).

### Colin's Career

- Shiny was released in 2012
  - Were you working with R at the time
  - Did you have experience building web applications before working with shiny?

### Notable Shiny Apps

### Development

- For non-work applications, where do ideas for a new application come from?
- Are there any tools other than RStudio you use when developing a Shiny application? (e.g. VS Code + extensions)
- In your book, 'modules' are introduced really early on (and we haven't yet studied modules in the bookclub)
  - when splitting an app up into modules, how does the thought process differ from splitting up a script into functions/classes
  - what determines where to separate modules: the data, the behaviour or the UI

### Debugging and Testing

- How do you go about debugging a Shiny application? 
    - Where do you start? 
    - How do you decide if you should look at the R UI, R server, JavaScript, etc.?
- Are there any Shiny specific tools that can help with debugging?

### Deployment

### Post-deployment: Monitoring, Logging, UX

### The "Reactive" Mindset

- Tips for understanding reactivity? This appears one of the big challenges in Shiny dev
- Do you draw a lot of pictures to understand reactivity?

### Shiny compared to other web frameworks

- When Shiny was released
 - Was it obvious that it would be of value within the R community?
 - What were the typical ways to release (R-based) analysis results to clients

- What are the alternatives to Shiny for interactive data-apps now?
 - Within R?
 - Beyond R?

- I often hear R dismised as "Not production ready"
 - What does "production ready" mean wrt a framework or language
 - What features is R or Shiny missing that would make it "production ready"

- Where are Shiny's strengths relative to alternative frameworks / languages

### Shiny compared to Rmarkdown

### Adding a Shiny app to an existing project

### Contents of "Mastering Shiny"

- The book has recently been printed, how does the current version differ from the version you originally reviewed

### Golem and "Engineering-Shiny"

- How does you book complement Mastering Shiny

- Tell us about Golem: why you wrote it, and what value it brings

- Is Golem useful even for small apps / teams?

### Suggestions for further study after "Mastering Shiny"

- Do you have any suggestions for improving our Shiny skills after this book club?

### General R

### General Shiny

- Is there anything about Shiny that you think can be improved?
- Is there anything you would like to see brought into the Shiny ecosystem? (e.g. new UI framework, JS library)

### The R Community

- Who do you recommend following in the Shiny community?
