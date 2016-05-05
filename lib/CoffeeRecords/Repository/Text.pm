package CoffeeRecords::Repository::Text;
use strict;
use warnings;
use utf8;
use CoffeeRecords;

sub db { CoffeeRecords->context->db }

sub fetch_by_id {
  my ($class, $id) = @_;

  my $row = $class->db->single(text => {id => $id});
  return $row ? $row->text : undef;
}

sub create {
  my ($class, $text) = @_;

  # XXX: 本来はinsertしたrowのidが取れるけどMySQL 5.7.8以降でバグってるから最新のやつを取り直す
  # この実装だと、insertが並列に走った場合にここでinsertしたのとは違うrowが取れる可能性がある
  my $id = $class->db->fast_insert(text => {text => $text});
  my $row = $class->db->single(text => {}, {
      columns  => [qw/id/],
      order_by => {id => 'DESC'},
    });

  return $row->id;
}

sub update {
  my ($class, $id, $text) = @_;

  $class->db->update(text => {text => $text}, {id => $id});
}

1;
