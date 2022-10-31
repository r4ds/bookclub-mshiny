# R4DS Mastering Shiny Book Club

Welcome to the R4DS Mastering Shiny Book Club!

We are working together to read [Mastering Shiny](https://mastering-shiny.org/) by Hadley Wickham.
Join the [#book_club-mshiny](https://rfordatascience.slack.com/archives/C012VLJ0KRB) channel on the [R4DS Slack](https://r4ds.io/join) to participate.
As we read, we are producing [notes about the book](https://r4ds.github.io/bookclub-mshiny/).  
You can catch up on Book Club recordings on the Mastering Shiny [YouTube Playlist](https://www.youtube.com/playlist?list=PL3x6DOfs2NGi4B1Idnv8MLaUhFwOqfc3h).

## Meeting Schedule

If you would like to present, please see the sign-up sheet for your cohort (linked below, and pinned in the [#book_club-mshiny](https://rfordatascience.slack.com/archives/C012VLJ0KRB) channel on Slack)!

- Cohort 1 (started 2021-02-16, ended 2021-08-10): [meeting videos](https://www.youtube.com/playlist?list=PL3x6DOfs2NGi4B1Idnv8MLaUhFwOqfc3h)
- Cohort 2 (started 2021-07-21, ended 2022-01-19): [meeting videos](https://www.youtube.com/playlist?list=PL3x6DOfs2NGjhwrYvdmrKRNcvXX7X6ldt)
- [Cohort 3](https://docs.google.com/spreadsheets/d/1YnFBY5nwSFoQuryPXtfmoguVbE4sIrjP_LhRLSZM8dc/edit?usp=sharing) (started 2022-04-16): [Saturdays, 8:00am CST/CDT](https://www.timeanddate.com/worldclock/converter.html?iso=20220416T130000&p1=1440&p2=170&p3=51&p4=250&p5=136&p6=24) | [meeting videos](https://www.youtube.com/playlist?list=PL3x6DOfs2NGg76TRO2h1vtBeRyRKjVZSb)
- [Cohort 4](https://docs.google.com/spreadsheets/d/12b7L0jkMKC29vWqovVjoQKLVE1aB3YtIcu9lhWCGxI0/edit?usp=sharing) (started 2022-11-15): [Tuesdays, 12:00pm CST/CDT](https://www.timeanddate.com/worldclock/converter.html?iso=20221115T180000&p1=24&p2=125&p3=1440) | [meeting videos](https://www.youtube.com/playlist?list=PL3x6DOfs2NGhXh0_1fKhoPQ9sm4OAf8oV)


## How to Present

This repository is structured as a [{bookdown}](https://CRAN.R-project.org/package=bookdown) site.
To present, follow these instructions:

Do these steps once:

1. [Setup Github Locally](https://www.youtube.com/watch?v=hNUNPkoledI) (also see [_Happy Git and GitHub for the useR_](https://happygitwithr.com/github-acct.html))
2. Install {usethis} and {devtools} `install.packages(c("usethis", "devtools"))`
3. Set up a default {usethis} directory:
  - `usethis::edit_r_profile()` to open your profile for editing.
  - Add this line: `options(usethis.destdir = "YOURDIR")` (replace `YOURDIR` with the root directory under which you want your R projects to appear; or you can skip these steps, and the project will be saved to your Desktop).
  - Restart your R session (Session/Restart R in Rstudio).
4. `usethis::create_from_github("r4ds/bookclub-mshiny")` (cleanly creates your own copy of this repository).

Do these steps each time you present another chapter:

1. Open your project for this book.
2. `usethis::pr_init("my-chapter")` (creates a branch for your work, to avoid confusion, making sure that you have the latest changes from other contributors; replace `my-chapter` with a descriptive name, ideally).
3. `devtools::install_dev_deps()` (installs any packages used by the book that you don't already have installed).
4. Edit the appropriate chapter file, if necessary. Use `##` to indicate new slides (new sections).
5. If you use any packages that are not already in the `DESCRIPTION`, add them. You can use `usethis::use_package("myCoolPackage")` to add them quickly!
6. Build the book! ctrl-shift-b (or command-shift-b) will render the full book, or ctrl-shift-k (command-shift-k) to render just your slide. Please do this to make sure it works before you push your changes up to the main repo!
7. Commit your changes (either through the command line or using Rstudio's Git tab).
8. `usethis::pr_push()` (pushes the changes up to github, and opens a "pull request" (PR) to let us know your work is ready).
9. (If we request changes, make them)
10. When your PR has been accepted ("merged"), `usethis::pr_finish()` to close out your branch and prepare your local repository for future work.
11. Now that your local copy is up-to-date with the main repo, you need to update your remote fork. Run `gert::git_push("origin")` or click the `Push` button on the `Git` tab of Rstudio.

When your PR is checked into the main branch, the bookdown site will rebuild, adding your slides to [this site](https://r4ds.io/mshiny).

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
