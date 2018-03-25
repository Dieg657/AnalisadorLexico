%{
/* Definição para a Linguagem C, 
 Aqui é a parte onde fica definido as variáveis, includes, defines, e constantes, tudo que está aqui nesta seção vai diretamente pro código da linguagem C*/

#include <stdio.h>
#include <stdlib.h>

int n_linhas = 0; //Conta o numero de linhas

%}

/*
 * Expressões Regulares 
 * DIGITO - Verifica numeros de 0 a 9
 * SIMBOLO - Avalia se a palavra contem os simbolos especificos: =, +, -, *, /, (, ) 
*/ 

DIGITO [0-9]
SIMBOLO [\w=+-*/()]



/* Regras de Tradução  Aqui é onde fica definido as regras de tradução das expressões regulares definidas nesta parte, e cada expressão regular tem um sub-programa que define a ação a ser tomada quando o padrão definido (na expressão regular) é reconhecido*/

%%
{DIGITO}+   		      {printf("Encontrado um Token de um numero TOKEN de INTEIRO: %d\n", atoi(yytext));}
{DIGITO}+"."{DIGITO}+     {printf("Encontrado um Token de um numero TOKEN de REAL: %f\n", atof(yytext));}
"="			              {printf("Encontrado um Token de TOKEN DE IGUAL: %s\n", yytext);}
"+"			              {printf("Encontrado um Token de TOKEN DE SOMA: %s\n", yytext);;}
"-"			              {printf("Encontrado um Token de TOKEN DE SUBTRAÇÃO: %s\n", yytext);}
"*"			              {printf("Encontrado um Token de TOKEN DE MULTIPLICAÇÃO: %s\n", yytext);}
"/"			              {printf("Encontrado um Token de TOKEN DE DIVISÃO: %s\n", yytext);}
"("			              {printf("Encontrado um Token de TOKEN ABER_PARENTESES: %s\n", yytext);}
")"			              {printf("Encontrado um Token de TOKEN FECH_PARENTESES: %s\n", yytext);}
"\n"			          {n_linhas++;}
.                         {printf("Encontrado um caractere inesperado: %s\n", yytext);} 
%%

void main (int argc, char **argv){
	FILE *arquivoFormulas = fopen("entrada.txt","r");
	if(!arquivoFormulas){
		printf("Não foi possivel abrir o arquivo!\n");
	}
	yyin = arquivoFormulas;
	yylex();
	printf("\n Numero de linhas analisadas: %d\n", n_linhas);
}

