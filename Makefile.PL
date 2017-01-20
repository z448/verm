use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'App::Verm',
    AUTHOR           => q{Zdenek Bohunek <zed448@icloud.com>},
    VERSION_FROM     => 'lib/App/Verm.pm',
    ABSTRACT_FROM    => 'lib/App/Verm.pm',
    LICENSE          => 'artistic_2',
    PL_FILES         => {},
    'EXE_FILES'      => ['verm'],
    MIN_PERL_VERSION => 5.010,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
    },
    PREREQ_PM => {
        'HTTP::Tiny' => 0,
        'Data::Dumper' => 0,
        'App::cpanminus' => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'App-Verm-*' },
);
