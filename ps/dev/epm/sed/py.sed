s/j_comments/j_comments_py/g
s/c_comments/c_comments_py/g
s/cpp_comments/cpp_comments_py/g
s/com_loc/com_loc_py/g
s/prev_com_line/prev_com_line_py/g
s/comment_skip/comment_skip_py/g
s/lexclear/lexclear_py/g
s/nsemi/nsemi_py/g
s/operands/operands_py/g
s/operators/operators_py/g
s/sloc/sloc_py/g
s/slnat/slnat_py/g
s/slhtm/slhtm_py/g
s/slscr/slscr_py/g
s/store_operand/store_operand_py/g
s/store_operator/store_operator_py/g
s/yy_buffer_state/yy_buffer_state_py/g
s/yy_load_buffer_state/yy_load_buffer_state_py/g
s/yy_switch_to_buffer/yy_switch_to_buffer_py/g
s/yyin/yyin_py/g
s/yyleng/yyleng_py/g
s/yylex/yylex_py/g
s/yyout/yyout_py/g
s/yyrestart/yyrestart_py/g
s/yytext/yytext_py/g
s/yywrap/yywrap_py/g
/#include <unistd.h>/d
s/isatty(/_isatty(/g
s/fileno(/_fileno(/g
s/read(/_read(/g
