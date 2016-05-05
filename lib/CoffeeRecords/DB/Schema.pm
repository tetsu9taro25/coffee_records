package CoffeeRecords::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'CoffeeRecords::DB::Row';

table {
    name 'text';
    pk 'id';
    columns qw(
        id
        text
    );
};

1;
