#!/usr/bin/perl -w

print "\\begin{tikzpicture}[>=latex,line join=bevel,scale=.6]\n";
$text="";
while(<>) {
    chomp();
    if(/\\$/) {
        chop();
        $_.=<>;
        chomp();
    }
    $text.=$_;
}

while($text=~/(\S+)( -> (\S+))?\s*\[([^\]]*)\]/cg) {
    $start_node = $1;
    $end_node = $3;
    $options = $4;

    $start_node eq 'node' and next;
    $start_node eq 'graph' and next;

    $label = "";
    $pos = "";
    $x=0;
    $y=0;
    $is_final = 0;
    $is_node = 1;

    if(defined $end_node) {
        $is_node = 0;
    }

    if($options=~/label="([^"]*)"/) {
        $label = $1;
    }
    if($options=~/pos="e,([^"]+)"/) {
        $pos=$1;
    }
    elsif($options=~/pos="([^,]+),([^"]+)"/) {
        $x=$1;
        $y=$2;
    }
    if($options=~/lp="([^,]+),([^"]+)"/) {
        $x=$1;
        $y=$2;
    }
    if($options=~/shape=doublecircle/) {
        $is_final = 1;
    }

    if($is_node) {
        if($is_final) {
            print "\\draw (${x}bp,${y}bp) ellipse (22bp and 22bp);\n";
            print "\\draw (${x}bp,${y}bp) ellipse (18bp and 18bp);\n";
        } else {
            print "\\draw (${x}bp,${y}bp) ellipse (18bp and 18bp);\n";
        }
        print "\\draw (${x}bp,${y}bp) node {$start_node};\n";
    } else {
        my @spline = split(/[\s,]+/, $pos);
        print "\\draw [->] ";
        for($i = 2; $i < scalar(@spline) - 2; $i+=6) {
            print "(".$spline[$i + 0]."bp,".$spline[$i + 1]."bp) .. controls (".$spline[$i + 2]."bp,".$spline[$i + 3]."bp) and (".$spline[$i + 4]."bp,".$spline[$i + 5]."bp) .. ";
        }
        print "(".$spline[0]."bp,".$spline[1]."bp);\n";
        print "\\draw (${x}bp,${y}bp) node {$label};\n"
    }
}

print "\\end{tikzpicture}\n";
