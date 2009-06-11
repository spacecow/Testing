use strict;
use warnings;

my $infile = $ARGV[1];
my $dir = $ARGV[0];

open INFILE, "<", $infile or die "Could not open file: $!";
$infile =~ m#.*\\(.*)#;
my $outfile = $1;
#$outfile =~ s/(.*?)\..*/$1\.txt/;
$outfile = "$dir/$outfile" . ".txt";
open OUTFILE, ">", "$outfile" or die "Could not open file: $!";

my $path = $infile;
$path =~ s#\\#/#g;
$path =~ s#../..#yoyaku#;
print "<pre class=\"code\">\n";
print "<div class=\"path\"><a href=\"$outfile\">$path</a></div>\n";
while( <INFILE> ){
	my $line = $_;
	$line =~ s/</&lt;/g unless $ARGV[2];
	$line =~ s/\t/  /g;
	print $line;
	print OUTFILE $line;
}
print "</pre>";