#!/usr/bin/perl -w

print "\\begin{tikzpicture}[>=latex,line join=bevel,scale=.6]\n";
while(<>) {
    chomp();
    if(/\\$/) {
        chop();
        $_.=<>;
        chomp();
    }
    if(/^\s*(\d+) \[(shape=doublecircle, )?pos="([^,]+),([^"]+)"/) {
        if($2) {
            print "\\draw ($3bp,$4bp) ellipse (22bp and 22bp);\n";
            print "\\draw ($3bp,$4bp) ellipse (18bp and 18bp);\n";
        } else {
            print "\\draw ($3bp,$4bp) ellipse (18bp and 18bp);\n";
        }
        print "\\draw ($3bp,$4bp) node {$1};\n";
    }
    if(/^\s*(\d+) -> (\d+) \[label2="?(.*?)"?,.*pos="e,([^"]+)", lp="([^,]+),([^"]+)"/) {
        my @spline = split(/[\s,]+/, $4);
        print "\\draw [->] ";
        for($i = 2; $i < scalar(@spline) - 2; $i+=6) {
            print "(".$spline[$i + 0]."bp,".$spline[$i + 1]."bp) .. controls (".$spline[$i + 2]."bp,".$spline[$i + 3]."bp) and (".$spline[$i + 4]."bp,".$spline[$i + 5]."bp) .. ";
        }
        print "(".$spline[0]."bp,".$spline[1]."bp);\n";
        print "\\draw ($5bp,$6bp) node {$3};\n"
    }
}
print "\\end{tikzpicture}\n";
