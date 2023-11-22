#language: pt
Funcionalidade: Addition

Rules for basic addition:
- Only non-negative numbers
- The operator has to be specified after both operands have been entered

@tc:44
@story:45
@manual
Cenário: Add two numbers
	Dado que eu adicionei o número 5
	E que eu adicionei o segundo número 7
	Quando eu somar
	Então o resultado deverá ser 12