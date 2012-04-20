package test::Bird;
use strict;
use warnings;
use base qw(Test::Class);
use Test::More;

use Bird;
use Forest;

sub init : Test(1) {
    new_ok 'Bird';
}

sub attr : Tests {
    my $forest = Forest->new;
    my $bird = Bird->new(name => "hoge", forest => $forest);
    is $bird->name, "hoge";
    is $bird->{forest}, $forest;
}

__PACKAGE__->runtests;

1;

