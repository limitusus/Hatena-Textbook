package Bird;

use strict;
use warnings;

use Tweet;

sub new {
    my $class = shift;
    my %info = @_;
    my $self = {
        followers => [],  # those who follow $self
        followees => [],  # those who $self follows
        tweets => [],
        name => $info{name},
        forest => $info{forest},
    };
    bless $self, $class;
    if ($info{forest}) {
        $info{forest}->onRegister($self);
    }
    return $self;
}

# Accessors
sub name {
    my $self = shift;
    my $name = shift;
    if (!defined $name) {
        return $self->{name};
    }
    $self->{name} = $name;
    return $self->{name};
}

sub followees {
    my $self = shift;
    return $self->{followees};
}

sub followers {
    my $self = shift;
    return $self->{followers};
}

# APIs
sub follow {
    my $self = shift;
    my $followee = shift;
    $self->{forest}->onFollow($self, $followee);
    return $self;
}

sub tweet {
    my $self = shift;
    my $message = shift;
    $self->{forest}->onTweet($self, $message);
    return $self;
}

sub tweets {
    my $self = shift;
    return $self->{tweets};
}

# Returns timeline: a reference to array of Tweets
sub friends_timeline {
    my $self = shift;
    # TODO: implement
    my @timeline_tweets = ();
    for my $followee (@{$self->followees}, $self) {
        print STDERR $followee->name . "\n";
        for my $tweet (@{$followee->tweets}) {
            push @timeline_tweets, $tweet;
        }
    }
    print STDERR "\@timeline_tweets = @timeline_tweets\n";
    for my $t (@timeline_tweets) {
        print STDERR $t->message . $t->timestamp . $t->timestamp->hires_epoch . $/;
    }
    my @sorted_timeline_tweets = sort { $b->timestamp <=> $a->timestamp } @timeline_tweets;
    for my $t (@timeline_tweets) {
        print STDERR $t->message . $t->timestamp . $/;
    }
    return \@sorted_timeline_tweets;
}

# Internal methods

sub _follow {
    my $self = shift;
    my $followee = shift;
    push @{$self->{followees}}, $followee;
    return $self;
}

sub _followed_by {
    my $self = shift;
    my $follower = shift;
    push @{$self->{followers}}, $follower;
}

sub _tweet {
    my $self = shift;
    my $message = shift;
    my $tweet = Tweet->new(owner => $self->name, message => $message);
    push @{$self->{tweets}}, $tweet;
    return $self;
}

1;

