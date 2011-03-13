use 5.006;
use ExtUtils::MakeMaker;
WriteMakefile(
    NAME            => 'Labyrinth::DIUtils::ImageMagick',
    VERSION_FROM    => 'lib/Labyrinth/DIUtils/ImageMagick.pm',
    PREREQ_PM       => {
        'Image::Magick'         => 0,
    },
    NO_META     => 1,
    ABSTRACT    => 'Digital Image utilities driver with ImageMagick for Labyrinth Framework',
    AUTHOR      => 'Barbie <barbie@cpan.org>',
);
