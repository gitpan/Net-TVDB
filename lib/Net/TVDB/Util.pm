package Net::TVDB::Util;
{
  $Net::TVDB::Util::VERSION = '1.120570';
}

use strict;
use warnings;

# ABSTRACT: Utility functions

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(pipes_to_array);

sub pipes_to_array {
    my $string = shift;
    return unless $string;

    my @array;
    for ( split( /\|/, $string ) ) {
        next unless $_;
        push @array, $_;
    }

    return \@array;
}



=pod

=head1 NAME

Net::TVDB::Util - Utility functions

=head1 VERSION

version 1.120570

=head1 SYNOPSIS

  use Net::TVDB::Util qw(pipes_to_array);

=head1 METHODS

=head2 pipes_to_array($string)

Takes a string such as "|Comedy|Action|" and returns an array without the pipes.

=head1 AUTHOR

Andrew Jones <andrew@arjones.co.uk>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Andrew Jones.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

