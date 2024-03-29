#!perl

use strict;
use warnings;

use LWP::Simple ();
use File::HomeDir;
use Test::More;

my $api_key_file = File::HomeDir->my_home . '/.tvdb';
unless ( LWP::Simple::get("http://www.google.com/") ) {
    plan skip_all => 'No internet connection for live tests';
}
else {
    unless ( -e $api_key_file ) {
        plan skip_all => "Skipping live tests: Can't find $api_key_file";
    }
    else {
        plan tests => 97;
    }
}

use Net::TVDB;

my $tvdb = Net::TVDB->new();

# do a search for series
my $series_list = $tvdb->search('men behaving badly');
is( @{$series_list}, 2, 'two series results' );
my $series = @{$series_list}[0];
isa_ok( $series, 'Net::TVDB::Series' );
is( $series->SeriesName, 'Men Behaving Badly' );

$series->fetch();

is( $series->Status, 'Ended' );

my $episodes = $series->episodes;
is( @$episodes, 57, '57 episodes' );
for ( @{$episodes} ) {
    isa_ok( $_, 'Net::TVDB::Episode' );
}

# check order
my $episode = @{$episodes}[0];
is( $episode->id,          342429 );
is( $episode->EpisodeName, 'Children in Need Special' );

# check actors
my $actors = $series->actors;
is( @$actors, 7, '7 actors' );

for ( @{$actors} ) {
    isa_ok( $_, 'Net::TVDB::Actor' );
}

# check order
my $actor = @{$actors}[0];
is( $actor->id,   44200 );
is( $actor->Name, 'Caroline Quentin' );

# check banners
my $banners = $series->banners;
is( @$banners, 20, '20 banners' );

for ( @{$banners} ) {
    isa_ok( $_, 'Net::TVDB::Banner' );
}

# check order
my $banner = @{$banners}[0];
is( $banner->id,         22614 );
is( $banner->BannerType, 'fanart' );
