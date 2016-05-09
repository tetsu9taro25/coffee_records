package CoffeeRecords::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use CoffeeRecords::Repository::Text;

use CoffeeRecords::Web::C::Page;

base 'CoffeeRecords::Web::C';

get  '/'    => 'Page#get_root';
get  '/add'    => 'Page#get_add';
get  '/:id'    => 'Page#get_id';
get  '/edit/:id' => 'Page#get_edit_id';
post '/add'    => 'Page#post_add';
post '/:id' => 'Page#post_id';

1;
