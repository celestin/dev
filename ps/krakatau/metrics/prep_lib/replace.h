#ifndef REPLACEMENT_HEADER
#define REPLACEMENT_HEADER

#define SIMPLE 0
#define DELIM_APPEND 1
#define DELIM_IGNORE 2
#define PAREN_APPEND 3
#define PAREN_IGNORE 4

class Replacement {

public:

	int type ;

	char *replace_start ;
	char *replace_end ;

	char *with_start ;
	char *with_end ;

	Replacement(const char *rs, const char *ws) {

		type = SIMPLE ;

		replace_start = _strdup(rs) ;
		replace_end = NULL ;

		with_start = _strdup(ws) ;
		with_end = NULL ;

	}

	Replacement(const char *rs, const char *re,
		const char *ws, const char *we) {

		if (we == NULL) {
			type = DELIM_IGNORE ;
		} else {
			type = DELIM_APPEND ;
			with_end = _strdup(we) ;
		}

		replace_start = _strdup(rs) ;
		replace_end = strdup(re) ;

		with_start = _strdup(ws) ;

	}

	Replacement(const char *rs, const char *ws, const char *we) {

		if (we == NULL) {
			type = PAREN_IGNORE ;
		} else {
			type = PAREN_APPEND ;
			with_end = _strdup(we) ;
		}

		replace_start = _strdup(rs) ;

		with_start = _strdup(ws) ;

	}

	~Replacement() {

		free(replace_start) ;
		free(with_start) ;

		if (type==DELIM_APPEND) {
			free(replace_end) ;
			free(with_end) ;
		} else if (type==DELIM_IGNORE) {
			free(replace_end) ;
		} else if (type==PAREN_IGNORE) {
			free(with_end) ;
		}
	}

} ;

#endif