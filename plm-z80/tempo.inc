declare c$read literally '1';
declare c$write literally '2';
declare f$open literally '15';
declare f$close literally '16';
declare f$read literally '20';
declare f$write literally '21';


declare cr literally '13';
declare lf literally '10';
declare pointer literally 'address';

boot: procedure external;
end boot;

mon1: procedure(f, a) external;
    declare f byte;
    declare a address;
end mon1;

print$char: procedure(c);
    declare c byte;
    call mon1(c$write, c);
end print$char;

print$string: procedure(pstr);
    declare pstr pointer;
    declare chr based pstr byte;
    do while chr <>0;
        call print$char(chr);
        pstr = pstr + 1;
    end;
end print$string;

new$line: procedure;
    call print$char(cr);
    call print$char(lf);
end new$line;

print$line: procedure(pstr);
    declare pstr pointer;
    call print$string(pstr);
    call new$line;
end print$line;

terminate: procedure(code);
    declare code byte;
    call boot;
end terminate;
