package test::MyList;
use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use My::List;

sub init : Test(1) {
    new_ok 'My::List';
}

sub appends : Tests {
    my $list = My::List->new;
    $list->append("Hello");
    $list->append("World");
    $list->append(2008);

    my $iter = $list->iterator;
    isnt $iter, undef;
    is $iter->has_next, 1;
    is $iter->next->value, "Hello";
    is $iter->has_next, 1;
    is $iter->next->value, "World";
    is $iter->has_next, 1;
    is $iter->next->value, "2008";
    is $iter->has_next, 0;
}

=hoge
sub sort : Tests {
    my $sorter = Sorter::QuickSort->new;
    $sorter->sort;
    is_deeply [$sorter->get_values], [];

    $sorter->set_values(1);
    $sorter->sort;
    is_deeply [$sorter->get_values], [1];

    $sorter->set_values(5,4,3,2,1);
    $sorter->sort;
    is_deeply [$sorter->get_values], [1,2,3,4,5];

    $sorter->set_values(-1,-2,-3,-4,-5);
    $sorter->sort;
    is_deeply [$sorter->get_values], [-5,-4,-3,-2,-1];

    $sorter->set_values(1,2,3,4,5);
    $sorter->sort;
    is_deeply [$sorter->get_values], [1,2,3,4,5];

    $sorter->set_values(5,5,4,4,4,3,2,1);
    $sorter->sort;
    is_deeply [$sorter->get_values], [1,2,3,4,4,4,5,5];

    for (0..4) {
        my @random_values = ();
        push(@random_values, int(rand() * 100) - 50) for 0..99;
        $sorter->set_values(@random_values);
        $sorter->sort;
        is_deeply [$sorter->get_values], [sort { $a <=> $b } @random_values];
    }
}
=cut

__PACKAGE__->runtests;

1;
