%{
    //DEFINITIONS

    typedef struct{
        int code;
        int position;
        }PIF;
    
    PIF pif_array[1000];
    int pif_length = 0;


    typedef struct{
        char name[20];
    }ST;

    ST st_array[100];    
    int st_length = 0;

    void add_to_pif(int code, int position){
        pif_array[pif_length].code = code;
        pif_array[pif_length].position = position;
        pif_length++;
    }

    void add_to_st(char* ch, int code){
        int ok = 0 ;
        int i = 0;

        while(i < st_length){
            if(strcmp(st_array[i].name,ch)==0){
                ok = 1;
                add_to_pif(code,i);
            }
            i++;
    }

        if (ok == 0){
            strcpy(st_array[st_length].name,ch);
            add_to_pif(code,st_length);
            st_length++;
    }
}

    void show_pif(){
        int t;
        for(t=0;t<pif_length;t++){
            if(pif_array[t].code != 0 && pif_array[t].code != 1){
            printf("%d | -1 \n",pif_array[t].code);
            }
            else{
            printf("%d | %d \n",pif_array[t].code,pif_array[t].position);
            }
        }
    }


void show_st(){
    int i;
    for(i = 0 ;i<st_length;i++)
        printf("%s | %d \n", st_array[i].name , i);
    printf("\n");
}

void show(){
    printf("ST\n");
    show_st();
    printf("PIF\n");
    show_pif();
}
    

%}

%option noyywrap
DIGIT 		[0-9]
ID      [a-z][a-z0-9]*


%%
{DIGIT}+                                {  add_to_st( yytext, 1 );}
{DIGIT}+"."{DIGIT}*                     {  add_to_st( yytext, 1 );}
"'"+{ID}+"'"                                  {  add_to_st( yytext, 1 );}

\identifier                             add_to_pif(0,0);
\constant                             add_to_pif(1,0);
PROGRAM                               add_to_pif(2,0);
CHAR                                  add_to_pif(3,0);
STRING                                    add_to_pif(4,0);
VAR                                  add_to_pif(5,0);
INT                                    add_to_pif(6,0);
REAL                                     add_to_pif(7,0);
BOOL                                     add_to_pif(8,0);
BEGIN                                     add_to_pif(9,0);
END                                      add_to_pif(10,0);
READ                                      add_to_pif(11,0);
WRITE                                    add_to_pif(12,0);
FOR                                     add_to_pif(13,0);
TO                                     add_to_pif(14,0);
DO                                      add_to_pif(15,0);
IF                                      add_to_pif(16,0);
THEN                                     add_to_pif(17,0);
ELSE                                     add_to_pif(18,0);
AND                                      add_to_pif(19,0);
OR                                      add_to_pif(20,0);
NOT                                     add_to_pif(21,0);
\:                                      add_to_pif(22,0);
\;                                      add_to_pif(23,0);
\,                                      add_to_pif(24,0);
\.                                      add_to_pif(25,0);
\+                                      add_to_pif(26,0);
\*                                    add_to_pif(27,0);
\(                                     add_to_pif(28,0);
\)                                add_to_pif(29,0);
\[                                     add_to_pif(30,0);
\]                                     add_to_pif(31,0);
\-                                     add_to_pif(32,0);
\<                                     add_to_pif(33,0);
\>                                     add_to_pif(34,0);
\=                                    add_to_pif(35,0);
\:=                                    add_to_pif(36,0);
\%                                   add_to_pif(37,0);
\/                                    add_to_pif(38,0);
\<=                                    add_to_pif(39,0);
\>=                                   add_to_pif(40,0); 
\!                                    add_to_pif(41,0);
\!=                                    add_to_pif(42,0);
\==                                    add_to_pif(43,0);
\{                                  add_to_pif(44,0);
\}                                    add_to_pif(45,0);
\_                                   add_to_pif(46,0);
\WHILE                                   add_to_pif(46,0);
\"                                   add_to_pif(47,0);
{ID}                                    add_to_st( yytext, 0);

[ \t\n]+             ;/* eat up whitespace */

. {
  if(yytext[0] != 13) {
    printf("Lexical error %s or %d \n",yytext,yytext[0]);
  }
}



%%

//USER CODE SECTION 

int main( argc, argv )
int argc;
char **argv;
    {
        ++argv, --argc;	/* skip over program name */
        if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
        else
            yyin = stdin;
    yylex();
    show();
    }

#ifndef yywrap
   int yywrap() { return 1; }
   #endif