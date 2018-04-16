#!perl -T

use warnings;
use strict;

use Test::More;

use lib 't';
use Util;

plan tests => 13;

prep_environment();

my $match_start  = "\e[30;43m";
my $match_end    = "\e[0m";
my $line_end     = "\e[0m\e[K";

my $green_start  = "\e[1;32m";
my $green_end    = "\e[0m";

my $yellow_start = "\e[1;33m";
my $yellow_end   = "\e[0m";

NORMAL_COLOR: {
    my @files = qw( t/text/bill-of-rights.txt );
    my @args = qw( free --color );
    my @results = run_ack( @args, @files );

    ok( grep { /\e/ } @results, 'normal match highlighted' ) or diag(explain(\@results));
}

MATCH_WITH_BACKREF: {
    my @files = qw( t/text/bill-of-rights.txt );
    my @args = qw( (free).*\1 --color );
    my @results = run_ack( @args, @files );

    is( @results, 1, 'backref pattern matches once' );

    ok( grep { /\e/ } @results, 'match with backreference highlighted' );
}

BRITISH_COLOR: {
    my @files = qw( t/text/bill-of-rights.txt );
    my @args = qw( free --colour );
    my @results = run_ack( @args, @files );

    ok( grep { /\e/ } @results, 'normal match highlighted' );
}

MULTIPLE_MATCHES: {
    my @files = qw( t/text/amontillado.txt );
    my @args = qw( az.+?e|ser.+?nt -w --color );
    my @results = run_ack( @args, @files );

    is_deeply( \@results, [
        "\"A huge human foot d'or, in a field ${match_start}azure${match_end}; the foot crushes a ${match_start}serpent${match_end}$line_end",
    ] );
}


ADJACENT_CAPTURE_COLORING: {
    my @files = qw( t/text/raven.txt );
    my @args = qw( (Temp)(ter) --color );
    my @results = run_ack( @args, @files );

    is_deeply( \@results, [
        "Whether ${match_start}Tempter${match_end} sent, or whether tempest tossed thee here ashore,$line_end",
    ] );
}


subtest 'Heading colors, single line' => sub {
    plan tests => 4;

    # Without the column number
    my $file = reslash( 't/text/ozymandias.txt' );
    my @args = qw( mighty -i -w --color -H );
    my @results = run_ack( @args, $file );

    is_deeply( \@results, [
        "${green_start}$file${green_end}:${yellow_start}11${yellow_end}:Look on my works, ye ${match_start}Mighty${match_end}, and despair!'$line_end",
    ] );

    # With column number
    @results = run_ack( @args, '--column', $file );
    is_deeply( \@results, [
        "${green_start}$file${green_end}:${yellow_start}11${yellow_end}:${yellow_start}22${yellow_end}:Look on my works, ye ${match_start}Mighty${match_end}, and despair!'$line_end",
    ] );
};


subtest 'Heading colors, grouped' => sub {
    plan tests => 4;

    # Without the column number
    my $file = reslash( 't/text/ozymandias.txt' );
    my @args = qw( mighty -i -w --color --group );
    my @results = run_ack( @args, 't/text' );

    is_deeply( \@results, [
        "${green_start}$file${green_end}",
        "${yellow_start}11${yellow_end}:Look on my works, ye ${match_start}Mighty${match_end}, and despair!'$line_end",
    ] );

    # With column number
    @results = run_ack( @args, '--column', 't/text' );
    is_deeply( \@results, [
        "${green_start}$file${green_end}",
        "${yellow_start}11${yellow_end}:${yellow_start}22${yellow_end}:Look on my works, ye ${match_start}Mighty${match_end}, and despair!'$line_end",
    ] );
};

done_testing();

exit 0;
