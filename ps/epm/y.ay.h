/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * TI Assembler Parser lexemes
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  14-Apr-2009  10402 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#define KEY_ALGEBRAIC                 256
#define KEY_ALIGN                     257
#define KEY_ASG                       258
#define KEY_BES                       259
#define KEY_BREAK                     260
#define KEY_BSS                       261
#define KEY_BYTE                      262
#define KEY_C_MODE                    263
#define KEY_CHAR                      264
#define KEY_CLINK                     265
#define KEY_COPY                      266
#define KEY_DATA                      267
#define KEY_DEF                       268
#define KEY_DOUBLE                    269
#define KEY_DRLIST                    270
#define KEY_DRNOLIST                  271
#define KEY_ELSE                      272
#define KEY_ELSEIF                    273
#define KEY_EMSG                      274
#define KEY_END                       275
#define KEY_ENDIF                     276
#define KEY_ENDLOOP                   277
#define KEY_ENDM                      278
#define KEY_ENDSTRUCT                 279
#define KEY_ENDUNION                  280
#define KEY_EQU                       281
#define KEY_EVAL                      282
#define KEY_EVEN                      283
#define KEY_FAR_MODE                  284
#define KEY_FCLIST                    285
#define KEY_FCNOLIST                  286
#define KEY_FIELD                     287
#define KEY_FLOAT                     288
#define KEY_GLOBAL                    289
#define KEY_HALF                      290
#define KEY_IF                        291
#define KEY_INCLUDE                   292
#define KEY_INT                       293
#define KEY_LABEL                     294
#define KEY_LDOUBLE                   295
#define KEY_LENGTH                    296
#define KEY_LIST                      297
#define KEY_LONG                      298
#define KEY_LOOP                      299
#define KEY_MACRO                     300
#define KEY_MEXIT                     301
#define KEY_MLIB                      302
#define KEY_MLIST                     303
#define KEY_MMREGS                    304
#define KEY_MMSG                      305
#define KEY_MNOLIST                   306
#define KEY_NEWBLOCK                  307
#define KEY_NOLIST                    308
#define KEY_NOREMARK                  309
#define KEY_OPTION                    310
#define KEY_PAGE                      311
#define KEY_PSTRING                   312
#define KEY_REF                       313
#define KEY_REMARK                    314
#define KEY_SBLOCK                    315
#define KEY_SECT                      316
#define KEY_SET                       317
#define KEY_SHORT                     318
#define KEY_SPACE                     319
#define KEY_SSLIST                    320
#define KEY_SSNOLIST                  321
#define KEY_STRING                    322
#define KEY_STRUCT                    323
#define KEY_TAB                       324
#define KEY_TAG                       325
#define KEY_TEXT                      326
#define KEY_TITLE                     327
#define KEY_UBYTE                     328
#define KEY_UCHAR                     329
#define KEY_UHALF                     330
#define KEY_UINT                      331
#define KEY_ULONG                     332
#define KEY_UNION                     333
#define KEY_USHORT                    334
#define KEY_UWORD                     335
#define KEY_VAR                       336
#define KEY_VERSION                   337
#define KEY_WIDTH                     338
#define KEY_WMSG                      339
#define KEY_WORD                      340
#define KEY_XFLOAT                    341
#define KEY_XLONG                     342
#define KEY_USECT                     343
#define SYM_COLON                     344
#define SYM_PERIOD                    345
#define SYM_COMMA                     346
#define SYM_HASH                      347
