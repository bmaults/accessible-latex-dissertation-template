%%
%% This is file `ncsuthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% ncsuthesis.dtx  (with options: `class')
%% --------------------------------------------------------------------
%% ncsuthesis --- A thesis class conforming to NC State ETD guidelines.
%% Original: jmhykes@ncsu.edu
%% Released under the LaTeX Project Public License v1.3c or later
%% See http://www.latex-project.org/lppl.txt
%% 2026 Updates by Bevin Maultsby, bmaults@ncsu.edu
%% --------------------------------------------------------------------
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ncsuthesis}[2026/07/23 v0.6 NC State ETD conformant thesis class]
%% -------------------------------------------------------------------------- %%
%% ------------------------------ Thesis type ------------------------------- %%
%% -------------------------------------------------------------------------- %%
\newcommand{\ncsu@thesistype}{phd}
\DeclareOption{phd}{\renewcommand{\ncsu@thesistype}{phd}}
\DeclareOption{ms}{\renewcommand{\ncsu@thesistype}{ms}}

%% Spacing options
\newcommand{\ncsu@defaultspacing}{\onehalfspacing}
\DeclareOption{singlespacing}{
     \renewcommand{\ncsu@defaultspacing}{\singlespacing}}
\DeclareOption{onehalfspacing}{
     \renewcommand{\ncsu@defaultspacing}{\onehalfspacing}}
\DeclareOption{doublespacing}{
     \renewcommand{\ncsu@defaultspacing}{\doublespacing}}

\newenvironment{lscape}{\begin{lscapenum}}{\end{lscapenum}}
\DeclareOption{hardcopy}{
    \renewenvironment{lscape}{\begin{lscapenotnum}}{\end{lscapenotnum}}
}

\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{book}}
\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{book}}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{book}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{book}}

\DeclareOption*{\PackageWarning{ncsuthesis}{Unknown option `\CurrentOption'. Ignoring}}
\ExecuteOptions{phd,onehalfspacing} % the default option is <phd, onehalfspacing>
\ProcessOptions
\LoadClass[openany,oneside,titlepage,letterpaper]{book}

\RequirePackage{setspace}
\RequirePackage{hyphenat}
\RequirePackage{nolbreaks}
\RequirePackage{ifthen}

%% The original ncsuthesis class loaded tocloft here.
%% This accessible version does not load tocloft because tocloft interferes
%% with linked TOC/LOF/LOT entries in tagged PDF builds.
\RequirePackage{graphicx}
\RequirePackage[nottoc]{tocbibind} % includes lof, lot, refs in toc
\RequirePackage{calc}

%%----------------------------------------------------------------------------%%
%%---------------------------- Formatting Options ----------------------------%%
%% -------------------------------------------------------------------------- %%
%% Capital letter height
\newlength{\ncsu@capitalheight}
\settoheight{\ncsu@capitalheight}{D}

%% Line height
\newlength{\ncsu@lineheight}
\setlength{\ncsu@lineheight}{2.0ex}

%% Leading height: The leading changes throughout the document, so this
%%  length must be updated
\newlength{\ncsu@leading}

%% We must add two double spaces plus one capital-height (for the page number)
%%  to footskip.  Footskip is measured from the top of the bottom margin.
%%  (See geometry package documentation, note that includefoot option is used.)
\ncsu@defaultspacing
\newlength{\ncsu@footskip}
\setlength{\ncsu@footskip}{\ncsu@capitalheight}
\addtolength{\ncsu@footskip}{2\baselineskip}
\addtolength{\ncsu@footskip}{0.5ex}  % A little extra space to ensure there
                                     %  are 2 full double spaced lines
\RequirePackage[margin=1in]{geometry}
                
%% -------------------------------------------------------------------------- %%

%% Heading format
%% Formatting applied to chapter and preliminary-page headings.
%% Section-level headings are defined separately below.

%% NC State requires most text to be the same size as the body text.
%% Preliminary-page headings should therefore stay at \normalsize unless the
%% Graduate School approves a different style.
\newcommand{\ncsu@headingformat}{%
  \normalfont
  \normalsize
  \bfseries
  \MakeUppercase
}
\providecommand{\headingformat}[1]{%
    \renewcommand{\ncsu@headingformat}{#1}%
}

%% \chapter*-to-first line space
%% This applies to preliminary headings, and ToC, LoF, LoT
\newlength{\ncsu@afterschapsep}
\setlength{\ncsu@afterschapsep}{3\ncsu@lineheight}

%% -------------------------------------------------------------------------- %%
%% Headers/footers - page number
\pagestyle{plain}

%% -------------------------------------------------------------------------- %%
%% Vertical space around tables and figures, triple spacing
\setlength{\textfloatsep}{3\ncsu@lineheight}
\setlength{\intextsep}{3\ncsu@lineheight}

%%----------------------------------------------------------------------------%%
%%---------------------------  Content Options -------------------------------%%
%% -------------------------------------------------------------------------- %%
%% Author name
\newcommand{\ncsu@authorfirstmiddle}{First Middle}
\newcommand{\ncsu@authorlast}{Last}

%% Command to test for period after middle name
\newboolean{@ncsu@needsperiod}
\newcommand{\ncsu@testlastchar}[2]{%
    \ifthenelse{\equal{#2}{\relax}}{
        \ifthenelse{\equal{#1}{.}}{%
            \setboolean{@ncsu@needsperiod}{false}
        }{% #1 != .
            \setboolean{@ncsu@needsperiod}{true}
        }
        \let\next=\relax
    }
    {% #2 != relax
        \let\next=\ncsu@testlastchar
    }
    \next#2
}

\providecommand{\student}[2]{
    \renewcommand{\ncsu@authorfirstmiddle}{#1}
    \renewcommand{\ncsu@authorlast}{#2}
    \ncsu@testlastchar#1\relax
    \author{\ncsu@authorfirstmiddle{} \ncsu@authorlast}
}

%% Degree year - in case the degree year doesn't match the current year.
\newcommand{\ncsu@year}{\the\year}
\providecommand{\degreeyear}[1]{
    \renewcommand{\ncsu@year}{#1}
}

%% -------------------------------------------------------------------------- %%
%% Thesis Title
\newcommand{\ncsu@thesistitle}{My Thesis Title}
\providecommand{\thesistitle}[1]{\renewcommand{\ncsu@thesistitle}{#1}}

%% -------------------------------------------------------------------------- %%
%% Section-level heading formatting
%% -------------------------------------------------------------------------- %%
%% NC State requires section-level headings to use the body-text font size.
%% These definitions replace the obsolete sectsty package while retaining the
%% standard LaTeX sectioning mechanism, counters, bookmarks, and heading tags.
%%
%% The definitions are delayed until \begin{document} because current tagged-PDF
%% support may replace sectioning definitions during preamble processing.

\AtBeginDocument{%
  \renewcommand{\section}{%
    \@startsection
      {section}%
      {1}%
      {\z@}%
      {-3.5ex \@plus -1ex \@minus -.2ex}%
      {2.3ex \@plus .2ex}%
      {\normalfont\normalsize\bfseries}%
  }%

  \renewcommand{\subsection}{%
    \@startsection
      {subsection}%
      {2}%
      {\z@}%
      {-3.25ex \@plus -1ex \@minus -.2ex}%
      {1.5ex \@plus .2ex}%
      {\normalfont\normalsize\bfseries}%
  }%

  \renewcommand{\subsubsection}{%
    \@startsection
      {subsubsection}%
      {3}%
      {\z@}%
      {-3.25ex \@plus -1ex \@minus -.2ex}%
      {1.5ex \@plus .2ex}%
      {\normalfont\normalsize\bfseries}%
  }%

  \renewcommand{\paragraph}{%
    \@startsection
      {paragraph}%
      {4}%
      {\z@}%
      {3.25ex \@plus 1ex \@minus .2ex}%
      {-1em}%
      {\normalfont\normalsize\bfseries}%
  }%

  \renewcommand{\subparagraph}{%
    \@startsection
      {subparagraph}%
      {5}%
      {\parindent}%
      {3.25ex \@plus 1ex \@minus .2ex}%
      {-1em}%
      {\normalfont\normalsize\bfseries}%
  }%
}

%% -------------------------------------------------------------------------- %%
%% ---------------------  Chapter Commands ---------------------------------- %%
%% -------------------------------------------------------------------------- %%

%% -------------------------------------------------------------------------- %%
%% Chapter heading formatting
%% -------------------------------------------------------------------------- %%
%% Beginning with the 2026 LaTeX heading implementation, \DocumentMetadata
%% changes \chapter and \chapter* so that they use heading-template instances.
%% In that situation, redefining only \@makechapterhead and
%% \@makeschapterhead no longer changes the visible headings. We therefore
%% provide both implementations:
%%
%%   1. template instances for current accessible builds; and
%%   2. the traditional book-class drivers for builds without \DocumentMetadata.
%%
%% In both cases, the public \chapter and \chapter* commands remain responsible
%% for page breaks, bookmarks, counters, table-of-contents entries, running
%% marks, and semantic heading tags. Do not call \@makeschapterhead directly.

\newlength{\ncsu@afterschapbeforeleadingsep}

\@ifundefined{ParseLaTeXeHeading}{%
  %% ------------------------------------------------------------------------ %%
  %% Traditional LaTeX heading implementation
  %% ------------------------------------------------------------------------ %%
  \ClassInfo{ncsuthesis}{Using traditional chapter-heading drivers}%

  %% Numbered chapters.
  \renewcommand{\@makechapterhead}[1]{%
    \vspace*{1.25\baselineskip}%
    {%
      \parindent\z@
      \raggedright
      \normalfont
      {\Large\bfseries Chapter \thechapter\par}%
      \vspace{0.75\baselineskip}%
      {\Large\bfseries #1\par}%
      \vspace{1.75\baselineskip}%
    }%
  }

  %% Unnumbered chapters and preliminary-page headings.
  \renewcommand{\@makeschapterhead}[1]{%
    \setlength{\ncsu@leading}{\baselineskip-\ncsu@capitalheight}%
    \setlength{\ncsu@afterschapbeforeleadingsep}{%
      \ncsu@afterschapsep-\ncsu@leading
    }%
    {%
      \noindent
      \centering
      {\ncsu@headingformat #1}%
      \par\nobreak
      \vspace{\ncsu@afterschapbeforeleadingsep}%
    }%
  }
}{%
  %% ------------------------------------------------------------------------ %%
  %% LaTeX 2026 heading-template implementation used with \DocumentMetadata
  %% ------------------------------------------------------------------------ %%
  \ClassInfo{ncsuthesis}{Using tagged-PDF chapter-heading templates}%

  %% The numbered chapter format places the chapter label and title on
  %% separate lines, matching the traditional class definition above.
  \DeclareInstance{headformat}{ncsu-chapter}{display}{%
    heading-indent   = 0pt,
    prefix-number-sep = \WordSpaceAmount{1},
    number-title-sep = 0.75\baselineskip,
    title-format     = {#1}%
  }

  \DeclareInstance{heading}{ncsu-chapter}{display}{%
    name                  = chapter,
    level                 = 0,
    placement             = top,
    para-indent           = false,
    after-penalty-vspace  = 1.25\baselineskip,
    after-vspace          = 1.75\baselineskip,
    prefix                = \@chapapp,
    number-format         = \thechapter,
    heading-decls         = \raggedright\parindent\z@\normalfont\Large\bfseries,
    title-decls           = \Large,
    headformat-instance   = ncsu-chapter,
    mark-cmd              = \chaptermark{#1},
    contents-extra        = {%
      \addtocontents{lof}{\protect\addvspace{10\p@}}%
      \addtocontents{lot}{\protect\addvspace{10\p@}}%
    }%
  }

  %% Preliminary headings use a separate instance because they must be
  %% centered, uppercase, unnumbered, and body-text sized.
  \DeclareInstance{headformat}{ncsu-chapter-star}{display}{%
    heading-indent    = 0pt,
    prefix-number-sep = 0pt,
    number-title-sep  = 0pt,
    title-format      = {\ncsu@headingformat{#1}}%
  }

  \DeclareInstance{heading}{ncsu-chapter-star}{display}{%
    name                 = chapter,
    level                = 0,
    placement            = top,
    para-indent          = false,
    after-penalty-vspace = 0pt,
    after-vspace         = \ncsu@afterschapsep,
    heading-decls        = \centering\parindent\z@\normalfont,
    headformat-instance  = ncsu-chapter-star,
    mark-cmd             = \chaptermark{#1}%
  }

  %% Route numbered and unnumbered chapters through the appropriate instances.
  %% The frontmatter logic mirrors the current book-class implementation: an
  %% ordinary \chapter in front matter is unnumbered but may still create the
  %% expected TOC entry, bookmark, and running mark.
  \DeclareDocumentCommand\chapter{s ={shorttitle}o m}{%
    \if@mainmatter
      \IfBooleanTF{#1}{%
        \ParseLaTeXeHeading{ncsu-chapter-star}{#1}{#2}{#3}%
      }{%
        \ParseLaTeXeHeading{ncsu-chapter}{#1}{#2}{#3}%
      }%
    \else
      \IfBooleanTF{#1}{%
        \ParseLaTeXeHeading{ncsu-chapter-star}{\BooleanTrue}{#2}{#3}%
      }{%
        \IfNoValueTF{#2}{%
          \ParseLaTeXeHeading{ncsu-chapter-star}{\BooleanTrue}%
            {shorttitle={#3}}{#3}%
        }{%
          \ParseLaTeXeHeading{ncsu-chapter-star}{\BooleanTrue}{#2}{#3}%
        }%
      }%
    \fi
  }
}


%% -------------------------------------------------------------------------- %%
%% Abstract page commands
%%  - hyphnat package \nohyphens prevents title from being hyphenated.
%%  - \nolbreaks removes any line breaks in title (but you must use \linebreak
%%     instead of \\
\newcommand{\abstractname}{Abstract}
\newenvironment{abstract}{%
   \singlespacing
   \titlepage
   \chapter*{\abstractname}
   \noindent
   \MakeUppercase{\ncsu@authorlast{}, \ncsu@authorfirstmiddle{}}%
   \ifthenelse{\boolean{@ncsu@needsperiod}}{\@. }{~}%
    \nohyphens{\nolbreaks{\ncsu@thesistitle}.
   (Under the direction of
   \ifthenelse{\equal{\ncsu@chairtype}{chair}}%
              {\ncsu@chair}{\ncsu@cochairI\ and \ncsu@cochairII}).}\\

   \ncsu@defaultspacing
   \thispagestyle{empty}
   \pagestyle{empty}
}%
{\endtitlepage \pagestyle{plain}}

%% -------------------------------------------------------------------------- %%
%% Abstract page commands
\newcommand{\makecopyrightpage}{
    \begin{titlepage}
    \vspace*{\fill}
    \begin{center}
        \copyright{} Copyright \ncsu@year{} by \@author \\[1em]
        All Rights Reserved
    \end{center}
    \vspace*{\fill}
    \end{titlepage}
}

%% -------------------------------------------------------------------------- %%
%% Title page commands

\newcommand{\ncsu@committeesize}{4}
\providecommand{\committeesize}[1]{\renewcommand{\ncsu@committeesize}{#1}}

%% To allow for Chair vs Co-chairs:
\newcommand{\ncsu@chairtype}{}

%% For each committee member, we have their name and title.
%%  By default, their title is empty.  We use an optional argument
%%  to set the title of committee members or to set the chair's
%%  title to something other than `Chair of Advisory Committee'.
\newcommand{\ncsu@chair}{Advisor Q. Chair}
\newcommand{\ncsu@chairtitle}{Chair of Advisory Committee}
\providecommand{\chair}[2][]{
    \renewcommand{\ncsu@chair}{#2}
    % Checking if optional title argument is present.
    \ifthenelse{\equal{#1}{}}{}{\renewcommand{\ncsu@chairtitle}{#1}}
    % Declare that we have a chair:
    \renewcommand{\ncsu@chairtype}{chair}
}

\newcommand{\ncsu@cochairI}{Co-chair 1 of Committee}
\newcommand{\ncsu@cochairItitle}{Co-chair of Advisory Committee}
\providecommand{\cochairI}[2][]{
    \renewcommand{\ncsu@cochairI}{#2}
    \ifthenelse{\equal{#1}{}}{}{\renewcommand{\ncsu@cochairItitle}{#1}}
    % Declare that we have co-chairs.
    \renewcommand{\ncsu@chairtype}{cochair}
}

\newcommand{\ncsu@cochairII}{Co-chair 2 of Committee}
\newcommand{\ncsu@cochairIItitle}{Co-chair of Advisory Committee}
\providecommand{\cochairII}[2][]{
    \renewcommand{\ncsu@cochairII}{#2}
    \ifthenelse{\equal{#1}{}}{}{\renewcommand{\ncsu@cochairIItitle}{#1}}
    \renewcommand{\ncsu@chairtype}{cochair}
}

\newcommand{\ncsu@memberI}{Member 1 of Committee}
\newcommand{\ncsu@memberItitle}{}
\providecommand{\memberI}[2][]{
    \renewcommand{\ncsu@memberI}{#2}
    \ifthenelse{\equal{#1}{}}{}{\renewcommand{\ncsu@memberItitle}{#1}}
}

\newcommand{\ncsu@memberII}{Member 2 of Committee}
\newcommand{\ncsu@memberIItitle}{}
\providecommand{\memberII}[2][]{
    \renewcommand{\ncsu@memberII}{#2}
    \ifthenelse{\equal{#1}{}}{}{\renewcommand{\ncsu@memberIItitle}{#1}}
}

\newcommand{\ncsu@memberIII}{Member 3 of Committee}
\newcommand{\ncsu@memberIIItitle}{}
\providecommand{\memberIII}[2][]{
    \renewcommand{\ncsu@memberIII}{#2}
    \ifthenelse{\equal{#1}{}}{}{\renewcommand{\ncsu@memberIIItitle}{#1}}
}

\newcommand{\ncsu@memberIV}{Member 4 of Committee}
\newcommand{\ncsu@memberIVtitle}{}
\providecommand{\memberIV}[2][]{
    \renewcommand{\ncsu@memberIV}{#2}
    \ifthenelse{\equal{#1}{}}{}{\renewcommand{\ncsu@memberIVtitle}{#1}}
}

\newcommand{\ncsu@memberV}{Member 5 of Committee}
\newcommand{\ncsu@memberVtitle}{}
\providecommand{\memberV}[2][]{
    \renewcommand{\ncsu@memberV}{#2}
    \ifthenelse{\equal{#1}{}}{}{\renewcommand{\ncsu@memberVtitle}{#1}}
}

\newcommand{\ncsu@titlepageparagraph}{
 \ifthenelse{\equal{\ncsu@thesistype}{phd}}{
   A dissertation submitted to the Graduate Faculty of\\
   North Carolina State University\\
   in partial fulfillment of the\\
   requirements for the degree of\\
   Doctor of Philosophy
 }{} % end ifthenels phd
 \ifthenelse{\equal{\ncsu@thesistype}{ms}}{
   A thesis submitted to the Graduate Faculty of\\
   North Carolina State University\\
   in partial fulfillment of the\\
   requirements for the degree of\\
   Master of Science
 }{} % end ifthenels phd
}

\newcommand{\ncsu@program}{Degree Program}
\providecommand{\program}[1]{\renewcommand{\ncsu@program}{#1}}

\newcommand{\ncsu@citystate}{Raleigh, North Carolina}

\newcommand{\ncsu@signatureline}[2][]{
    \begin{minipage}[t]{0.4\textwidth}
    \centering
     \hrule
     \vspace{0.5ex}
     #2\\ #1
    \end{minipage}
}

\newcommand{\ncsu@committeesignatures}{
  \ifthenelse{\equal{\ncsu@chairtype}{chair}}{
    \ifthenelse{\ncsu@committeesize=3}{
      \begin{tabular}[t]{c@{\hspace{0.5in}}c}
         \ncsu@signatureline[\ncsu@memberItitle]{\ncsu@memberI} &
         \ncsu@signatureline[\ncsu@memberIItitle]{\ncsu@memberII} \\[6em]
         \multicolumn{2}{c}{\ncsu@signatureline[\ncsu@chairtitle]{\ncsu@chair}}
      \end{tabular}
    }{} % end ifthenelse = 3
    \ifthenelse{\ncsu@committeesize=4}{
      \begin{tabular}[t]{c@{\hspace{0.5in}}c}
         \ncsu@signatureline[\ncsu@memberItitle]{\ncsu@memberI} &
         \ncsu@signatureline[\ncsu@memberIItitle]{\ncsu@memberII} \\[6em]
         \ncsu@signatureline[\ncsu@memberIIItitle]{\ncsu@memberIII} &
         \ncsu@signatureline[\ncsu@chairtitle]{\ncsu@chair} \\
      \end{tabular}
    }{} % end ifthenelse = 4
    \ifthenelse{\ncsu@committeesize=5}{
      \begin{tabular}[t]{c@{\hspace{0.5in}}c}
         \ncsu@signatureline[\ncsu@memberItitle]{\ncsu@memberI} &
         \ncsu@signatureline[\ncsu@memberIItitle]{\ncsu@memberII} \\[5em]
         \ncsu@signatureline[\ncsu@memberIIItitle]{\ncsu@memberIII} &
         \ncsu@signatureline[\ncsu@memberIVtitle]{\ncsu@memberIV} \\[5em]
         \multicolumn{2}{c}{\ncsu@signatureline[\ncsu@chairtitle]{\ncsu@chair}}
      \end{tabular}
    }{} % end ifthenelse = 5
    \ifthenelse{\ncsu@committeesize=6}{
      \begin{tabular}[t]{c@{\hspace{0.5in}}c}
         \ncsu@signatureline[\ncsu@memberItitle]{\ncsu@memberI} &
         \ncsu@signatureline[\ncsu@memberIItitle]{\ncsu@memberII} \\[5em]
         \ncsu@signatureline[\ncsu@memberIIItitle]{\ncsu@memberIII} &
         \ncsu@signatureline[\ncsu@memberIVtitle]{\ncsu@memberIV} \\[5em]
         \ncsu@signatureline[\ncsu@memberVtitle]{\ncsu@memberV} &
         \ncsu@signatureline[\ncsu@chairtitle]{\ncsu@chair} \\
      \end{tabular}
    }{} % end ifthenelse = 6
  }{} % end ifthenelse type = chair
  \ifthenelse{\equal{\ncsu@chairtype}{cochair}}{
    % co-chairs; if number is odd, put co-chairs on top line.
    \ifthenelse{\ncsu@committeesize=3}{
      \begin{tabular}[t]{c@{\hspace{0.5in}}c}
         \ncsu@signatureline[\ncsu@cochairItitle]{\ncsu@cochairI} &
         \ncsu@signatureline[\ncsu@cochairIItitle]{\ncsu@cochairII} \\[6em]
         \multicolumn{2}{c}%
           {\ncsu@signatureline[\ncsu@memberItitle]{\ncsu@memberI}}
      \end{tabular}
    }{} % end ifthenelse = 3
    \ifthenelse{\ncsu@committeesize=4}{
      \begin{tabular}[t]{c@{\hspace{0.5in}}c}
         \ncsu@signatureline[\ncsu@memberItitle]{\ncsu@memberI} &
         \ncsu@signatureline[\ncsu@memberIItitle]{\ncsu@memberII} \\[6em]
         \ncsu@signatureline[\ncsu@cochairItitle]{\ncsu@cochairI} &
         \ncsu@signatureline[\ncsu@cochairIItitle]{\ncsu@cochairII}
      \end{tabular}
    }{} % end ifthenelse = 4
    \ifthenelse{\ncsu@committeesize=5}{
      \begin{tabular}[t]{c@{\hspace{0.5in}}c}
         \ncsu@signatureline[\ncsu@cochairItitle]{\ncsu@cochairI} &
         \ncsu@signatureline[\ncsu@cochairIItitle]{\ncsu@cochairII} \\[5em]
         \ncsu@signatureline[\ncsu@memberItitle]{\ncsu@memberI} &
         \ncsu@signatureline[\ncsu@memberIItitle]{\ncsu@memberII} \\[5em]
         \multicolumn{2}{c}%
           {\ncsu@signatureline[\ncsu@memberIIItitle]{\ncsu@memberIII}}
      \end{tabular}
    }{} % end ifthenelse = 5
    \ifthenelse{\ncsu@committeesize=6}{
      \begin{tabular}[t]{c@{\hspace{0.5in}}c}
         \ncsu@signatureline[\ncsu@memberItitle]{\ncsu@memberI} &
         \ncsu@signatureline[\ncsu@memberIItitle]{\ncsu@memberII} \\[5em]
         \ncsu@signatureline[\ncsu@memberIIItitle]{\ncsu@memberIII} &
         \ncsu@signatureline[\ncsu@memberIVtitle]{\ncsu@memberIV} \\[5em]
         \ncsu@signatureline[\ncsu@cochairItitle]{\ncsu@cochairI} &
         \ncsu@signatureline[\ncsu@cochairIItitle]{\ncsu@cochairII} \\
      \end{tabular}
    }{} % end ifthenelse = 6
  }{} % end ifthenelse type = cochair
}

\newcommand{\maketitlepage}{
     \thispagestyle{empty}
     \clearpage
     \singlespacing
      \begin{center}
            \vfill
        \ncsu@thesistitle
            \vfill
        by \\
        \@author
            \vfill
       \ncsu@titlepageparagraph
           \vfill
       \ncsu@program\\[4\ncsu@lineheight]
       \ncsu@citystate\\[0\ncsu@lineheight]
       \ncsu@year
           \vfill
       APPROVED BY:
           \vfill
       \ncsu@committeesignatures
      \end{center}
     \clearpage
     \ncsu@defaultspacing
}

%% -------------------------------------------------------------------------- %%
%% ------------ Dedication, biography, and acknowledgements ----------------- %%
%% -------------------------------------------------------------------------- %%
%%  Template
\newcommand{\ncsu@dedbioack}[1]{%
    \chapter*{#1}%
}

%%  Dedication
\newcommand{\dedicationtitle}{Dedication}
\newenvironment{dedication}
{\ncsu@dedbioack{\dedicationtitle}}
{\clearpage}

%%  Biography
\newcommand{\biographytitle}{Biography}
\newenvironment{biography}
{\ncsu@dedbioack{\biographytitle}}
{\clearpage}

%%  Acknowledgements
\newcommand{\acknowledgementstitle}{Acknowledgements}
\newenvironment{acknowledgements}
{\ncsu@dedbioack{\acknowledgementstitle}}
{\clearpage}

%% -------------------------------------------------------------------------- %%
%% -------------------------  Table of Contents ----------------------------- %%
%% -------------------------------------------------------------------------- %%
%% This accessible version intentionally avoids tocloft. In tagged PDF builds,
%% tocloft can interfere with hyperlinks in the table of contents, list of
%% tables, and list of figures. The simpler definitions below preserve ordinary
%% hyperref links.

\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\listfigurename}{List of Figures}
\renewcommand{\listtablename}{List of Tables}

%% Compatibility stubs for stale .toc files created by the older tocloft-based
%% version of this class. A clean build removes these old commands from the .toc,
%% but these definitions prevent one confusing compile error if the user forgets
%% to clean auxiliary files after replacing the class file.
\providecommand{\cftchappresnum}{}
\providecommand{\cftchapnumwidth}{}
\providecommand{\cftchapfont}{}
\providecommand{\cftsecfont}{}
\providecommand{\cftchappagefont}{}
\newlength{\cftbeforechapskip}
\newlength{\cftbeforesecskip}
\newlength{\cftchapindent}
\newlength{\cftsecindent}
\newlength{\cftsubsecindent}
\newlength{\cftsecnumwidth}

\newif\ifncsu@tocappendix
\ncsu@tocappendixfalse

\newcommand{\ncsu@withchapternumberline}[1]{%
  \begingroup
  \let\numberline\ncsu@chapternumberline
  #1%
  \endgroup
}

\newcommand{\ncsu@chapternumberline}[1]{%
  \ifncsu@tocappendix
    \hb@xt@6.5em{Appendix~#1\hfil}%
  \else
    \hb@xt@6.5em{Chapter~#1\hfil}%
  \fi
}

\newcommand{\ncsu@withfigurenumberline}[1]{%
  \begingroup
  \let\numberline\ncsu@figurenumberline
  #1%
  \endgroup
}

\newcommand{\ncsu@figurenumberline}[1]{%
  \hb@xt@6.5em{Figure~#1\hfil}%
}

\newcommand{\ncsu@withtablenumberline}[1]{%
  \begingroup
  \let\numberline\ncsu@tablenumberline
  #1%
  \endgroup
}

\newcommand{\ncsu@tablenumberline}[1]{%
  \hb@xt@6.5em{Table~#1\hfil}%
}

\renewcommand*{\l@chapter}[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{6.5em}%
    \begingroup
      \parindent \z@
      \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      \ncsu@withchapternumberline{#1}%
      \nobreak\leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
      \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi
}

\renewcommand*{\l@figure}[2]{%
  \@dottedtocline{1}{0em}{6.5em}{\ncsu@withfigurenumberline{#1}}{#2}%
}

\renewcommand*{\l@table}[2]{%
  \@dottedtocline{1}{0em}{6.5em}{\ncsu@withtablenumberline{#1}}{#2}%
}

\newcommand{\thesistableofcontents}{%
    \singlespacing%
    \tableofcontents%
    \clearpage%
    \ncsu@defaultspacing%
}

\newcommand{\thesislistoffigures}{%
    \singlespacing%
    \listoffigures%
    \clearpage%
    \ncsu@defaultspacing%
}

\newcommand{\thesislistoftables}{%
    \singlespacing%
    \listoftables%
    \clearpage%
    \ncsu@defaultspacing%
}

%% -------------------------------------------------------------------------- %%
%% ------------------------- Landscape Pages  ------------------------------- %%
%% -------------------------------------------------------------------------- %%
%%  Loading pdflscape package for page rotation
\RequirePackage{pdflscape}
%% Load fancyhdr to support landscape-page numbering.
\RequirePackage{fancyhdr}
%%  Loading sideways for sideways environment
\RequirePackage{rotating}

\newlength{\portraittextheight}
\setlength{\portraittextheight}{\textheight}
\addtolength{\portraittextheight}{\footskip}
\newlength{\portraittextwidth}
\setlength{\portraittextwidth}{\textwidth}

\RequirePackage{afterpage}
\RequirePackage{changepage}

%% Rotate page and page number
\newenvironment{lscapenum}
{
%%   The standard landscape environment does not rotate the margins and
%%   page number.  However, we want the margins (mostly) rotated as well
%%   as the page number.  To change the margins, we use the \changepage
%%   command from the \changepage package.  Since the \textheight and
%%   \textwidth dimensions get switched, we need to reduce the rotated
%%   \textheight by \ncsu@footskip and increase the \textwidth by the
%%   same measure.
%%
%%   The syntax of the \changepage command is
%% \changepage{textheight}{textwidth}{evensidemargin}{oddsidemargin}{columnsep}
%%            {topmargin}{headheight}{headsep}{footskip}
   \clearpage
   \changepage{\ncsu@footskip}{-\ncsu@footskip}{}{}{}{}{}{}{}
   \begin{landscape}
     \pagestyle{fancy}
     \fancyhead{} % clear all header fields
     \fancyfoot{} % clear all footer fields
     \renewcommand{\headrulewidth}{0pt}
     \rfoot{
       %% Since the header and footer are unrotated, we must manually
       %% place the page number.  The picture environment is included in
       %% standard LaTeX.
       \setlength{\unitlength}{\portraittextheight}
       \begin{picture}(0,0)
           \put(0.055,0.557){\begin{sideways}\thepage\end{sideways}} % page number
       \end{picture}
     }

}
{
   \end{landscape}
   %% The \textheight is too large leaving landscape environment
   %%  since we invoked the \changepage.  We manually reduce it.
   \addtolength{\textheight}{-\ncsu@footskip}

   %% \textheight controls 3 other variables, which must be updated.
   %% See \endlandscape definition in lscape.sty
   \global\@colht=\textheight
   \global\vsize=\textheight
   \global\@colroom=\textheight

   \pagestyle{plain}
}

%% Rotate page but NOT page number
\newenvironment{lscapenotnum}
{
   \begin{landscape}
}
{
   \end{landscape}
}

%% -------------------------------------------------------------------------- %%
%% ---------------------------  Captions      ------------------------------- %%
%% -------------------------------------------------------------------------- %%
%%  Adding space to start of caption
%%   save
\RequirePackage{caption}
\DeclareCaptionLabelSeparator{colon}{:\hspace{0.8em}}

%% -------------------------------------------------------------------------- %%
%% -------------------------  References ------------------------------------ %%
%% -------------------------------------------------------------------------- %%
\renewcommand{\bibname}{References}
%% natbib redefines \thebibliography, so we add our own requirements
%% at \begin{document} time.
\AtBeginDocument{
    \let\ncsu@thebibliography\thebibliography
    \let\endncsu@thebibliography\endthebibliography
    \renewenvironment{thebibliography}[1]
    {
        \singlespacing
        \begin{ncsu@thebibliography}{#1}
    }
    {
        \end{ncsu@thebibliography}
        \ncsu@defaultspacing
    }
}




%% -------------------------------------------------------------------------- %%
%% ------------------------- The Appendices  -------------------------------- %%
%% -------------------------------------------------------------------------- %%

\newlength{\appendixwidth}
\settowidth{\appendixwidth}{APPENDIX A}
\addtolength{\appendixwidth}{1em}
\providecommand{\appendixheader}[1]{
    \renewcommand{\ncsu@appendixheader}{#1}
}

%% Count the total number of appendices
\RequirePackage{totcount}
\regtotcounter{chapter} % chapter counter is used for appendices

\AtBeginDocument{%
%% Since ETD requirements are different than LaTeX's normal formatting of
%% the Table of Content's Appendix listings,
%% we change the indentation of chapters, sections, and subsections in
%% the appendix part of the table of contents, but no deeper divisions,
%% so we must cap the tocdepth at 2:
\newcounter{ncsu@appendixtocdepth}
\ifthenelse{\c@tocdepth > 2}
{\setcounter{ncsu@appendixtocdepth}{2}}
{\setcounter{ncsu@appendixtocdepth}{\c@tocdepth}}

\let\ncsu@appendix\appendix
\renewcommand{\appendix}{
    \ifthenelse{\isundefined{\ncsu@appendixheader}}
    % Appendix title page heading not defined, define it
    {
        \ifthenelse{\totvalue{chapter} = 1 }%
        %% number of appendices = 1
        {\newcommand{\ncsu@appendixheader}{APPENDIX}}
        %% number of appendices > 1
        {\newcommand{\ncsu@appendixheader}{APPENDICES}}
    }
    % Appendix title page heading already defined, do nothing
    {}

    \chapter*{\ncsu@appendixheader} %% insert 'Appendix' titlepage
    \addcontentsline{toc}{chapter}{\ncsu@appendixheader}
    %% Tell the table of contents that following numbered chapters are appendices.
    %% This replaces the older tocloft-based appendix TOC formatting.
    \addtocontents{toc}{%
        \protect\ncsu@tocappendixtrue
        \protect\setcounter{tocdepth}{\c@ncsu@appendixtocdepth}%
    }
    \clearpage
    \ncsu@appendix %% call internal \appendix macro
} % \renewcommand{appendix}
} % \AtBeginDocument

\ncsu@defaultspacing
%% 
%% Copyright (C) 2009-2012 by Josh Hykes <jmhykes@ncsu.edu> and others
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License (LPPL), either
%% version 1.3c of this license or (at your option) any later
%% version.  The latest version of this license is in the file:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% This work is "maintained" (as per LPPL maintenance status).
%% 
%% This work consists of the file  ncsuthesis.dtx
%% and the derived files           ncsuthesis.ins,
%%                                 ncsuthesis.pdf and
%%                                 ncsuthesis.cls.
%% 
%%
%% End of file `ncsuthesis.cls'.
