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

sub follow :Tests {
    my $f = Forest->new;
    my $b1 = Bird->new(name => "b1", forest => $f);
    my $b2 = Bird->new(name => "b2", forest => $f);
    my $b3 = Bird->new(name => "b3", forest => $f);
    $b1->follow($b2->name);
    $b1->follow($b3->name);
    $b2->follow($b1->name);
    $b2->follow($b3->name);
    is $b1->followees->[0]->name, "b2";
    is $b1->followees->[1]->name, "b3";
    is $b2->followers->[0]->name, "b1";
    is $b3->followers->[0]->name, "b1";
    is $b3->followers->[1]->name, "b2";
    is $b1->followers->[0]->name, "b2";
    is_deeply ($b1->followees, [$b2, $b3]);
    is_deeply ($b1->followers, [$b2, ]);
    is_deeply ($b2->followers, [$b1, ]);
    is_deeply ($b2->followees, [$b1, $b3]);
    is_deeply ($b3->followers, [$b1, $b2]);
}

sub follow_duplicate :Tests {
    my $f = Forest->new;
    my $b1 = Bird->new(name => "b1", forest => $f);
    my $b2 = Bird->new(name => "b2", forest => $f);
    # Follow twice
    $b1->follow($b2->name);
    $b1->follow($b2->name);
    is_deeply ($b1->followees, [$b2, ]);
    is_deeply ($b2->followers, [$b1, ]);
}

sub tweet :Tests {
    my $f = Forest->new;
    my $b1 = Bird->new(name => "b1", forest => $f);
    my $b2 = Bird->new(name => "b2", forest => $f);
    #$b1->follow($b2->name);
    $b2->follow($b1->name);
    $b1->tweet("Hello!");
    $b2->tweet("Hi!");
    $b1->tweet("hoge");
    use Data::Dumper;
    warn Dumper(\{$b2->friends_timeline});
    is $b1->tweets->[0]->message, "Hello!";
    is $b1->tweets->[1]->message, "hoge";
    is $b2->tweets->[0]->message, "Hi!";
    is $b2->friends_timeline->[0]->message, "Hello!";
    is $b2->friends_timeline->[1]->message, "Hi!";
    is $b2->friends_timeline->[2]->message, "hoge";
 }

 __PACKAGE__->runtests;

1;
