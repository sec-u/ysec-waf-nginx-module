#yy_sec_waf off;

#####
#xss attack
#####

#1.-------------------------------------------------------------------------------------------------
#p1
#basic_rule regex:<(script|iframe|style|applet|base|body|frame|frameset|form|input|ins|layer|link|meta|object|address|area|bgsound|textarea)[^>]*> msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;
#p2
#basic_rule regex:<(s(cript|tyle)|i(frame|n(put|s))|f(rame(set)?|orm)|a(pplet|ddress|rea)|b(ase|gsound|ody)|l(ayer|ink)|meta|object|textarea)[^>]*> msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;
#p3
basic_rule regex:<(?:s(?:cript|tyle)|i(?:frame|n(?:put|s))|f(?:rame(?:set)?|orm)|a(?:pplet|ddress|rea)|b(?:ase|gsound|ody)|l(?:ayer|ink)|meta|object|textarea)[^>]*> msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;

#2.---------------------------------------------------------------------------------------------------
#p1
#basic_rule regex:[\s`'"]on(abort|blur|change|click|dblclick|dragdrop|error|focus|keydown|keypress|keyup|load|mousedown|mousemove|mouseout|mouseover|mouseup|move|readystatechange|reset|resize|select|submit|unload)\s*= msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;
#p2
#basic_rule regex:[\s`'"]on(abort|blur|c(hange|lick)|d(blclick|ragdrop)|error|focus|key(down|press|up)|load|m(ouse(down|move|o(ut|ver)|up)|ove)|re(adystatechange|s(et|ize))|s(elect|ubmit)|unload)\s*= msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;
#p3
basic_rule regex:[\s`'"]on(?:abort|blur|c(?:hange|lick)|d(?:blclick|ragdrop)|error|focus|key(?:down|press|up)|load|m(?:ouse(?:down|move|o(?:ut|ver)|up)|ove)|re(?:adystatechange|s(?:et|ize))|s(?:elect|ubmit)|unload)\s*= msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;


#3.--------------------------------------------------------------------------------------------------
#p1,p2
#basic_rule regex:[\s`'"]+style\s*=[^:]*:\s*(url|expression) msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;
#p3
basic_rule regex:[\s`'"]+style\s*=[^:]*:\s*(?:url|expression) msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;

#union of 2,3
#basic_rule regex:[\s`'"]+(on(abort|blur|c(hange|lick)|d(blclick|ragdrop)|error|focus|key(down|press|up)|load|m(ouse(down|move|o(ut|ver)|up)|ove)|re(adystatechange|s(et|ize))|s(elect|ubmit)|unload)\s*=|style\s*=[^:]*:\s*(url|expression)) msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;

#4.--------------------------------------------------------------------------------------------------
#p1,p2
#basic_rule "regex:((j|&#x[46]a;)(a|&#x[46]1;)(v|&#x[57]6;)(a|&#x[46]1;)|(v|&#x[57]6;)(b|&#x[46]2;))(s|&#x[57]3;)(c|&#x[46]3;)(r|&#x[57]2;)(i|&#x[46]9;)(p|&#x[57]0;)(t|&#x[57]4;)(:|&#x3a;)|(d|&#x[46]4;)(a|&#x[46]1;)(t|&#x[57]4;)(a|&#x[46]1;)(:|&#x3a;)(t|&#x[57]4;)(e|&#x[46]5;)(x|&#x[57]8;)(t|&#x[57]4;)(/|&#x2f;)(h|&#x[46]8;)(t|&#x[57]4;)(m|&#x[46]d;)(l|&#x[46]c;)" msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;
#p3
#basic_rule "regex:(?:(?:j|&#x[46]a;)(?:a|&#x[46]1;)(?:v|&#x[57]6;)(?:a|&#x[46]1;)|(?:v|&#x[57]6;)(?:b|&#x[46]2;))(?:s|&#x[57]3;)(?:c|&#x[46]3;)(?:r|&#x[57]2;)(?:i|&#x[46]9;)(?:p|&#x[57]0;)(?:t|&#x[57]4;)(?::|&#x3a;)|(?:d|&#x[46]4;)(?:a|&#x[46]1;)(?:t|&#x[57]4;)(?:a|&#x[46]1;)(?::|&#x3a;)(?:t|&#x[57]4;)(?:e|&#x[46]5;)(?:x|&#x[57]8;)(?:t|&#x[57]4;)(?:/|&#x2f;)(?:h|&#x[46]8;)(?:t|&#x[57]4;)(?:m|&#x[46]d;)(?:l|&#x[46]c;)" msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;

basic_rule regex:(?:java|vb)script:|data:text/html msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;
#5.---------------------------------------------------------------------------------------------------
#p1,p2
#basic_rule "regex:[\"']\s*(/\*.*?\*/)?\s*;.+(\"|'|//|/\*|<!--)" msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;
#p3
basic_rule "regex:[\"']\s*(?:/\*.*?\*/)?\s*;.+(?:\"|'|//|/\*|<!--)" msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;

#6.---------------------------------------------------------------------------------------------------
#p1,p2,p3
basic_rule regex:[<\s`'"].*?\x00[^=>]*[=>] msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;

#7.--------------------------------------------------------------------------------------------------
#p1,p2
#basic_rule "regex:['\"]\s*\)\s*;.*?(\(.*?['\"]|//|<!--|/\*)" msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;
#p3
basic_rule "regex:['\"]\s*\)\s*;.*?(?:\(.*?['\"]|//|<!--|/\*)" msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;

#union 5,7
#basic_rule "regex:[\"']\s*((/\*.*?\*/)?\s*;.+(\"|'|//|/\*|<!--)|\)\s*;.*?(\(.*?['\"]|//|<!--|/\*))" msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;

#8.--------------------------------------------------------------------------------------------------
#p1,p2,p3
basic_rule regex:allowScriptAccess[\s]*?=[\s]*?always msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;

##################
#command injection
##################
basic_rule "regex:[\;\|\`]\W*?\b(?:c(?:h(?:grp|mod|own|sh)|url|pp|c|d|at)|p(?:asswd|ython|erl|ing|s)|n(?:asm|et|map|c)|f(?:inger|tp)|t(?:elnet|raceroute|clsh8?|ftp)|g(?:cc|\+\+)|kill|mail|(?:xte)?rm|ls(?:of)?|id|echo|uname|wget|sh)\b" msg:test pos:ARGS gids:XSS lev:LOG|BLOCK;

