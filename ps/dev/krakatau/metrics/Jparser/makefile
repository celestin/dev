.cpp.o:
	  g++ -O3 -c $< -o $@ -I.
#.c.o:
#	  g++ -O3 -c $< -o $@ -I.

jparser : grammar_nonterminals.o grammar_terminals.o jil.o lex.yy.o lexical_analysis.o main.o
	  g++ -O3 grammar_nonterminals.o grammar_terminals.o jil.o lex.yy.o lexical_analysis.o main.o -o jparser

grammar_nonterminals.o: grammar_nonterminals.cpp
	g++ -O3 -c grammar_nonterminals.cpp

grammar_terminals.o: grammar_terminals.cpp
	g++ -O3 -c grammar_terminals.cpp

jil.o: jil.cpp
	g++ -O3 -c jil.cpp

lex.yy.o: lex.yy.cpp
	g++ -O3 -c lex.yy.cpp

lex.yy.cpp: jlexer.l
	flex -f jlexer.l
	mv lex.yy.c lex.yy.cpp

lexical_analysis.o: lexical_analysis.cpp
	g++ -O3 -c lexical_analysis.cpp

main.o: main.cpp
	g++ -O3 -c main.cpp




