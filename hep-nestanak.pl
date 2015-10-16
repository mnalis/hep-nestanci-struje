#!/usr/bin/perl -T
# Matija Nalis <mnalis-git@voyager.hr> 2015-10-12, GPLv3+
# 
# pretrazuje online bazu predvidjenih nestanaka struje i matcha zadani regexp
# jer RSS na stranicama prikazuje samo nestanke struje za danas :(
#
# Usage: hep-nestanak.pl zagreb ZG 'Ti.+ari.+ka'

use strict;
use warnings;
use autodie;
use feature 'say';
use WWW::Mechanize;
use HTML::TreeBuilder::XPath;

my $ELEKTRA_DP = shift;
my $ELEKTRA_LOC = shift;
my $REGEXP = shift;

if (!defined($ELEKTRA_DP) or !defined($ELEKTRA_LOC) or !defined($REGEXP)) {
    say STDERR "Usage: $0 <ELEKTRA_PODRUCJE> <ELEKTRA_POGON> <REGEXP>";
    say STDERR "for example: $0 zagreb ZG 'Savska'";
    exit 1;
}

# no user configurable parts below

my $mech = WWW::Mechanize->new();

$mech->get( 'http://www.hep.hr/ods/dp/nestanak.aspx?dp=' . $ELEKTRA_DP );

say '<ul>';
foreach my $dan (1..6) {
    my $res = $mech->submit_form(
        form_id => 'frm',
        fields    => { 
            __EVENTARGUMENT => '',
            __EVENTTARGET => 'tKalendar$LinkButtonDan' . $dan,
            ddListDP => $ELEKTRA_LOC,
        },
    );

    my $tree= HTML::TreeBuilder::XPath->new;
    $tree->parse_content($res->decoded_content);

    my $datum = $tree->findvalue ( '//tr[@id="tKalendar_rDan"]/th' );
    my @sve=$tree->findnodes( '//li' );

    foreach my $node (@sve) {
        my $lokacije_raw = $node->as_HTML;
        if ($lokacije_raw =~ m{$REGEXP}i) {
            say "$lokacije_raw <br> ($datum)";
        }
    }
}
say '</ul>';
