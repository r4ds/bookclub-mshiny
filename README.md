# R4DS Mastering Shiny Book Club

Welcome to the R4DS Mastering Shiny Book Club!

We are working together to read [Mastering Shiny](https://mastering-shiny.org/) by Hadley Wickham.
Join the #book_club-mastering_shiny channel on the [R4DS Slack](https://r4ds.io/join) to participate.
As we read, we are producing [notes about the book](https://r4ds.github.io/bookclub-mshiny/).

## Meeting Schedule

If you would like to present, please add your name next to a chapter using the [GitHub Web Editor](https://youtu.be/d41oc2OMAuI)!

*Cohort 1: (starts 2021-02-16) - Tuesdays, 12pm EST/EDT*

- 2021-02-16: Chapter 1: _Your First Shiny App_: Jerome Ahye
- 2021-02-23: Chapter 2: _Basic UI_: Matt Curcio
- 2021-03-02: Chapter 3: _Basic Reactivity_: Priyanka
- 2021-03-09: Chapter 4: _Case Study: ER injuries_: David Heß
- 2021-03-16: Chapter 5: _Workflow_: Shamsudeen
- 2021-03-23: Chapter 6: _Layout, themes, HTML_: Russ Hyde
- 2021-03-30: Chapter 7: _Graphics_: Jessica Mukiri
- 2021-04-06: Chapter 8: _User Feedback_: Anne Hoffrichter
- 2021-04-13: Chapter 9: _Uploads and Downloads_: Presenter TBC
- 2021-04-20: Chapter 10: _Dynamic UI_: Presenter TBC
- 2021-04-27: Chapter 11: _Bookmarking_: Presenter TBC
- 2021-05-04: Chapter 12: _Tidy evaluation_: Presenter TBC

## How to Present

This repository is structured as a [{bookdown}](https://CRAN.R-project.org/package=bookdown) site.
To present, follow these instructions:

1. [Setup Github Locally](https://www.youtube.com/watch?v=hNUNPkoledI)
2. Fork this repository.
3. Create a New Project in RStudio using your fork.
4. Create a New Branch in your fork for your work.
5. Edit the appropriate chapter file. Use `##` to indicate new slides (new sections).
6. If you use any packages that are not already in the `DESCRIPTION`, add them. You can use `usethis::use_package("myCoolPackage")` to add them quickly!
7. Commit your changes.
8. Push your changes to your branch.
9. Open a Pull Request (PR) to let us know that your slides are ready.

When your PR is checked into the main branch, the bookdown site will rebuild, adding your slides to [this site](https://r4ds.github.io/bookclub-mshiny/).

## Example Shiny Apps

If you create any shiny apps to illustrate the concepts in a chapter, you are
welcome to include them with your chapter notes. The apps should be placed in
the `./examples/` directory of the repository.

Create a subdirectory named
`./examples/<chapter-number>_<chapter-name>_<app-description>` for each of the
apps you create and place your `app.R` file in there.

For example, if while working on chapter 3 ("Basic Reactivity"), you create an
app to illustrate controlling the timing of evaluation, you might add your app
as `./examples/03-basic_reactivity-timing_evaluation/app.R`.

## Images

If any static image files are used in the .Rmd for a chapter, please add them into the directory
`./images/<chapter_number>-<title_stub>/`. For example, to include images for the "01-your_first_shiny_app" chapter, please place them in `./images/01-your_first_shiny_app/`.
