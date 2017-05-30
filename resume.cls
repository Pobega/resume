% -- Encoding UTF-8 without BOM

\ProvidesClass{resume}
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}
\ProcessOptions\relax

% 8.5x11 paper size for our 1 page resume
\usepackage[papersize={8.5in,11in}]{geometry}

% FancyHDR is used for custom footer text
\usepackage{fancyhdr}
\pagestyle{fancy}

% Forces the footer further down, so it's not overlapping text
\setlength{\footskip}{120pt}

% --- Shortcuts --- %
\newcommand{\br}{\vspace{\baselineskip}} % lineskip

% --- Colors --- %
% The colors we'll use throughout the document
\RequirePackage{xcolor} % Load before pagecolor

% This throws some warnings, but seems to work?
\usepackage[pagecolor=white]{pagecolor}

\definecolor{white}{RGB}{255,255,255}
\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{lightgray}{HTML}{999999}
\definecolor{kewlpurple}{HTML}{534E6C}

\colorlet{fillheader}{kewlpurple} % best shade of purple
\colorlet{header}{white}
\colorlet{textcolor}{gray} % lightens up the text just a bit
\colorlet{headercolor}{gray} % headers should be lighter than job titles

% --- Fonts --- %
\RequirePackage[quiet]{fontspec}

% Roboto Regular doesn't come with a bold/italic face, so we have to specify each face manually
\newfontfamily\bodyfont{Roboto-Regular}[Path=fonts/]
\newfontfamily\bodyfontitalics{Roboto-Italic}[Path=fonts/]
\newfontfamily\bodyfontbold{Roboto-Bold}[Path=fonts/]
\newfontfamily\bodyfontit{Roboto-LightItalic}[Path=fonts/]
\newfontfamily\thinfont{Roboto-Thin}[Path=fonts/]
\newfontfamily\headingfont{RobotoCondensed-Bold}[Path=fonts/]

\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Mapping=tex-text, Color=textcolor, Path = fonts/]{Roboto-Light}

\newcommand{\italica}[1]{%
    {\color{gray}\bodyfontit #1}%
}

% --- Header --- %
\RequirePackage{tikz}

\newcommand{\header}[3]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=4cm] (box) at (current page.north){};
    \node [anchor=center] (name) at (box) {%
      \fontsize{40pt}{72pt}\color{header}%
      {\thinfont #1}{\bodyfont  #2}
    };
    \node [anchor=north] at (name.south) {%
      \fontsize{14pt}{24pt}\color{header}%
      \thinfont #3%
    };
  \end{tikzpicture}
  \vspace{2.5cm}
  \vspace{-2\parskip}
}

% --- Footer --- %

\newcommand{\footer}[1]{%
  \fancyfoot[C]{#1}
}

% --- Aside --- %
\RequirePackage[absolute,overlay]{textpos}

\setlength{\TPHorizModule}{1cm}
\setlength{\TPHorizModule}{\paperwidth}
\setlength{\TPVertModule}{1cm}

\newenvironment{aside}{%
  \let\oldsection\section
  \renewcommand{\section}[1]{
    \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}
  }
  \begin{textblock}{0.22}(0, 4)
  \begin{flushright}
  \obeycr
}{%
  \restorecr
  \end{flushright}
  \end{textblock}
  \let\section\oldsection
}

% --- Body --- %
\RequirePackage{parskip}

\newenvironment{main}{%
  \let\oldsection\section
  \renewcommand{\section}[1]{
    \par\vspace{\baselineskip}
    {\Large\headingfont\color{headercolor} ##1}
  }
  \begin{textblock}{0.70}(0.26, 4)
  \begin{flushleft}
  \obeycr
}{%
  \restorecr
  \end{flushleft}
  \end{textblock}
  \let\section\oldsection
}

% --- Experience --- %
\newcommand{\experience}[4]{%
  \vspace{3mm}
  \begin{minipage}[t]{7cm}
    \flushleft
    {\Large\headingfont #1}

    {\large\bodyfontbold\textsc{\MakeLowercase{#3}}}
  \end{minipage}
  \hfill
  \begin{minipage}[t]{7cm}
    \flushright
    {\large\textsc{\MakeLowercase{#2}}}

    {\large\textsc{\MakeLowercase{#4}}}
  \end{minipage}
  \vspace{2mm}
  ~
}

% --- Bullet points --- %
% Due to some oddities with the minipage used to format
% job titles, \begin{itemize} can't be used.
\newcommand{\point}[1]{%
  \quad \textbullet \space #1
}
\newcommand{\subpoint}[1]{%
  \qquad {\bodyfontbold \textperiodcentered} \space #1
}