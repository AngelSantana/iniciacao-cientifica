use strict;
use warnings;

use Time::HiRes qw(usleep);
local $| = 1;

my @nums = 1 .. 200;
my $num =  1;
foreach my $c (@nums) {
  $num = $num + 2;
  print "$num";
  usleep(100000);
  print ("\b" x length($num));
}
print "\n";

#!/usr/bin/perl

# $|=1;
# foreach (1..10) {
        # print ".";
        # sleep 1;
        # }

# print "\n";

