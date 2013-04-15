% vim:ft=tex:ts=2:sw=2
%
% Sun Yat-sen University dissertation document class
%
% Copyright (c) 2008-2009 solvethis
% Copyright (c) 2010-2012 Casper Ti. Vector
% Copyright (c) 2013 Bo Zhi
%
% This work may be distributed and/or modified under the conditions of the
% LaTeX Project Public License, either version 1.3 of this license or (at
% your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX version
% 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% The current maintainer of this work is Bo Zhi.
%
% This work consists of the following files:
%   sysuthesis.cls
%   sysuthesis-gbk.def
%   sysuthesis-utf8.def
%   sysuthesis-extra.sty

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{sysuthesis}
	[2013/01/10 v0.1.0 Sun Yat-sen University dissertation document class]

% Process the encoding options.
\newif\ifsysuthesis@opt@gbk \sysuthesis@opt@gbktrue
\DeclareOption{GBK}{\sysuthesis@opt@gbktrue\PassOptionsToClass{GBK}{ctexbook}}
\DeclareOption{UTF8}%
	{\sysuthesis@opt@gbkfalse\PassOptionsToClass{UTF8}{ctexbook}}
% Whether to enable the default extra settings.
\newif\ifsysuthesis@opt@extra \sysuthesis@opt@extratrue
\DeclareOption{extra}{\sysuthesis@opt@extratrue}
\DeclareOption{noextra}{\sysuthesis@opt@extrafalse}
% eg. `\sysuthesis@int@extraopt{spacing}' will expand to:
%   \DeclareOption{spacing}{\PassOptionsToClass{spacing}{sysuthesis-extra}}
%   \DeclareOption{nospacing}{\PassOptionsToClass{nospacing}{sysuthesis-extra}}
\def\sysuthesis@int@extraopt#1{
	\DeclareOption{#1}{\PassOptionsToClass{#1}{sysuthesis-extra}}
	\DeclareOption{no#1}{\PassOptionsToClass{no#1}{sysuthesis-extra}}
}
% Pass options to `sysuthesis-extra'.
% See sysuthesis-extra.sty for an explanation of the options.
\sysuthesis@int@extraopt{spacing}
\sysuthesis@int@extraopt{tightlist}
\sysuthesis@int@extraopt{pdftoc}
\sysuthesis@int@extraopt{uppermark}
\sysuthesis@int@extraopt{spechap}
\sysuthesis@int@extraopt{pdfprop}
\sysuthesis@int@extraopt{colorlinks}
% Pass all other options to `ctexbook' document class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
% Process all class options now.
\ProcessOptions\relax

% sysuthesis is based on ctexbook; We use A4 paper, and `xiao 4' as default font size.
% CJKfntef provides \CJKunderline used in \maketitle.
% fancyhdr provides utilities for setting headers and footers.
\LoadClass[fntef,a4paper,fancyhdr,cs4size]{ctexbook}[2009/10/20]
% Provide support for `key = val' grammar.
\RequirePackage{keyval}
% Graphics support.
\RequirePackage{graphicx}[1999/02/16]
% Provide utilities for setting page layout.
\RequirePackage{geometry}
% Provide \AtEndPreamble used later.
% To be removed by summer in 2013, see the fix of `\hypersetup' below.
\RequirePackage{etoolbox}
% Whether to enable the default extra settings.
\ifsysuthesis@opt@extra\RequirePackage{sysuthesis-extra}\fi

\ifxetex\ifsysuthesis@opt@gbk
	% No support for XeLaTeX compilation in non-unicode encoding, i.e. GBK.
	\ClassError{sysuthesis}%
		{XeLaTeX compilation is not supported without UTF-8}%
		{%
			XeLaTeX compilation without UTF-8 is very problematic.\MessageBreak
			Therefore please use UTF-8 encoding for the LaTeX code.%
		}
\fi\fi

\AtEndOfClass{
	% Setting chinese captions and labels.
	\ifsysuthesis@opt@gbk\input{sysuthesis-gbk.def}
	\else\input{sysuthesis-utf8.def}
	\fi

	% Automatically generate hyperlinks and bookmarks for table of contents,
	% citations and index.
	% Code copied with minor modifications from ctex-common.def in `ctex' package.
	% Not directly using the `hyperref' option of `ctex' package in order to avoid
	% the conflicts caused by loading of `hyperref' before `setspace' in `ctex'
	% package older than 1.02c.
	% This piece of code will be removed by summer in 2013, and we will use the
	% `hyperref' option of `ctex' package instead, considering most people
	% will be using newer versions of `ctex' package at that time.
	\providecommand\hypersetup[1]{\PassOptionsToPackage{#1}{hyperref}}
	\AtEndPreamble{\RequirePackage{hyperref}}
	\ifsysuthesis@opt@gbk
		\unless\ifxetex
			\hypersetup{CJKbookmarks}
			\unless\ifpdf
				\AtBeginDvi{\special{pdf:tounicode GBK-EUC-UCS2}}
			\fi
		\fi
	\else
		\hypersetup{unicode}
	\fi
	\hypersetup{driverfallback = dvipdfmx}
}

% Set page layout.
\geometry{height = 240mm, width = 150mm, includeheadfoot, headheight = 1.2em}
% Set headers and footers.
\pagestyle{fancy}\fancyhf{}
\fancyhead[LE]{\small\normalfont\leftmark}
\fancyhead[RO]{\small\normalfont\rightmark}
\fancyhead[LO,RE]{\small\normalfont\cuniversity\cthesisname}
\fancyfoot[RO,LE]{\small\normalfont --~\thepage~--}
% Set the headers and footers on the first page in every chapter.
\fancypagestyle{plain}{
	\fancyhf{}\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[RO,LE]{\small\normalfont --~\thepage~--}
}

% eg. `\sysuthesis@int@infoitema{ctitle}' will expand to:
%   \def\ctitle#1{\def\@ctitle{#1}}
%   \define@key{sysuthesis@info}{ctitle}{\ctitle{#1}}
\def\sysuthesis@int@infoitema#1{
	\@namedef{#1}##1{\@namedef{@#1}{##1}}
	\define@key{sysuthesis@info}{#1}{\@nameuse{#1}{##1}}
}
% eg. `\sysuthesis@int@infoitemb{cuniversity}' will expand to:
%   \define@key{sysuthesis@info}{cuniversity}{\def\cuniversity{#1}}
\def\sysuthesis@int@infoitemb#1{
	\define@key{sysuthesis@info}{#1}{\@namedef{#1}{##1}}
}
% Setting document information entries.
\sysuthesis@int@infoitema{ctitle}
\sysuthesis@int@infoitema{etitle}
\sysuthesis@int@infoitema{cauthor}
\sysuthesis@int@infoitema{eauthor}
\sysuthesis@int@infoitema{studentid}
\sysuthesis@int@infoitema{date}
\sysuthesis@int@infoitema{school}
\sysuthesis@int@infoitema{cmajor}
\sysuthesis@int@infoitema{emajor}
\sysuthesis@int@infoitema{direction}
\sysuthesis@int@infoitema{cmentor}
\sysuthesis@int@infoitema{ementor}
\sysuthesis@int@infoitema{ckeywords}
\sysuthesis@int@infoitema{ekeywords}
\sysuthesis@int@infoitemb{cuniversity}
\sysuthesis@int@infoitemb{euniversity}
\sysuthesis@int@infoitemb{cthesisname}
\sysuthesis@int@infoitemb{ethesisname}
\sysuthesis@int@infoitemb{cabstractname}
\sysuthesis@int@infoitemb{eabstractname}

% Set document information using the `key = value' grammar.
\newcommand{\sysuthesisinfo}[1]{\setkeys{sysuthesis@info}{#1}}

% Usage: \sysuthesis@int@fillinblank{(number of lines)}{(line width)}{(contents)}
\def\sysuthesis@int@fillinblank#1#2#3{
	\makebox[0pt][l]{\parbox[t]{#2}{\centering{#3}}}\mbox{}%
	\parbox[t]{#2}{%
		\newcount\sysuthesis@tmp@linecount
		\sysuthesis@tmp@linecount=#1
		\loop\ifnum\sysuthesis@tmp@linecount>0
			% Fill specified space with underline on the bottom line. `\underline'
			% draws line on the baseline (not the bottom line), and this is why
			% `\CJKunderline' is used here instead.
			\ifnum\sysuthesis@tmp@linecount=1
				\CJKunderline{\makebox[#2]{}}
			\else
				\CJKunderline{\makebox[#2]{}}\\
			\fi
		\advance\sysuthesis@tmp@linecount by -1\relax
		\repeat%
	}%
}
% Set format of the title page (cover).
\renewcommand{\maketitle}{
	\cleardoublepage
	% Add PDF bookmark for the title page.
	\pdfbookmark[1]{\titlepagename}{titlepage}
	\begin{titlepage}
        \begin{center}
            {
                \zihao{1}
                {\heiti 中山大学硕士学位论文}
                \par
                \vspace{1in}
                \zihao{-2}
                {\textbf{\songti \@ctitle}}
                \par
                \zihao{-3}
                {\textbf{\@etitle}}
                \par
            }
            \vfill
            % --Information about the author--
            {
                \linespread{1.75}\selectfont
                \def\sysuthesis@tmp@len{0.35\textwidth}
                \hspace{4em}
                \begin{tabular}{l@{\extracolsep{0.2em}}c}
                    {\label@cauthor} &
    				\sysuthesis@int@fillinblank{1}{\sysuthesis@tmp@len}{\bfseries{\@cauthor}}		\\
                    {\label@cmentora} &
    				\sysuthesis@int@fillinblank{1}{\sysuthesis@tmp@len}{\bfseries{\@cmentor}}		\\
                    {\label@cmajor} &
    				\sysuthesis@int@fillinblank{1}{\sysuthesis@tmp@len}{\bfseries{\@cmajor}}		\\
                \end{tabular}
            }
            \vfill
            % -- Information about commitees--
            {
                \linespread{1.75}\selectfont
                \def\sysuthesis@tmp@len{0.3\textwidth}
                \begin{tabular}{l@{\extracolsep{0.2em}}c}
                    {答辩委员会主席（签名）：} &
    				\sysuthesis@int@fillinblank{1}{\sysuthesis@tmp@len}{}		\\
                    {答辩委员会委员（签名）：} &
    				\sysuthesis@int@fillinblank{5}{\sysuthesis@tmp@len}{}		\\
                \end{tabular}
            }
            \vfill
            % --Date--
            {\zihao{-3}\@date}
         \end{center}
	\end{titlepage}
}

% Internal environment for typesetting abstracts.
\newenvironment{sysuthesis@int@abstract}{
	\cleardoublepage
	\pdfbookmark[1]{\sysuthesis@tmp@abstractname}{\sysuthesis@tmp@abstlabel}
    \linespread{1.75}\selectfont
    \def\sysuthesis@tmp@len{0.35\textwidth}
    \hspace{4em}
    \begin{flushleft}
        \atitle \sysuthesis@tmp@title \\
        \amajor \sysuthesis@tmp@major \\
        \aauthor \sysuthesis@tmp@author \\
        \amentor \sysuthesis@tmp@mentor \\
    \end{flushleft}
	\vspace{1em}\par
   \section*{\zihao{4}\sysuthesis@tmp@abstractname}
	\vskip 0.5em
}{% Keywords at the bottom of the page.
	\vfill\noindent\textbf{\sysuthesis@tmp@label@keywords}{\sysuthesis@tmp@keywords}
}

% Typesetting the Chinese abstract.
\newenvironment{cabstract}{
	\def\sysuthesis@tmp@abstlabel{cabstract}
	\let\sysuthesis@tmp@title\@ctitle
 	\let\sysuthesis@tmp@author\@cauthor
	\let\sysuthesis@tmp@major\@cmajor
 	\let\sysuthesis@tmp@mentor\@cmentor
 	\let\sysuthesis@tmp@keywords\@ckeywords
 	\let\sysuthesis@tmp@label@mentor\label@cmentorb
 	\let\sysuthesis@tmp@label@keywords\label@ckeywords
	\let\sysuthesis@tmp@abstractname\cabstractname
    \let\atitle\actitle
    \let\amajor\acmajor
    \let\aauthor\acauthor
    \let\amentor\acmentor
	\begin{sysuthesis@int@abstract}
}{\end{sysuthesis@int@abstract}}

% Typesetting the English abstract.
\newenvironment{eabstract}{
	\def\sysuthesis@tmp@abstlabel{eabstract}
	\let\sysuthesis@tmp@title\@etitle
 	\let\sysuthesis@tmp@author\@eauthor
	\let\sysuthesis@tmp@major\@emajor
 	\let\sysuthesis@tmp@mentor\@ementor
 	\let\sysuthesis@tmp@keywords\@ekeywords
 	\let\sysuthesis@tmp@label@mentor\label@ementor
 	\let\sysuthesis@tmp@label@keywords\label@ekeywords
	\let\sysuthesis@tmp@abstractname\eabstractname
    \let\atitle\aetitle
    \let\amajor\aemajor
    \let\aauthor\aeauthor
    \let\amentor\aementor
	\begin{sysuthesis@int@abstract}
}{\end{sysuthesis@int@abstract}}

\endinput
