package CoffeeRecords::Web::C::Page;
use strict;
use warnings;
use utf8;

use CoffeeRecords::Repository::Text;

sub get_root {
  my ($class, $c, $args) = @_;

  my $memo = CoffeeRecords::Repository::Text->fetch_all or return $c->res_404;
  return $c->render('root.tx', {
      memos => $memo,
    });
}

sub get_add {
  my ($class, $c, $args) = @_;

  return $c->render('form.tx', {
      action => '/add',
      button => 'create',
    });
}

sub get_id {
  my ($class, $c, $args) = @_;
  my $id = $args->{id};

  my $row = CoffeeRecords::Repository::Text->fetch_by_id($id)
    or return $c->res_404;

  return $c->render('show.tx', {
      beans_name => $row->beans_name,
      text => $row->text,
      id => $id,
    });
}

sub get_edit_id {
  my ($class, $c, $args) = @_;
  my $id = $args->{id};

  my $row = CoffeeRecords::Repository::Text->fetch_by_id($id)
    or return $c->res_404;

  $c->fillin_form({beans_name => $row->beans_name, text => $row->text});
  return $c->render('form.tx', {
      action => "/$id",
      button => 'update',
      created_at => $row->created_at_str,
      updated_at => $row->updated_at_str,
    });
}

sub post_add {
  my ($class, $c, $args) = @_;

  my $beans_name = $c->req->parameters->{beans_name} or return $c->res_400;
  my $text = $c->req->parameters->{text} or return $c->res_400;

  my $id = CoffeeRecords::Repository::Text->create($beans_name,$text);

  return $c->redirect("/$id");
}

sub post_id {
  my ($class, $c, $args) = @_;
  my $id = $args->{id};

  my $beans_name = $c->req->parameters->{beans_name} or return $c->res_400;
  my $text = $c->req->parameters->{text} or return $c->res_400;
  my $old_text = CoffeeRecords::Repository::Text->fetch_by_id($id) or return $c->res_404;

  CoffeeRecords::Repository::Text->update($id, $beans_name, $text);

  return $c->redirect("/$id");
}

1;
