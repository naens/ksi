$if not plm$lib
$set (plm$lib)

$nocond
$nolist
$include (c:\intel\lib\doslibs.inc)
$list

declare boolean literally 'byte';
declare true literally '1';
declare false literally '0';
declare uint literally 'word';

$include (c:\prog\plm\str.plm)
$include (c:\prog\plm\sys.plm)
$include (c:\prog\plm\cons.plm)
$include (c:\prog\plm\file.plm)

$endif
