# Writing Help pages

Each file named `NN-topic.md` in this folder becomes one topic in the app's
Help tab. Files without the two-digit prefix (like this README) are ignored.

- **Order:** the `NN` prefix sets the order in the topic list. Pick a number
  between its neighbours, or renumber the files, to place a new page.
- **Label:** the first `# ` heading is the topic's label. Use `##` and below
  for sections inside the page.
- **Markdown:** GitHub-flavoured Markdown, including tables, strikethrough
  and autolinks.
- **Images:** put them in `images/` and link them as
  `![alt text](static/help/images/name.png)`. The app serves this folder
  under `static/`, so relative paths like `images/name.png` will not work.
- **Warnings:** for bold red text, use
  `<p class="help-warning"><strong>Text</strong></p>`.
- Pages are read when the app starts; restart the app to see edits.
