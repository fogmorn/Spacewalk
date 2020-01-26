#!/usr/bin/perl
#
# Скрипт для обновления файлов errata и запуска импорта в Spacewalk.
# Для импорта используется скрипт CEFS - errata-import.pl
# (https://cefs.steve-meier.de/).
#
use strict;
use warnings;
use v5.16.3;

my $work_dir = "/root/cefs";
chomp (my $_curl = `which curl`);
my $zflag = ""; # curl -z флаг для загрузки только обновлённого файла

# Ссылки к файлам errata
my %file;
my %uri;
$file{rh} = "com.redhat.rhsa-all.xml";
$file{cefs} = "errata.latest.xml";
$uri{rh} = "https://www.redhat.com/security/data/oval/$file{rh}";
$uri{cefs} = "https://cefs.b-cdn.net/$file{cefs}";

my $_import_script = "errata-import.pl " .
                     "--server spacewalk.lan " .
                     "--errata $work_dir/$file{cefs} " .
                     "--rhsa-oval $work_dir/$file{rh} " .
                     "--publish --quiet";

`cd $work_dir`;

# Загрузка файлов errata
for ( "rh", "cefs" ) {

    system("test", "-e", "$file{$_}");

    if ( $? == 0 ) { $zflag = "-z $file{$_}"; }
    else { $zflag = ""; }

    system("$_curl -sS $uri{$_} -o $file{$_} $zflag");
}

# Запуск импорта в Spacewalk
system("$work_dir/$_import_script");
say $?;
