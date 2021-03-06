@rem = ' vim: set filetype=perl: ';
@rem = ' --*-Perl-*-- ';
@rem = '
@echo off
setlocal
set PATH=%~dp0;%PATH%
perl -w "%~f0" %*
exit /B %ERRORLEVEL%
';
use strict;
use warnings;
use English;

$OUTPUT_AUTOFLUSH = 1;

use FindBin;
use lib "$FindBin::Bin\\..\\lib";

use Util;

while(1)
{
    my ($failed, $out) = execute_task( "ipmiutil dcmi power" );

    exit( -1 ) if $failed;

    foreach my $line ( split '\n', $out )
    {
        if( $line =~ /Current Power:/ )
        {
            my $power = ( split ' ', $line )[2];
            
            print "$power\n";

            last;
        }
    }
 
    sleep(1);
}
