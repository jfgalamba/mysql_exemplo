"""
    Metacaracteres: Caracteres com um significado especial

    ^ : Âncora início de string/linha

    $ : Âncora fim de string/linha

    + : Quantificador: UMA ou mais ocorrências da expressão anterior 
        (ie, à esquerda do mais) <=> {1,} 

    * : Quantificador: ZERO ou mais ocorrências da expressão anterior 
        (ie, à esquerda do asterisco) <=> {0,}

    ? : Quantificador: ZERO ou UMA ocorrências da expressão anterior 
        (ie, à esquerda do ponto de interrogação) <=> {0, 1} 


    {A,B} : Quantificador: número de ocorrências entre A e B
            Exemplo:  'ab{3,7}'   => três a sete ocorrências de 'b'
            Exemplo:  '(aa){3,7}' => três a sete ocorrências de 'aa'
            Exemplo:  'z{3,}'     => pelo menos três ocorrências de 'z'
            Exemplo:  'z{,7}'     => no máximo sete ocorrências de 'z'
            Exemplo:  'z{7}'      => exactamente sete ocorrências de 'z'

    [ ] :   Classe de caracteres
            Exemplo: 'a[xy]b'     => aceita 'axb', 'ayb'
                                    => não aceita 'ab', 'axyb', 'ayxb'
            Exemplo: 'a[xy]{2}b'  => aceita 'axxb', 'axyb', 'ayyb', 'ayxb'
                                    => não aceita 'ab', 'axb', 'ayb'
            Exemplo: 'a[F-J]b'    => aceita 'aFb', 'aGb', 'aHb', etc.
            Exemplo: 'a[F-J1-3]b' => aceita 'aFb', 'aGb', 'aHb', etc, 'a1b', 'a2b', ...

    [^ ] : Classe "negada" caracteres que não podem ocorrer
            
    .  :    Um qualquer caractere

    |  :    Ou
"""

def valida_matricula1(matr: str) -> bool:
    """
    DD-LL-DD
    """
    partes = matr.split('-')
    return (len(partes) == 3
            and len(partes[0]) == 2 and partes[0].isdigit()
            and len(partes[2]) == 2 and partes[2].isdigit()
            and len(partes[1]) == 2 and partes[1].isalpha() and partes[1] == partes[1].upper())

import re

def valida_matricula2(matr: str) -> bool:
    """
    DD-LL-DD
    """
    return bool(re.search(r'^[0-9]{2}-[A-Z]{2}-[0-9]{2}$', matr))
