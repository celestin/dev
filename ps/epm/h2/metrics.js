/* * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * MetricHelp Data and Functions for HTML Reporting
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File created.
 * CAM  27-Oct-2006  117 : New SLOC* metrics added.
 * CAM  17-Apr-2009  10430 : Added Churn (CRN*) metrics.
 * CAM  22-Aug-2009  10456 : Modified Halstead Bug Prediction description.
 * * * * * * * * * * * * * * * * * * * * * * * */

var metd = new Array();

metd["F"] = new Array();

metd["F"]["100"] = new Array();
metd["F"]["100"]["C"] = "LOC";
metd["F"]["100"]["N"] = "Lines of code";
metd["F"]["100"]["H"] = "Number of Lines in this file, including source, whitespace and comments.<br><br>Effectively, a count of the number of newlines in the file.";

metd["F"]["101"] = new Array();
metd["F"]["101"]["C"] = "SLOC";
metd["F"]["101"]["N"] = "Source lines of code";
metd["F"]["101"]["H"] = "Number of Source lines in this file, excluding whitespace and comments.<br><br>This is not a count of semicolons or distinct statements, but a count of <br>physical lines that contain source code.<br><br>If you are interested in \"logical\" lines, see NSC.<br><br><font face=\"Courier New\">int i=0; float j=0; // This is 1 SLOC<br><br>cout &lt;&lt; \"Testing\"<br>  &lt;&lt; \" Hello\"<br>  &lt;&lt; \" there.\" ;  // This is 3 SLOCs</font>";

metd["F"]["102"] = new Array();
metd["F"]["102"]["C"] = "SLOC_NAT";
metd["F"]["102"]["N"] = "Source Native Lines of Code";
metd["F"]["102"]["H"] = "The number of lines of code in this file containing Native Source.<br><br>Native Source is code that is native to the main language, used when analysing HTML-generating software.";

metd["F"]["103"] = new Array();
metd["F"]["103"]["C"] = "SLOC_TAG";
metd["F"]["103"]["N"] = "Source Tag Lines of Code";
metd["F"]["103"]["H"] = "The number of lines of code in this file containing Tags.<br><br>Tags are used in conjuction with HTML-generating software, such as ASP or JSP.";

metd["F"]["104"] = new Array();
metd["F"]["104"]["C"] = "SLOC_HTM";
metd["F"]["104"]["N"] = "Source HTML Lines of Code";
metd["F"]["104"]["H"] = "The number of lines of code in this file containing HTML.";

metd["F"]["105"] = new Array();
metd["F"]["105"]["C"] = "SLOC_SCR";
metd["F"]["105"]["N"] = "Source Script Lines of Code";
metd["F"]["105"]["H"] = "The number of lines of code in this file containing Script.<br><br>Script in this context means Javascript or VBScript used in HTML source, either a HTML file or HTML-generating source.";

metd["F"]["106"] = new Array();
metd["F"]["106"]["C"] = "PLOC";
metd["F"]["106"]["N"] = "Preprocessor Directive Lines of Code";
metd["F"]["106"]["H"] = "The number of preprocessor directive lines in the file, typically those that begin with a #.  Preprocessor Directive LOC is included as part of SLOC and LOC, but identified separately at the filelevel for clarity.";

metd["F"]["107"] = new Array();
metd["F"]["107"]["C"] = "LLOC";
metd["F"]["107"]["N"] = "Logical Lines of Code";
metd["F"]["107"]["H"] = "A count of the number of semicolons in this file excluding those within comments and <br>string literals.  This is useful for approximating &quot;logical lines of code&quot;.  E.g.:<br><br><font face=\"Courier New\">cout &lt;&lt; \"Hello\" &lt;&lt; endl <font color=\"FF1111\">;</font> /* output ; return */<br>cout &lt;&lt; \"Hello ; World\" &lt;&lt; endl <font color=\"FF1111\">;</font></font><br><br>LLOC = 2.";

metd["F"]["108"] = new Array();
metd["F"]["108"]["C"] = "N1";
metd["F"]["108"]["N"] = "Halstead total number of operators";
metd["F"]["108"]["H"] = "The total number of operators in the file.<br><br>N1 is part of the Halstead set, and of little interest on its own.  When combined with the other Halstead fundamental metrics, it can be used to determine Volume, Difficult, Effort and Cyclomatic complexity.";

metd["F"]["109"] = new Array();
metd["F"]["109"]["C"] = "N2";
metd["F"]["109"]["N"] = "Halstead total number of operands";
metd["F"]["109"]["H"] = "The total number of operands in the file.<br><br>N2 is part of the Halstead set, and of little interest on its own.  When combined with the other Halstead fundamental metrics, it can be used to determine Volume, Difficult, Effort and Cyclomatic complexity.";

metd["F"]["110"] = new Array();
metd["F"]["110"]["C"] = "n1";
metd["F"]["110"]["N"] = "Halstead number of unique operators";
metd["F"]["110"]["H"] = "The number of unique or distinct operators in the file.<br><br>n1 is part of the Halstead set, and of little interest on its own.  When combined with the other Halstead fundamental metrics, it can be used to determine Volume, Difficult, Effort and Cyclomatic complexity.";

metd["F"]["111"] = new Array();
metd["F"]["111"]["C"] = "n2";
metd["F"]["111"]["N"] = "Halstead number of unique operands";
metd["F"]["111"]["H"] = "The number of unique or distinct operands in the file.<br><br>n2 is part of the Halstead set, and of little interest on its own.  When combined with the other Halstead fundamental metrics, it can be used to determine Volume, Difficult, Effort and Cyclomatic complexity.";

metd["F"]["112"] = new Array();
metd["F"]["112"]["C"] = "N";
metd["F"]["112"]["N"] = "Halstead program Length";
metd["F"]["112"]["H"] = "Halstead program Length (N) for this file is calculated as N1 + N2.<br><br>N1 = Total number of Operators<br>N2 = Total number of Operands";
metd["F"]["112"]["F"] = "N = N1 + N2";

metd["F"]["113"] = new Array();
metd["F"]["113"]["C"] = "n";
metd["F"]["113"]["N"] = "Halstead program Vocabulary";
metd["F"]["113"]["H"] = "Halstead program Vocabulary (n) for this file is calculated as n1 + n2.<br><br>n1 = Number unique or distinct Operators<br>n2 = Number unique or distinct Operands";
metd["F"]["113"]["F"] = "n = n1 + n2";

metd["F"]["114"] = new Array();
metd["F"]["114"]["C"] = "V";
metd["F"]["114"]["N"] = "Halstead program Volume";
metd["F"]["114"]["H"] = "Halstead Volume for the file.  Calculated as:";
metd["F"]["114"]["F"] = "V = Nlog<SUB>2</SUB>n";

metd["F"]["115"] = new Array();
metd["F"]["115"]["C"] = "D";
metd["F"]["115"]["N"] = "Halstead program Difficulty";
metd["F"]["115"]["H"] = "A measure of how difficult this file's code is to understand.";
metd["F"]["115"]["F"] = "D = (n1/2) * (N2/n2) <br><br>Where:<br>n1 - the number of distinct operators<br>n2 - the number of distinct operands<br>N1 - the total number of operators <br>N2 - the total number of operands";

metd["F"]["116"] = new Array();
metd["F"]["116"]["C"] = "E";
metd["F"]["116"]["N"] = "Halstead program Effort";
metd["F"]["116"]["H"] = "Effort = Difficulty * Volume for this file.";
metd["F"]["116"]["F"] = "E = D * V";

metd["F"]["117"] = new Array();
metd["F"]["117"]["C"] = "B";
metd["F"]["117"]["N"] = "Halstead Bug Prediction";
metd["F"]["117"]["H"] = "This variant of Halstead Effort is a measure of the likelihood of bugs within the file.";
metd["F"]["117"]["F"] = "(N <i>log</i>n) / 3000";

metd["F"]["118"] = new Array();
metd["F"]["118"]["C"] = "J_COM";
metd["F"]["118"]["N"] = "Java style comments";
metd["F"]["118"]["H"] = "The number of Java style comments in the file.<br><br>A Java style comment begins <font face=\"Courier New\" color=\"FF1111\">/**</font> and ends <font face=\"Courier New\" color=\"FF1111\">*/</font>. E.g.:<br><br><font face=\"Courier New\"><font color=\"FF1111\">&nbsp;/**<br>&nbsp;&nbsp;* An interface for handling Application level operations.<br>&nbsp;&nbsp;*<br>&nbsp;&nbsp;*/</font><br>&nbsp;public interface ApplicationHandler {</font><br><br>J_COM = 1.";

metd["F"]["119"] = new Array();
metd["F"]["119"]["C"] = "C_COM";
metd["F"]["119"]["N"] = "C style comments";
metd["F"]["119"]["H"] = "The number of C style comments in the file.<br><br>A C style comment begins <font face=\"Courier New\" color=\"FF1111\">/*</font> and ends <font face=\"Courier New\" color=\"FF1111\">*/</font>.<br><br>In the following example C_COM = 1.<br><br><font face=\"Courier New\">int i = 0 ; <font color=\"FF1111\">/* This is a useful<br>variable here for<br>many purposes */</font></font>";

metd["F"]["120"] = new Array();
metd["F"]["120"]["C"] = "EOL_COM";
metd["F"]["120"]["N"] = "To End-of-Line comments";
metd["F"]["120"]["H"] = "The number of to end-of-line comment lines in this file.<br><br>This type of comment begins <font face=\"Courier New\" color=\"FF1111\">//</font> and finishes at the end of the line.<br><br>In the following example EOL_COM=2.<br><br><font face=\"Courier New\">int i = 0 ; <font color=\"FF1111\">// Index variable</font><br>float pi = 3.14 ; <font color=\"FF1111\">// Handy pi variable</font><br>char star = '*' ;</font>";

metd["F"]["121"] = new Array();
metd["F"]["121"]["C"] = "COM_LOC";
metd["F"]["121"]["N"] = "Comment lines of code";
metd["F"]["121"]["H"] = "The total number of lines of comment in the file.";

metd["F"]["122"] = new Array();
metd["F"]["122"]["C"] = "BYTES";
metd["F"]["122"]["N"] = "Number of bytes";
metd["F"]["122"]["H"] = "The total number of bytes in the file.";

metd["F"]["124"] = new Array();
metd["F"]["124"]["C"] = "CHG_SLOC";
metd["F"]["124"]["N"] = "Source Lines of Code (Changed)";
metd["F"]["124"]["H"] = "Number of source lines that have been changed between the new file and the old file.<br><br>For example the following would have CHG_SLOC=1.<br><br><u>Old File</u><br><font face=\"Courier New\">void functionA(int k) {<br>&#09;cout &#60;&#60; \"Parameter: \" &#60;&#60; k &#60;&#60; endl ;<br>}<br><br><font color=\"#000099\">void functionB(j) {<br>&#09;//Unused function<br>}</font><br><br>int main(int argc, char **argv) {<br><br>&#09;int i ;<br>&#09;int j=100 ;<br><br>&#09;for (i=0 ; i&#60;10 ; i++) {<br><br>&#09;&#09;// Calling functionA()<br>&#09;&#09;functionA(i) ;<br><br>&#09;&#09;while (j&#62;0) {<br>&#09;&#09;&#09;j-= 5 ;<br>&#09;&#09;}<br><br>&#09;}<br>}</font><br><br><br><u>New File</u><br><font face=\"Courier New\">void functionA(int k) {<br>&#09;cout &#60;&#60; \"Parameter: \" &#60;&#60; k &#60;&#60; endl ;<br>}<br><br>int main(int argc, char **argv) {<br><br>&#09;int i ;<br>&#09;int j=100 ;<br><br><font color=\"#116611\">&#09;int count=0 ;</font><br><br>&#09;for (i=0 ; i&#60;10 ; i++) {<br><br>&#09;&#09;// Calling functionA()<br>&#09;&#09;functionA(i) ;<br><br>&#09;&#09;while (j&#62;0) {<br>&#09;&#09;&#09;<font color=\"#990000\">j-= 10 ;</font><br>&#09;&#09;}<br><br><font color=\"#116611\">&#09;&#09;while(count&#60;10) {<br>&#09;&#09;&#09;count++ ;<br>&#09;&#09;}</font><br><br>&#09;}<br>}</font><br><br><u>Color Key</u><br><font color=\"#116611\">Added</font><br><font color=\"#990000\">Changed</font><br><font color=\"#000099\">Deleted</font>";

metd["F"]["125"] = new Array();
metd["F"]["125"]["C"] = "DEL_SLOC";
metd["F"]["125"]["N"] = "Source Lines of Code (Deleted)";
metd["F"]["125"]["H"] = "Number of source lines that have been deleted between the new file and the old file.<br><br>For example the following would have DEL_SLOC=2. (The comment is not a SLOC)<br><br><u>Old File</u><br><font face=\"Courier New\">void functionA(int k) {<br>&#09;cout &#60;&#60; \"Parameter: \" &#60;&#60; k &#60;&#60; endl ;<br>}<br><br><font color=\"#000099\">void functionB(j) {<br>&#09;//Unused function<br>}</font><br><br>int main(int argc, char **argv) {<br><br>&#09;int i ;<br>&#09;int j=100 ;<br><br>&#09;for (i=0 ; i&#60;10 ; i++) {<br><br>&#09;&#09;// Calling functionA()<br>&#09;&#09;functionA(i) ;<br><br>&#09;&#09;while (j&#62;0) {<br>&#09;&#09;&#09;j-= 5 ;<br>&#09;&#09;}<br><br>&#09;}<br>}</font><br><br><br><u>New File</u><br><font face=\"Courier New\">void functionA(int k) {<br>&#09;cout &#60;&#60; \"Parameter: \" &#60;&#60; k &#60;&#60; endl ;<br>}<br><br>int main(int argc, char **argv) {<br><br>&#09;int i ;<br>&#09;int j=100 ;<br><br><font color=\"#116611\">&#09;int count=0 ;</font><br><br>&#09;for (i=0 ; i&#60;10 ; i++) {<br><br>&#09;&#09;// Calling functionA()<br>&#09;&#09;functionA(i) ;<br><br>&#09;&#09;while (j&#62;0) {<br>&#09;&#09;&#09;<font color=\"#990000\">j-= 10 ;</font><br>&#09;&#09;}<br><br><font color=\"#116611\">&#09;&#09;while(count&#60;10) {<br>&#09;&#09;&#09;count++ ;<br>&#09;&#09;}</font><br><br>&#09;}<br>}</font><br><br><u>Color Key</u><br><font color=\"#116611\">Added</font><br><font color=\"#990000\">Changed</font><br><font color=\"#000099\">Deleted</font>";

metd["F"]["126"] = new Array();
metd["F"]["126"]["C"] = "ADD_SLOC";
metd["F"]["126"]["N"] = "Source Lines of Code (Added)";
metd["F"]["126"]["H"] = "Number of source lines that have been added between the new file and the old file.<br><br>For example the following would have ADD_SLOC=4.<br><br><u>Old File</u><br><font face=\"Courier New\">void functionA(int k) {<br>&#09;cout &#60;&#60; \"Parameter: \" &#60;&#60; k &#60;&#60; endl ;<br>}<br><br><font color=\"#000099\">void functionB(j) {<br>&#09;//Unused function<br>}</font><br><br>int main(int argc, char **argv) {<br><br>&#09;int i ;<br>&#09;int j=100 ;<br><br>&#09;for (i=0 ; i&#60;10 ; i++) {<br><br>&#09;&#09;// Calling functionA()<br>&#09;&#09;functionA(i) ;<br><br>&#09;&#09;while (j&#62;0) {<br>&#09;&#09;&#09;j-= 5 ;<br>&#09;&#09;}<br><br>&#09;}<br>}</font><br><br><br><u>New File</u><br><font face=\"Courier New\">void functionA(int k) {<br>&#09;cout &#60;&#60; \"Parameter: \" &#60;&#60; k &#60;&#60; endl ;<br>}<br><br>int main(int argc, char **argv) {<br><br>&#09;int i ;<br>&#09;int j=100 ;<br><br><font color=\"#116611\">&#09;int count=0 ;</font><br><br>&#09;for (i=0 ; i&#60;10 ; i++) {<br><br>&#09;&#09;// Calling functionA()<br>&#09;&#09;functionA(i) ;<br><br>&#09;&#09;while (j&#62;0) {<br>&#09;&#09;&#09;<font color=\"#990000\">j-= 10 ;</font><br>&#09;&#09;}<br><br><font color=\"#116611\">&#09;&#09;while(count&#60;10) {<br>&#09;&#09;&#09;count++ ;<br>&#09;&#09;}</font><br><br>&#09;}<br>}</font><br><br><u>Color Key</u><br><font color=\"#116611\">Added</font><br><font color=\"#990000\">Changed</font><br><font color=\"#000099\">Deleted</font>";

metd["F"]["127"] = new Array();
metd["F"]["127"]["C"] = "CRN_SLOC";
metd["F"]["127"]["N"] = "Churn Source Lines of Code";
metd["F"]["127"]["H"] = "Churn metrics give an overall indicator of the total &quot;change&quot; in source lines between the new file and the old file.";
metd["F"]["127"]["F"] = "CRN_SLOC = CHG_SLOC + DEL_SLOC + ADD_SLOC";

metd["F"]["128"] = new Array();
metd["F"]["128"]["C"] = "CHG_LLOC";
metd["F"]["128"]["N"] = "Changed Logical Lines of Code";
metd["F"]["128"]["H"] = "The number of changed Logical Lines of Code in this file.<br><br>Changes are measured using Power Software's implementation of the GNU diff but instead of comparing lines terminated by newlines, comparison is made between &quot;lines&quot; terminated by semi-colons.<br><br>CHG_LLOC gives you a potentially more accurate estimatation of the extent of changed source code, especially where a single &quot;logical line&quot; spans multiple lines in this file.";

metd["F"]["129"] = new Array();
metd["F"]["129"]["C"] = "DEL_LLOC";
metd["F"]["129"]["N"] = "Deleted Logical Lines of Code";
metd["F"]["129"]["H"] = "The number of deleted Logical Lines of Code in this file.<br><br>Deleted logical lines are counted using Power Software's implementation of the GNU diff but instead of comparing lines terminated by newlines, comparison is made between &quot;lines&quot; terminated by semi-colons.<br><br>DEL_LLOC gives you a potentially more accurate estimatation of the extent of deleted lines in your source code, especially where a single &quot;logical line&quot; spans multiple lines in this file.";

metd["F"]["130"] = new Array();
metd["F"]["130"]["C"] = "ADD_LLOC";
metd["F"]["130"]["N"] = "Added Logical Lines of Code";
metd["F"]["130"]["H"] = "The number of deleted Logical Lines of Code in this file.<br><br>Added logical lines are counted using Power Software's implementation of the GNU diff but instead of comparing lines terminated by newlines, comparison is made between \"lines\" terminated by semi-colons.<br><br>ADD_LLOC gives you a potentially more accurate estimatation of the extent of added lines in your source code, especially where a single &quot;logical line&quot; spans multiple lines in this file.";

metd["F"]["131"] = new Array();
metd["F"]["131"]["C"] = "CRN_LLOC";
metd["F"]["131"]["N"] = "Churn Logical Lines of Code";
metd["F"]["131"]["H"] = "Churn metrics give an overall indicator of the total &quot;change&quot; in logical lines between the new file and the old file.";
metd["F"]["131"]["F"] = "CRN_LLOC = CHG_LLOC + DEL_LLOC + ADD_LLOC";

metd["P"] = new Array();

metd["P"]["100"] = new Array();
metd["P"]["100"]["C"] = "LOC";
metd["P"]["100"]["N"] = "Lines of code";
metd["P"]["100"]["H"] = "Number of Lines in the project, including source, whitespace and comments.<br><br>Effectively, a count of the number of newlines in the project.";

metd["P"]["101"] = new Array();
metd["P"]["101"]["C"] = "SLOC";
metd["P"]["101"]["N"] = "Source lines of code";
metd["P"]["101"]["H"] = "Number of Source lines in the project, excluding whitespace and comments.<br><br>This is not a count of semicolons or distinct statements, but a count of <br>physical lines that contain source code.<br><br>If you are interested in \"logical\" lines, see NSC.<br><br><font face=\"Courier New\">int i=0; float j=0; // This is 1 SLOC<br><br>cout &lt;&lt; \"Testing\"<br>  &lt;&lt; \" Hello\"<br>  &lt;&lt; \" there.\" ;  // This is 3 SLOCs</font>";

metd["P"]["102"] = new Array();
metd["P"]["102"]["C"] = "SLOC_NAT";
metd["P"]["102"]["N"] = "Source Native Lines of Code";
metd["P"]["102"]["H"] = "The number of lines of code in the project containing Native Source.<br><br>Native Source is code that is native to the main language, used when analysing HTML-generating software.";

metd["P"]["103"] = new Array();
metd["P"]["103"]["C"] = "SLOC_TAG";
metd["P"]["103"]["N"] = "Source Tag Lines of Code";
metd["P"]["103"]["H"] = "The number of lines of code in the project containing Tags.<br><br>Tags are used in conjuction with HTML-generating software, such as ASP or JSP.";

metd["P"]["104"] = new Array();
metd["P"]["104"]["C"] = "SLOC_HTM";
metd["P"]["104"]["N"] = "Source HTML Lines of Code";
metd["P"]["104"]["H"] = "The number of lines of code in the project containing HTML.";

metd["P"]["105"] = new Array();
metd["P"]["105"]["C"] = "SLOC_SCR";
metd["P"]["105"]["N"] = "Source Script Lines of Code";
metd["P"]["105"]["H"] = "The number of lines of code in the project containing Script.<br><br>Script in this context means Javascript or VBScript used in HTML source, either a HTML file or HTML-generating source.";

metd["P"]["106"] = new Array();
metd["P"]["106"]["C"] = "PLOC";
metd["P"]["106"]["N"] = "Preprocessor Directive Lines of Code";
metd["P"]["106"]["H"] = "The number of preprocessor directive lines in the project, typically those that begin with a #.  Preprocessor Directive LOC is included as part of SLOC and LOC, but identified separately at the project level for clarity.";

metd["P"]["107"] = new Array();
metd["P"]["107"]["C"] = "LLOC";
metd["P"]["107"]["N"] = "Logical Lines of Code";
metd["P"]["107"]["H"] = "A count of the total number of semicolons in the project excluding those within comments and string literals.  This is useful for approximating &quot;logical lines of code&quot;.  E.g.:<br><br><font face=\"Courier New\">cout &lt;&lt; \"Hello\" &lt;&lt; endl <font color=\"FF1111\">;</font> /* output ; return */<br>cout &lt;&lt; \"Hello ; World\" &lt;&lt; endl <font color=\"FF1111\">;</font></font><br><br>LLOC = 2.";

metd["P"]["108"] = new Array();
metd["P"]["108"]["C"] = "N1";
metd["P"]["108"]["N"] = "Halstead total number of operators";
metd["P"]["108"]["H"] = "The total number of operators in the project.<br><br>N1 is part of the Halstead set, and of little interest on its own.  When combined with the other Halstead fundamental metrics, it can be used to determine Volume, Difficult, Effort and Cyclomatic complexity.";

metd["P"]["109"] = new Array();
metd["P"]["109"]["C"] = "N2";
metd["P"]["109"]["N"] = "Halstead total number of operands";
metd["P"]["109"]["H"] = "The total number of operands in the project.<br><br>N2 is part of the Halstead set, and of little interest on its own.  When combined with the other Halstead fundamental metrics, it can be used to determine Volume, Difficult, Effort and Cyclomatic complexity.";

metd["P"]["110"] = new Array();
metd["P"]["110"]["C"] = "n1";
metd["P"]["110"]["N"] = "Halstead number of unique operators";
metd["P"]["110"]["H"] = "The number of unique or distinct operators in the project.<br><br>n1 is part of the Halstead set, and of little interest on its own.  When combined with the other Halstead fundamental metrics, it can be used to determine Volume, Difficult, Effort and Cyclomatic complexity.";

metd["P"]["111"] = new Array();
metd["P"]["111"]["C"] = "n2";
metd["P"]["111"]["N"] = "Halstead number of unique operands";
metd["P"]["111"]["H"] = "The number of unique or distinct operands in the project.<br><br>n2 is part of the Halstead set, and of little interest on its own.  When combined with the other Halstead fundamental metrics, it can be used to determine Volume, Difficult, Effort and Cyclomatic complexity.";

metd["P"]["112"] = new Array();
metd["P"]["112"]["C"] = "N";
metd["P"]["112"]["N"] = "Halstead program Length";
metd["P"]["112"]["H"] = "Halstead program Length (N) for this project.<br><br>N1 = Total number of Operators<br>N2 = Total number of Operands";
metd["P"]["112"]["F"] = "N = N1 + N2";

metd["P"]["113"] = new Array();
metd["P"]["113"]["C"] = "n";
metd["P"]["113"]["N"] = "Halstead program Vocabulary";
metd["P"]["113"]["H"] = "Halstead program Vocabulary (n) for this project.<br><br>n1 = Number unique or distinct Operators<br>n2 = Number unique or distinct Operands";
metd["P"]["113"]["F"] = "n = n1 + n2";

metd["P"]["114"] = new Array();
metd["P"]["114"]["C"] = "V";
metd["P"]["114"]["N"] = "Halstead program Volume";
metd["P"]["114"]["H"] = "Halstead Volume for the project.";
metd["P"]["114"]["F"] = "V = Nlog<SUB>2</SUB>n";

metd["P"]["115"] = new Array();
metd["P"]["115"]["C"] = "D";
metd["P"]["115"]["N"] = "Halstead program Difficulty";
metd["P"]["115"]["H"] = "A measure of how difficult this project's code is to understand.";
metd["P"]["115"]["F"] = "D = (n1/2) * (N2/n2) <br><br>Where:<br>n1 - the number of distinct operators<br>n2 - the number of distinct operands<br>N1 - the total number of operators <br>N2 - the total number of operands";

metd["P"]["116"] = new Array();
metd["P"]["116"]["C"] = "E";
metd["P"]["116"]["N"] = "Halstead program Effort";
metd["P"]["116"]["H"] = "Effort = Difficulty * Volume for this project.";
metd["P"]["116"]["F"] = "E = D * V";

metd["P"]["117"] = new Array();
metd["P"]["117"]["C"] = "B";
metd["P"]["117"]["N"] = "Halstead Bug Prediction";
metd["P"]["117"]["H"] = "This variant of Halstead Effort is a measure of the likelihood of bugs within the project.";
metd["P"]["117"]["F"] = "(N <i>log</i>n) / 3000";

metd["P"]["118"] = new Array();
metd["P"]["118"]["C"] = "J_COM";
metd["P"]["118"]["N"] = "Java style comments";
metd["P"]["118"]["H"] = "The number of Java style comments  in the project.<br><br>A Java style comment begins <font face=\"Courier New\" color=\"FF1111\">/**</font> and ends <font face=\"Courier New\" color=\"FF1111\">*/</font>. E.g.:<br><br><font face=\"Courier New\"><font color=\"FF1111\">&nbsp;/**<br>&nbsp;&nbsp;* An interface for handling Application level operations.<br>&nbsp;&nbsp;*<br>&nbsp;&nbsp;*/</font><br>&nbsp;public interface ApplicationHandler {</font><br><br>J_COM = 1.";

metd["P"]["119"] = new Array();
metd["P"]["119"]["C"] = "C_COM";
metd["P"]["119"]["N"] = "C style comments";
metd["P"]["119"]["H"] = "The number of C style comments in the project.<br><br>A C style comment begins <font face=\"Courier New\" color=\"FF1111\">/*</font> and ends <font face=\"Courier New\" color=\"FF1111\">*/</font>.<br><br>In the following example C_COM = 1.<br><br><font face=\"Courier New\">int i = 0 ; <font color=\"FF1111\">/* This is a useful<br>variable here for<br>many purposes */</font></font>";

metd["P"]["120"] = new Array();
metd["P"]["120"]["C"] = "EOL_COM";
metd["P"]["120"]["N"] = "To End-of-Line comments";
metd["P"]["120"]["H"] = "The number of to end-of-line comment lines in the project.<br><br>This type of comment begins <font face=\"Courier New\" color=\"FF1111\">//</font> and finishes at the end of the line.<br><br>In the following example EOL_COM=2.<br><br><font face=\"Courier New\">int i = 0 ; <font color=\"FF1111\">// Index variable</font><br>float pi = 3.14 ; <font color=\"FF1111\">// Handy pi variable</font><br>char star = '*' ;</font>";

metd["P"]["121"] = new Array();
metd["P"]["121"]["C"] = "COM_LOC";
metd["P"]["121"]["N"] = "Comment lines of code";
metd["P"]["121"]["H"] = "The total number of lines of comment in the project.";

metd["P"]["122"] = new Array();
metd["P"]["122"]["C"] = "BYTES";
metd["P"]["122"]["N"] = "Number of bytes";
metd["P"]["122"]["H"] = "The total number of bytes in all the files in the project.";

metd["P"]["123"] = new Array();
metd["P"]["123"]["C"] = "NFILE";
metd["P"]["123"]["N"] = "Number of Files";
metd["P"]["123"]["H"] = "The total number of files in the project.";

metd["P"]["124"] = new Array();
metd["P"]["124"]["C"] = "CHG_SLOC";
metd["P"]["124"]["N"] = "Source Lines of Code (Changed)";
metd["P"]["124"]["H"] = "The number of lines that have changed between the old project and the new  project.";
metd["P"]["124"]["F"] = "&#0931; changed file CHG_SLOC";

metd["P"]["125"] = new Array();
metd["P"]["125"]["C"] = "DEL_SLOC";
metd["P"]["125"]["N"] = "Source Lines of Code (Deleted)";
metd["P"]["125"]["H"] = "This gives the total deleted source lines of code between the old and the new project.<br><br>This is the sum of DEL_SLOC for all changed files plus the SLOC of all files deleted from the new project";
metd["P"]["125"]["F"] = "(&#0931; changed file DEL_SLOC ) + (&#0931; SLOC deleted files)";

metd["P"]["126"] = new Array();
metd["P"]["126"]["C"] = "ADD_SLOC";
metd["P"]["126"]["N"] = "Source Lines of Code (Added)";
metd["P"]["126"]["H"] = "This gives the total added source lines of code between the old and the new project.<br><br>This is the sum of ADD_SLOC for all changed files plus the SLOC of all files added to the new project";
metd["P"]["126"]["F"] = "(&#0931; changed file ADD_SLOC ) + (&#0931; SLOC added files)";

metd["P"]["127"] = new Array();
metd["P"]["127"]["C"] = "CRN_SLOC";
metd["P"]["127"]["N"] = "Churn Source Lines of Code";
metd["P"]["127"]["H"] = "Churn metrics give an overall indicator of the total &quot;change&quot; in source lines between the new project and the old project.";
metd["P"]["127"]["F"] = "CRN_SLOC = CHG_SLOC + DEL_SLOC + ADD_SLOC";

metd["P"]["128"] = new Array();
metd["P"]["128"]["C"] = "CHG_LLOC";
metd["P"]["128"]["N"] = "Changed Logical Lines of Code";
metd["P"]["128"]["H"] = "The number of changed Logical Lines of Code in this project.<br><br>Changes are measured using Power Software's implementation of the GNU diff but instead of comparing lines terminated by newlines, comparison is made between \"lines\" terminated by semi-colons.<br><br>CHG_LLOC gives you a potentially more accurate estimatation of the extent of changed source code, especially where a single &quot;logical line&quot; spans multiple lines in the file.";

metd["P"]["129"] = new Array();
metd["P"]["129"]["C"] = "DEL_LLOC";
metd["P"]["129"]["N"] = "Deleted Logical Lines of Code";
metd["P"]["129"]["H"] = "The number of deleted Logical Lines of Code in this project.<br><br>Deleted logical lines are counted using Power Software's implementation of the GNU diff but instead of comparing lines terminated by newlines, comparison is made between &quot;lines&quot; terminated by semi-colons.<br><br>DEL_LLOC gives you a potentially more accurate estimatation of the extent of deleted lines in your source code, especially where a single &quot;logical line&quot; spans multiple lines in the file.";

metd["P"]["130"] = new Array();
metd["P"]["130"]["C"] = "ADD_LLOC";
metd["P"]["130"]["N"] = "Added Logical Lines of Code";
metd["P"]["130"]["H"] = "The number of deleted Logical Lines of Code in this project.<br><br>Added logical lines are counted using Power Software's implementation of the GNU diff but instead of comparing lines terminated by newlines, comparison is made between &quot;lines&quot; terminated by semi-colons.<br><br>ADD_LLOC gives you a potentially more accurate estimatation of the extent of added lines in your source code, especially where a single &quot;logical line&quot; spans multiple lines in the file.";

metd["P"]["131"] = new Array();
metd["P"]["131"]["C"] = "CRN_LLOC";
metd["P"]["131"]["N"] = "Churn Logical Lines of Code";
metd["P"]["131"]["H"] = "Churn metrics give an overall indicator of the total &quot;change&quot; in logical lines between the new project and the old project.";
metd["P"]["131"]["F"] = "CRN_LLOC = CHG_LLOC + DEL_LLOC + ADD_LLOC";

metd["P"]["132"] = new Array();
metd["P"]["132"]["C"] = "CHG_FILE";
metd["P"]["132"]["N"] = "Number of Files (Changed)";
metd["P"]["132"]["H"] = "Number of Files that have been changed between the old project and the new project.<br><br>For example the following would have CHG_FILE=1.<br><br><font face=\"Courier New\"><u>Old Project</u>&#09;&#09;<u>New Project</u><br>sourcefile1&#09;&#09;sourcefile1<br><font color=\"#990000\">sourcefile2&#09;&#09;sourcefile2</font><br><font color=\"#000099\">sourcefile3</font>&#09;&#09;<font color=\"#116611\">sourcefile4</font></font><br><br><u>Color Key</u><br><font color=\"#116611\">Added</font><br><font color=\"#990000\">Changed</font><br><font color=\"#000099\">Deleted</font>";

metd["P"]["133"] = new Array();
metd["P"]["133"]["C"] = "DEL_FILE";
metd["P"]["133"]["N"] = "Number of Files (Deleted)";
metd["P"]["133"]["H"] = "Number of Files that have been deleted between the old project and the new project.<br><br>For example the following would have DEL_FILE=1.<br><br><font face=\"Courier New\"><u>Old Project</u>&#09;&#09;<u>New Project</u><br>sourcefile1&#09;&#09;sourcefile1<br><font color=\"#990000\">sourcefile2&#09;&#09;sourcefile2</font><br><font color=\"#000099\">sourcefile3</font>&#09;&#09;<font color=\"#116611\">sourcefile4</font></font><br><br><u>Color Key</u><br><font color=\"#116611\">Added</font><br><font color=\"#990000\">Changed</font><br><font color=\"#000099\">Deleted</font>";

metd["P"]["134"] = new Array();
metd["P"]["134"]["C"] = "ADD_FILE";
metd["P"]["134"]["N"] = "Number of Files (Added)";
metd["P"]["134"]["H"] = "Number of Files that have been added between the old project and the new project.<br><br>For example the following would have ADD_FILE=1.<br><br><font face=\"Courier New\"><u>Old Project</u>&#09;&#09;<u>New Project</u><br>sourcefile1&#09;&#09;sourcefile1<br><font color=\"#990000\">sourcefile2&#09;&#09;sourcefile2</font><br><font color=\"#000099\">sourcefile3</font>&#09;&#09;<font color=\"#116611\">sourcefile4</font></font><br><br><u>Color Key</u><br><font color=\"#116611\">Added</font><br><font color=\"#990000\">Changed</font><br><font color=\"#000099\">Deleted</font>";

metd["P"]["135"] = new Array();
metd["P"]["135"]["C"] = "CRN_FILE";
metd["P"]["135"]["N"] = "Churn Files";
metd["P"]["135"]["H"] = "Churn metrics give an overall indicator of the total &quot;change&quot; between the new project and the old project.";
metd["P"]["135"]["F"] = "CRN_FILE = CHG_FILE + DEL_FILE + ADD_FILE";

function getObjRef(ref) {
  return document.all ? document.all[ref] : document.getElementById(ref);
}

function smh(itemType, metId) {
  var mhTable = getObjRef("mhTable");
  var mhCode = getObjRef("mhCode");
  var mhName = getObjRef("mhName");
  var mhDesc = getObjRef("mhDesc");
  var mhForm = getObjRef("mhForm");
  var mhFormRow = getObjRef("mhFormRow");

  mhTable.style.display = "inline";
  mhCode.innerHTML = metd[itemType][metId]["C"];
  mhName.innerHTML = metd[itemType][metId]["N"];
  mhDesc.innerHTML = metd[itemType][metId]["H"];

  if (typeof metd[itemType][metId]["F"] != "undefined") {
    mhDesc.innerHTML += "<br><br><b>Formula</b> " + metd[itemType][metId]["F"];
  }

  mhTable.style.left = "250px";
  mhTable.style.top = "120px";
}

function smhClose() {
  var mhTable = getObjRef("mhTable");
  mhTable.style.display = "none";
}


