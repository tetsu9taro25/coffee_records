package CoffeeRecords::DB::Row::Text;
use strict;
use warnings;
use utf8;
use parent qw/CoffeeRecords::DB::Row/;

sub created_at_str { shift->created_at->strftime('%Y年%m月%d日 %H時%M分%S秒') }
sub updated_at_str { shift->updated_at->strftime('%Y年%m月%d日 %H時%M分%S秒') }

1;
