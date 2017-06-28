use strict;
use warnings;

package Array::Split;

# ABSTRACT: split an array into sub-arrays

use Sub::Exporter::Simple qw( split_by split_into );
use List::Util 'max';
use POSIX 'ceil';

=head1 SYNOPSIS

    use Array::Split qw( split_by split_into );

=head1 DESCRIPTION

This module offers functions to separate all the elements of one array into multiple arrays.

=head2 split_by ( $split_size, @original )

Splits up the original array into sub-arrays containing the contents of the original. Each sub-array's size is the same
or less than $split_size, with the last one usually being the one to have less if there are not enough elements in
@original.

=cut

sub split_by {
    my $split_size = shift;

    $split_size = max( $split_size, 1 );

    my @sub_arrays;
    while ( @_ ) {
        push @sub_arrays, [ splice @_, 0, $split_size ];
    }

    return @sub_arrays;
}

=head2 split_into ( $count, @original )

Splits the given array into even-sized (as even as maths allow) sub-arrays. It tries to create as many sub-arrays as
$count indicates, but will return less if there are not enough elements in @original.

Returns a list of array references.

=cut

sub split_into {
    my ( $count, @original ) = @_;

    $count = max( $count, 1 );

    my $size = ceil @original / $count;

    return split_by( $size, @original );
}

1;
