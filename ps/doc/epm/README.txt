
Essential Project Manager
=========================

Please read the UserGuide.pdf to learn how to create a filelist.

Filelists have the following format:

Line 1:      Project Name
Line 2:      Project Snapshot date (a text representation
             of the date snapshot taken)
Line 3:      Base directory (useful for cropping long paths and
             essential for PM comparisons)
Line 4-end:  full path and filename of each file


EPM supports multiple parser language types.  By default these are:
 * C# as before (files ending .cs)
 * ASP (files ending .asp, .aspx)
 * Java (files ending .java)
 * VB6/VB.NET (files ending .vb, .frm, .cls, .bas)
 * Perl (files ending .pl)
 * PL/SQL (files ending .sql, .ora)
 * ADA (files ending .a, .ada, .adb, .ads)
 * C/C++ (all other file extensions)

Please consult UserGuide.pdf for detailed information regarding
the EPM XML Configuration file that can be used to modify how
EPM parses your files, based on your naming conventions.

Simply include the files together in any order and EPM will
automatically differentiate for you!


Powersoftware.com