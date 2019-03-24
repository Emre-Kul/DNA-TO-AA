#!/usr/bin/perl

# Created By Emre Kul

sub main {
    greatings();
    print "Reading Input from dna-input.txt...\n";
    $input = readFile("dna-input.txt");
    print "Input : $input\n";
    print "Converting DNA to RNA...\n";
    $RNA = convertToRNA($input);
    print "RNA : $RNA\n";
    print "Geting AminoAcids...\n";
    $result = getAminoAcids($RNA);
    print "RESULT : $result\n";
    print "Result Writing to output.txt\n";
    writeToFile("output.txt", $result);
}

sub greatings {
    $welcomeMsg = "----------------18/19 BioEnformation Homework-1---------------------";
    print "$welcomeMsg \n";
}

sub readFile {
    my ($fileName) = @_;
    $inputs = "";
    open(FILE, "<$fileName") or die "Couldn't open file! $fileName \n";
    while( <FILE> ) {
        $inputs = "$inputs$_";
    }
    close(FILE) or die "Couldn't close file properly! $filename \n";
    return $inputs;
}

sub convertToRNA {
    my ($DNA) = @_;
    $counterPart = "";
    foreach(split('', $DNA)) {
        if($_ eq "A" or $_ eq "a") {
            $counterPart = $counterPart . "U";
        }
        elsif($_ eq "T" or $_ eq "t") {
            $counterPart = $counterPart . "A";
        }
        elsif($_ eq "G" or $_ eq "g") {
            $counterPart = $counterPart . "C";
        }
        elsif($_ eq "C" or $_ eq "c") {
            $counterPart = $counterPart . "G";
        }
    }
    return $counterPart;
}

sub convertRNAToTriplets {
    my ($RNA) = @_;
    @triplets;
    for ($i = 0; $i < length($RNA); $i += 3) {
       push(@triplets, substr($RNA, $i, 3));
    }
    return @triplets;
}

sub getAminoAcids {
    my ($RNA) = @_;
    $aa = "";
    @triplets = convertRNAToTriplets($RNA);
    %aaMaping = (
        "UUU" => "F", "UUC" => "F", "UUA" => "L", "UUG" => "L",
        "CUU" => "L", "CUC" => "L", "CUA" => "L", "CUG" => "L",
        "AUU" => "I", "AUC" => "I", "AUA" => "I", "AUG" => "M",
        "GUU" => "V", "GUC" => "V", "GUA" => "V", "GUG" => "V",
        "UCU" => "S", "UCC" => "S", "UCA" => "S", "UCG" => "S",
        "CCU" => "P", "CCC" => "P", "CCA" => "P", "CCG" => "P",
        "ACU" => "T", "ACC" => "T", "ACA" => "T", "ACG" => "T",
        "GCU" => "A", "GCC" => "A", "GCA" => "A", "GCG" => "A",
        "UAU" => "Y", "UAC" => "Y", "UAA" => "*", "UAG" => "*",
        "CAU" => "H", "CAC" => "H", "CAA" => "Q", "CAG" => "Q",
        "AAU" => "N", "AAC" => "N", "AAA" => "K", "AAG" => "K",
        "GAU" => "D", "GAC" => "D", "GAA" => "E", "GAG" => "E",
        "UGU" => "C", "UGC" => "C", "UGA" => "*", "UGG" => "W",
        "CGU" => "R", "CGC" => "R", "CGA" => "R", "CGG" => "R",
        "AGU" => "S", "AGC" => "S", "AGA" => "R", "AGG" => "R",
        "GGU" => "G", "GGC" => "G", "GGA" => "G", "GGG" => "G",
    );
    foreach $t (@triplets) {
        $aa = $aa . $aaMaping{$t};
    }
    return $aa;
}

sub writeToFile {
    my ($filename, $DATA) = @_;
    open(FILE, ">$filename") or die "Couldn't open file! $fileName \n";
    print FILE $DATA;
    close(FILE) or die "Couldn't close file properly! $filename \n";
}
main();