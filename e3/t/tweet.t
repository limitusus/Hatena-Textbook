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

sub attr : Tests {
    my $owner = Bird->new(name => "hoge");
    my $msg = Tweet->new(owner => $owner, message => "foobar");
    is $msg->message, "foobar";
    is $msg->owner, $owner;
}

__PACKAGE__->runtests;

1;
