= Background <background>

Typst @typst is a markup-based typesetting system, like LaTeX, but with a simpler syntax and faster compilation.
A document is plain text: headings, lists and emphasis are written with a short markup, and everything else is a function call.

== Set and show rules

Set rules change the default parameters of an element, for example the size of the text or the margins of the pages.
Show rules replace how an element looks, for example to write chapter titles in capitals.
A template is a function that applies these rules to the whole document.

#lorem(40)
