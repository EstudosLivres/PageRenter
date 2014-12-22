PageRenter
==========
Que tal lucrar com qualquer página na Web? Alugue seu Perfil com PageRenter!!
<br><br>
__Pitch curto__: _Aluguel Social de Marketing Bilateral_ 
<br>
__Pitch longo__: _Rede Social com foco no Consumismo e Compras Coletivas, fazendo tudo que o Facebook faz, mas com o diferencial de que nosso público não é nosso produto, mas sim parceiros._

__Diferenciais perante o BooBox__
1- O BooBox é focado em pessoas que possuem blogs e também só oferece essa opção.
2- Nós temos uma abordagem p/ lojas fisicas entrarem na internet (mapapp) q tá lá no roadmap;
3- nós oferecemos parte dos profissionais
twp qro criar uma campanha e n sei cmo fzr uma peça publicitaria
no boobox vc n tem nenhuma forma d fzr isso, no pagerenter vc vai ter como contratar algm p fzr
saca?
outra coisa tb é a interagração com o meio de pagamento (esse eu ainda n coloquei no roadmap)
q é o seguint, qnt mais vc investir em marketing e qnt mais tiver conversões maior é a chance d vc ganhar um "premio" q é o rents pagar as taxas da transação por vc
qlqr compra na internet tem um custo de X% do operador do cartão (Cielo), variando de 3 a 6%
e o valor do gateway q geralmente é 1% mais 50centavos
ai vc invesitu mt em marketing e converteu mtu
um usuario aleatório seu n vai pagar isso
ou seja se ele vai comprar um macbook de 4mil
ele vai ter ai 7% de desconto, por exemplo, q já é R$280
saca?
outra coisa, uma pagina de redes sociais não pode ganhar dinheiro com o boobox

## Validação da ideia

[Veja no YouTube um exemplo disso (22min até 23:15)](https://www.youtube.com/watch?v=GDm9xL7Q_k8&t=21m40s)

## Observações sobre o Projeto

###### Landing VS App
---------------

* __Landing Page__
  * Feita em __PHP__;
  * Terá um código __Analytic próprio__;
  * hospedagem no Heroku;
  * [Projeto separado](https://github.com/TonGarcia/LandPageRenter);
* __Aplicação em si (App)__
  * Feita em __Rails__;
  * Código __Analytic próprio__;
  * __hospedagem ainda não definida__;
  * Feito com o __tema Bootstrap 2.3.2__;

###### PADRONIZAÇÕES
---------------

* __PROGRAMAÇÃO__:
 * Uso __constante__ do __BDD__;
* __DESIGN__:
 * Uso de cores por role ( __verde__ = publisher; __azul__ = advertiser );


###### GEMS MUITO ÚTEIS
---------------
* RAILS-ERD + GraphViz (precisa instalar a Lib dele no Brew);
* annotate;

## Fluxo de uso

###### ANUNCIANTE
---------------
![image] (https://github.com/TonGarcia/PageRenter/blob/master/modelagens/Ideias&Fluxos/Fluxo-Anunciante.png?raw=true "Fluxo de uso do ANUNCIANTE")

* __ O ANUNCIANTE TEM A OBRIGAÇÃO DE CRIAR A PROPAGANDA E FAZER ELA OTIMIZADA PARA A REDE (TIPO FB E TW) __
* __ O ANUNCIANTE PODE LEILOAR CLICKS (CADA UM DIZ QUANTO PAGA POR CLICK) __

###### PUBLISHER
---------------
![image] (https://github.com/TonGarcia/PageRenter/blob/master/modelagens/Ideias&Fluxos/Fluxo-Publisher.png?raw=true "Fluxo de uso do PUBLISHER")

* __ O PUBLISHER TEM A OBRIGAÇÃO DE PESQUISAR A PROPAGANDA QUE MELHOR SE ADEQUA __

###### MER BD
---------------
![image] (https://github.com/TonGarcia/PageRenter/blob/master/modelagens/BD/MER-PageRenter.png?raw=true "MER")
