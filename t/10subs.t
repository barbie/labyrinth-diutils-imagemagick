#!/usr/bin/perl -w
use strict;

use File::Copy;
use File::Path;
use Labyrinth::DIUtils::ImageMagick;
use Test::More tests => 18;

eval {
    my $di = Labyrinth::DIUtils::ImageMagick->new();
};

like($@,qr/no image specified/,'no file passed');

eval {
    my $di = Labyrinth::DIUtils::ImageMagick->new( 'unknown.jpg' );
};

like($@,qr/no image file found/,'missing file passed');

eval {
    my $example    = 't/samples/testfile.jpg';
    my $sample     = 't/test/sample.jpg';
    my $thumbnail  = 't/test/thumbnail.png';
    my $thumbnail2 = 't/test/thumbnail2.png';

    mkdir('t/test');
    copy($example,$sample);

    my $di = Labyrinth::DIUtils::ImageMagick->new( $sample );
    isa_ok($di,'Labyrinth::DIUtils::ImageMagick');
    is($di->{image},$sample);

    is($di->rotate(),undef,'no rotation');
    is($di->rotate(45),1,'45 degrees rotation');
    is($di->rotate(90),1,'90 degrees rotation');
    is($di->rotate(180),1,'180 degrees rotation');
    is($di->rotate(270),1,'270 degrees rotation');

    #my ($width,$height) = $di->{object}->Get('columns', 'rows');
    #diag("$width x $height");

    is($di->reduce(300,300),undef,'no reduction');
    is($di->reduce(200,160),1,'width reduction');
    is($di->reduce(140,200),1,'height reduction');
    is($di->reduce(),1,'default reduction');

    is($di->thumb(),undef,'no thumbnail');
    is($di->thumb($thumbnail),1,'default thumbnail');
    ok(-f $thumbnail);
    is($di->thumb($thumbnail2,120),1,'set thumbnail');
    ok(-f $thumbnail2);

    rmtree('t/test');
};

diag($@) if($@);
