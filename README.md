# NC State Accessible Dissertation Template

This template is an accessible LaTeX dissertation/thesis template for NC State ETDs. It is designed for LuaLaTeX and aims to support tagged PDF, PDF/UA-2, and PDF/A-4f workflows.

To actually create your dissertation PDF, you will compile this file

```text
dissertation-main-accessible.tex
```

use LuaLaTeX (not pdfLaTeX). I use TeXShop.

## Downloading the template

To download the template as a zipped folder:

1. Click the green **Code** button near the top of this GitHub page.
2. Choose **Download ZIP**.
3. Unzip the folder on your computer.
4. Open `dissertation-main-accessible.tex`.
5. Compile with LuaLaTeX.

You do not need to know Git in order to use this template.

## Main files

| File | Purpose |
|---|---|
| `student-information.tex` | Edit this first--you may only need to open and change once or twice during your dissertation process. It contains the student name, dissertation title, program, degree year, committee, and PDF metadata fields. |
| `dissertation-main-accessible.tex` | Main file. Go ahead and compile this file with LuaLaTeX. It loads the template settings, student information, chapters, bibliography, and appendices. |
| `student-macros.tex` | Student-specific packages and commands. Put personal macros and compatibility packages here. Do not load `hyperref`, `caption`, `titlesec`, `trackchanges`, `tcolorbox` here. |
| `front-accessible.tex` | Front matter: abstract, dedication, biography, acknowledgements, automatically generated table of contents, list of tables, list of figures, and authorship statement. At the moment, this contains detailed instructions. You will replace the sample text later with your own materials (probably towards the end). |
| `bibliography.bib` | Bibliography database. Add BibTeX entries here. |
| `optional-accessible.tex` | Optional visual choices. This includes the font choice, currently Libertinus, optional chapter heading styling, and optional theorem boxes. These are visual choices, not required content. |
| `ncsu-required.tex` | Required template setup for the accessible ETD build: hyperlinks, PDF metadata, bookmarks, microtype, NC State formatting, captions, and plain theorem-like environments. Avoid editing unless you are maintaining the template. |


## Chapter and appendix files

Chapter files are included from `dissertation-main-accessible.tex` with commands such as:

```latex
\include{Chapter-1/Chapter-1-demo}
```

Rename these as needed, but make sure the folder and file names match exactly.

Appendices are included after `\appendix`:

```latex
\include{Appendix-A/Appendix-A}
\include{Appendix-B/Appendix-B}
```

The command `\appendix` tells LaTeX that following chapters should be lettered as appendices.

## Starting a new thesis or dissertation

1. Open `student-information.tex` and replace the sample title, name, program, year, committee, PDF subject, and PDF keywords.
2. Put chapter text in the chapter files, or create new chapter folders and update the `\include{...}` lines in `dissertation-main-accessible.tex`.
3. Put bibliography entries in `bibliography.bib`.
4. Compile `dissertation-main-accessible.tex` with LuaLaTeX.
5. When you no longer need to see the instructions there, open `front-accessible.tex` and replace the sample abstract, dedication, biography, acknowledgements, and authorship statement.

A typical full compile sequence with citations is:

```text
LuaLaTeX
BibTeX
LuaLaTeX
LuaLaTeX
```

Run BibTeX on `dissertation-main-accessible`, not on `bibliography.bib`.

## Migrating from the old template

Do not copy the old preamble into this template.

Recommended process:

1. Copy the body of each old chapter into the matching chapter file. (If your files are Chapter-1.tex, just drag them into the correct folders.)
2. Copy appendix content into the appendix files.
3. Move personal macros and extra packages into `student-macros.tex`. I recommend putting the given template .tex files into Gemini or ChatGPT along with your macros and LaTeX preamble if this step is tricky.
4. Move bibliography entries into `bibliography.bib`.
5. Update the `\include{...}` lines in `dissertation-main-accessible.tex` if your chapter names are different.
6. Compile after each chapter is moved. Fix problems one chapter at a time.

Keep required accessibility and metadata settings in `ncsu-required.tex`. Keep optional visual changes in `optional-accessible.tex`.

## Figures

Use real captions and alt text. The template includes helper commands in `ncsu-accessibility.sty`, including this option:

```latex
\accessiblefigure[placement][width]{file}{alt text}{caption}{label}
```

However, you do **not** need to use `\accessiblefigure` as the usual LaTeX `figure` environment, as set up below, should be fine:

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[
    width=\textwidth,
    alt={Briefly describe the important visual content of the figure.}
  ]{figures/example.png}
  \caption{Caption explaining how the figure is used in the dissertation.}
  \label{fig:example}
\end{figure}
```

Write alt text that explains the important content of the figure. Do not use equations as screenshots unless there is no reasonable alternative.

## Tables

Use real LaTeX tables, not screenshots of tables. Keep tables as simple as possible. Make sure column headers are clear.

The template tells LaTeX to treat the first row of tables as header rows in the final tagged PDF setup.

## Common issues

Before checking any of the following tips, ask yourself this: did I use LuaLaTeX? If you did not, recompile a few times wiith Lua.

### A caption contains math

Use a short math-free caption for the List of Figures or List of Tables:

```latex
\caption[Short text caption]{Full caption with \( math \).}
```

This avoids putting complex math into the automatically generated lists.

### A section title contains math

Use a short math-free optional title:

```latex
\section[Short text title]{Full title with \( math \)}
```

Math in section titles can cause problems in bookmarks, the table of contents, and PDF validation.

### VeraPDF reports `.notdef` glyph errors

Look for unsupported Unicode characters or math in captions, short captions, section titles, bookmarks, or generated lists. Simplify titles and captions first.

### Citations show as question marks

Run the full sequence:

```text
LuaLaTeX
BibTeX
LuaLaTeX
LuaLaTeX
```

Make sure the citation key in the chapter matches the key in `bibliography.bib`.

### The table of contents, list of figures, or list of tables is wrong

Compile with LuaLaTeX again. These lists are generated automatically from chapter titles, section titles, table captions, and figure captions.

### The accessible build is slow

The `\DocumentMetadata` block in `dissertation-main-accessible.tex` turns on tagged PDF and MathML-related accessibility support. This can be slow for large math documents. For routine drafting, you may temporarily comment out that block. Turn it back on for accessibility checks and final builds.

### The PDF changes after another compile

This is normal. Large LaTeX documents often need several LuaLaTeX runs. The table of contents, lists, citations, cross-references, tags, and MathML support may settle over multiple runs.

### Fonts cause errors

Font choices are in `optional-accessible.tex`. The current optional font is Libertinus. If there is a font problem, comment out the optional font commands and revert to the default Computer Modern for LaTeX.

### Old packages break the template

Do not copy the full package list from the old template. Add packages only when needed, and put student-specific packages in `student-macros.tex`. Avoid packages that rewrite document structure or PDF metadata. Again AI can help you sort your macros.

## Clean build

If the build seems stuck on old errors, delete generated files and compile again. Common generated files include:

```text
*.aux
*.bbl
*.blg
*.lof
*.log
*.lot
*.out
*.pdf
*.synctex.gz
*.toc
```

Then run LuaLaTeX again.

## Validation

Use VeraPDF to check the final PDF. The most relevant checks are:

- PDF/A-4f validation profile
- PDF/UA-2 + Tagged PDF validation profile

Passing an automated checker is helpful, but it does not guarantee that the document is easy to use. Captions, alt text, table structure, heading structure, and readable writing still matter.

I recommend installing the Desktop version of VeraPDF, with Validation and Auto-Detect. You can save the full report as an HTML, then drop that HTML file and paste the log from your tex compilation into ChatGPT for guidance.
