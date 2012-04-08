package My::List;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {};
    $self->{vector} = undef;
    $self->{tail} = undef;
    return bless $self, $class;
}

sub append {
    my $self = shift;
    my $target = shift;
    my $target_v = My::Entry->new($target);
    if (defined $self->{tail}) {
        $self->{tail}->next($target_v);
        $self->{tail} = $target_v;
        return;
    }
    $self->{tail} = $target_v;
    $self->{vector} = $target_v;
}

sub iterator {
    my $self = shift;
    return My::Iterator->new($self);
}

package My::Iterator;

sub new {
    my $class = shift;
    my $list = shift;
    my $self = {};
    $self->{list} = $list;
    $self->{current} = $list->{vector};
    return bless $self, $class;
}

sub has_next {
    my $self = shift;
    if (!defined $self->{current}) {
        return 0;
    }
    return 1;
}

sub next {
    my $self = shift;
    if (!defined $self->{current}) {
        return undef;
    }
    my $ret = $self->{current};
    $self->{current} = $self->{current}->next;
    return $ret;
}

sub value {
    my $self = shift;
    if (!defined $self->{current}) {
        return undef;
    }
    return $self->{current}->value;
}

package My::Entry;

sub new {
    my $class = shift;
    my $self = {};
    my $value = shift;
    $self->{value} = $value;
    $self->{next} = undef;
    return bless $self, $class;
}

sub value {
    my $self = shift;
    my $v = shift;
    if (defined $v) {
        $self->{value} = $v;
    }
    return $self->{value};
}

sub next {
    my $self = shift;
    my $newnext = shift;
    if (defined $newnext) {
        $self->{next} = $newnext;
    }
    return $self->{next};
}

1;

