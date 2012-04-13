package test::Forest;
use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use Bird;
use Tweet;
use Forest;

sub init : Test(1) {
    new_ok 'Forest';
}

sub register_birds : Tests {
    my $f = Forest->new;
    my $b1 = Bird->new(name => "b1", forest => $f);
    my $b2 = Bird->new(name => "b2", forest => $f);
    my $b3 = Bird->new(name => "b3", forest => $f);
    is scalar @{$f->{birds}}, 3;
    is_deeply [map { $_->name } @{$f->{birds}}], [qw/b1 b2 b3/];
}

sub duplicated_register_birds : Tests {
    my $f = Forest->new;
    my $b1 = Bird->new(name => "b1", forest => $f);
    my $b2 = eval { Bird->new(name => "b1", forest => $f) };
    is (X::BirdExists->caught(), 'Bird name b1 already registered.');
}

__PACKAGE__->runtests;

1;
