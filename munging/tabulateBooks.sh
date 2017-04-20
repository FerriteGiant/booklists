#!/bin/bash
#usage: ./tabulateBooks.sh

awk -f tabulateBooks.awk \
../rawData/bookman_librarians.table \
../rawData/bbc_the_big_read.table \
../rawData/modern_library_readers.table \
../rawData/modern_library_board.table \
../rawData/npr_beach_books.table \
../rawData/good_reads.table \
../rawData/harvard_bookstore.table \
| sort -t"," -k1.2,1gr -k2.2,2gr > tabulatedBooks.csv
