use File::Spec;
use File::Basename qw(dirname);
my $basedir = File::Spec->rel2abs(File::Spec->catdir(dirname(__FILE__), '..'));
my $dbpath = File::Spec->catfile($basedir, 'db', 'production.db');
+{
  'DBI' => [
    "dbi:mysql:database=coffee_records;host=localhost;", 'root', '', {
      AutoCommit           => 1,
      PrintError           => 0,
      RaiseError           => 1,
      ShowErrorStatement   => 1,
      mysql_enable_utf8    => 1,
      mysql_auto_reconnect => 0,
    }
  ],
};
