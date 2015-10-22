#!perl -T

use strict;
use warnings;
use Test::More qw(no_plan); # tests => 5;

use Data::NestedSet;


diag( "Testing Data::NestedSet instantiation and return values" );

my $data = [
       [1,'MUSIC',0],
       [2,'M-GUITARS',1],
       [3,'M-G-GIBSON',2],
       [4,'M-G-G-SG',3],
       [5,'M-G-FENDER',2],
       [6,'M-G-F-TELECASTER',3],
       [7,'M-PIANOS',1]
];

{
    local $@;
    eval { my $obj = Data::NestedSet->new({ foo => 'bar'}); };
    like($@,
        qr/An array ref must be supplied as the first argument/,
        "Got expected error message for non-array-ref argument to new()"
    );
}

{
    local $@;
    eval { my $obj = Data::NestedSet->new([]); };
    like($@,
        qr/The number of items within the array ref must be >=1/,
        "Got expected error message for empty array ref argument to new()"
    );
}

#    croak 'An integer must be supplied as the second argument. Seen '. $depth_position
#        if(not defined $depth_position || $depth_position !~ m/^[0-9]+/mx);
{
    local $@;
    eval { my $obj = Data::NestedSet->new($data); };
    like($@,
        qr/An integer must be supplied as the second argument/,
        "Got expected error message for undefined depth position"
    );
}

#{
#    local $@;
#    eval { my $obj = Data::NestedSet->new($data, 'foo'); };
#    like($@,
#        qr/An integer must be supplied as the second argument/,
#        "Got expected error message for non-integer depth position"
#    );
#}

my $nodes   = new Data::NestedSet($data,2)->create_nodes();

ok($nodes->[0]->[-2] == 1,'root left value equals 1');
ok($nodes->[0]->[-1] == @{$data}*2,'root right values equals array length * 2');
ok($nodes->[0]->[-1] == 14,'root right values equals 14');
ok($nodes->[1]->[-1] == 11,'second entry right values equals 11');
ok($nodes->[-1]->[-1] == 13,'last entry right values equals 13');


