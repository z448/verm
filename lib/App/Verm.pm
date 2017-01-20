package App::Verm;
use Data::Dumper;
use HTTP::Tiny;

use warnings;
use strict;

=head1 NAME

App::Verm - get path to specific version of module

=cut

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw< verm >;
our $VERSION = '0.01';

# < module name > use Tiny or curl to get content
my $get = sub {
    my %g = (
        url => 'https://metacpan.org/pod/',
        name => shift,
        agent => 'Mozilla/5.0',
    );

    my $res;
    return sub{ $res = HTTP::Tiny->new->get("$g{url}$g{name}"); return $res->{content} } if length $res->{content};
    return sub{
       open my $p,'-|',"curl --user-agent \"$g{agent}\" -skL '$g{url}$g{name}'";
       while( <$p> ){ $res .= $_ }
       return $res;
    };
};

# < module name > hash ref version => /path/to/version
my $version_path = sub {
    my $module = shift;
    my $res = $get->($module);
    my $field = 0;
    my %version = ();

    open(my $fh,'<',\$res->());
    while( <$fh> ){
        if(/Jump to version/){ $field = 1 }
        if( /(value|label)\=\"(.*?)\/(.*?)\/.*">(.*?)\ / ){
                return \%version if( $field == 1 and defined $version{"$4"});
                unless( $field == 0 or defined $version{"$4"} ){ $version{"$4"} = "$2/$3" }
        }
    }
    return \%version;
};

=head1 FUNCTIONS

=head2 verp

C<verp($module)> 

Takes module name, returns hash ref: version => /path/to/version

=cut

sub verm {
    return $version_path->(shift);
}

=head1 AUTHOR

Zdenek Bohunek, C<< <zdenek@cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2017 Zdenek Bohunek, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

 

