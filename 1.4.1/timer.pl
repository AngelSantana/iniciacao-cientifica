# use strict;
# use warnings;

# use Time::HiRes qw(usleep);
# local $| = 1;

# my @nums = 1 .. 20;

# foreach my $c (@nums) {
  # print "$c";
  # usleep(100000);
  # print ("\b" x length($c));
# }
# print "\n";

#!/usr/bin/perl

$|=1;
foreach (1..10) {
        print ".";
        sleep 1;
        }

print "\n";

