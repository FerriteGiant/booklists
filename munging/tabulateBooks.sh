#!/bin/bash
#usage: ./tabulateBooks.sh

awk -f tabulateBooks.awk \
data/bookman_librarians.table \
data/bbc_the_big_read.table \
data/modern_library_readers.table \
data/modern_library_board.table \
data/npr_beach_books.table \
data/good_reads.table \
data/harvard_bookstore.table \
| sort -nr -t$'|' #> tabulatedBooks.dat
