package CoffeeRecords::Repository::Text;
use strict;
use warnings;
use utf8;
use CoffeeRecords;

sub db { CoffeeRecords->context->db }

sub fetch_by_id {
  my ($class, $id) = @_;

  return $class->db->single(text => {id => $id});
}

sub fetch_all {
  my ($class) = @_;
    my @rows = $teng->search('text',{id => 1},{order_by => 'id'});
  return @rows;
}

sub create {
  my ($class, $beans_name, $text) = @_;

  # XXX: 本来はinsertしたrowのidが取れるけどMySQL 5.7.8以降でバグってるから最新のやつを取り直す
  # この実装だと、insertが並列に走った場合にここでinsertしたのとは違うrowが取れる可能性がある
  my $id = $class->db->fast_insert(text => {beans_name => $beans_name, text => $text});
  my $row = $class->db->single(text => {}, {
      columns  => [qw/id/],
      order_by => {id => 'DESC'},
    });

  return $row->id;
}

sub update {
  my ($class, $id, $beans_name, $text) = @_;

  $class->db->update(text => {beans_name => $beans_name, text => $text}, {id => $id});
}

1;
