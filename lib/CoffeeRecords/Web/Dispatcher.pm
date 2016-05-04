package CoffeeRecords::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use CoffeeRecords::Repository::Text;

use CoffeeRecords::Web::C::Page;

base 'CoffeeRecords::Web::C';

get  '/'    => 'Page#get_root';
get  '/:id' => 'Page#get_id';
post '/'    => 'Page#post_root';
post '/:id' => 'Page#post_id';

1;
