Simple FSM drawing package for latex
====================================

Benoit Favre <benoit.favre@lif.univ-mrs.fr> (c) 2012

Requirements
------------

- the tikz latex package
- dot from graphviz
- fsm2dot.pl and dot2tikz.pl in the compilation directory

Usage
-----

Include the fsm package, and then enclose textual automata definitions in the fsm environment.

    \usepackage{fsm}

    \begin{fsm}
    0   1   A
    1   2   B
    2
    \end{fsm}

Each line of the automaton is an edge definition, with the two 1st columns
being the start and end state (numbers), and then a label as free text which
can even include latex commands.

If a state is the only token on a line, it's treated as a final state.

The difference with the fsm text format from AT&T is that only unweighted
acceptors can be defined. The input, output and weight can be encoded in the
label.

Compilation
-----------

You have to pass the --shell-escape option to latex so that it can execute
shell commands.

    pdflatex --shell-escape example.tex

This generates two temporary files: example.fsm and example.tikz

