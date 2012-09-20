#!/usr/bin/perl -w

print "digraph fsm {\n";
print "graph [margin=\"0,0\"];\n";
print "node [shape = circle];\n";
print "rankdir=LR;\n";

@final = ();
while(<>) {
    chomp();
    if(/^\s*(\S+)\s+(\S+)\s+(.*)$/) {
        print "$1 -> $2 [label=\"$3\"];\n";
    } elsif(/^\s*(\S+)\s*$/) {
        push @final, $1;
    }
}

for $i(@final) {
    print "$i [shape=doublecircle];\n";
}
print "}\n";
