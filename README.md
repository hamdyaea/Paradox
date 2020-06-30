https://fr.wikipedia.org/wiki/Compression_de_donn%C3%A9es_universelle     

Compression de données universelle

Un compresseur sans perte universel ne peut pas exister. Plus précisément, pour tout compresseur sans perte, on est certain que :

il est impossible de compresser strictement tous les mots ;
s'il existe un mot qui est strictement compressé alors il existe un autre mot dont la version compressée est strictement plus grande que le mot lui-même ;
pour n'importe quel mot de départ auquel on applique de manière répétée le compresseur, on est nécessairement dans l'iiun des cas de figure suivants :
soit une suite de mots se répète infiniment, soit les mots successifs obtenus atteignent des tailles arbitrairement grandes.

Ces propriétés sont démontrées ci-après. Cependant, elles n'enlèvent rien à l'intérêt des compresseurs sans perte. En effet, dans la pratique, les mots, messages ou fichiers que l'on souhaite compresser ne sont pas quelconques et choisis aléatoirement parmi tous les mots, messages ou fichiers possibles. Les compresseurs se servent de leurs particularités. Des compresseurs seront alors très bons avec certains types de données, et très mauvais avec d'autres.

Ainsi pour ces types de compresseurs spécialisés, l'information fournie par le contexte est utilisée pour la compression (voir théorie de l'information).
                            
Sommaire

1 Expérimentation
2 Preuve mathématique
3 Voir aussi
3.1 Articles connexes
3.2 Liens externes

Expérimentation

On peut aisément vérifier expérimentalement cette impossibilité. Voici un script shell qui crée un fichier comportant 100 fois la ligne "blabla" puis qui effectue 100 compressions successives de ce fichier à l'aide du compresseur gzip et enfin affiche les tailles successives obtenues :

for i in `seq 1 100`; do echo "blabla" >> toto001; done
for i in `seq 1 100`; do gzip -c "toto`printf "%03d" $i`" > "toto`printf "%03d" $((i+1))`"; done
wc -c toto*

On vérifie souvent en pratique qu'un fichier qui est déjà le résultat d'une compression se compresse mal, voire grossit par application du compresseur. D'ailleurs, gzip refuse par défaut de compresser les fichiers comportant l'extension ".gz" qui est le signe d'une précédente application de ce compresseur.

Preuve mathématique

Un compresseur sans perte peut être vu comme une injection des mots dans les mots, c'est-à-dire une fonction C telle que

C ( u  ) = C ( v  )  implique u = v.

On vérifie alors aisément que, pour tout mot u, l'un des deux cas suivants est vérifié :

laa suite ( C n ( u  )  ) n {\displaystyle (C^{n}(u))_{n}} {\displaystyle (C^{n}(u))_{n}} est périodique,
a suite ( C n ( u  )  ) n {\displaystyle (C^{n}(u))_{n}} {\displaystyle (C^{n}(u))_{n}} ne contient jamais deux fois le même mot et donc pour tout entier N ∈ N {\displaystyle N\in \mathbb {N} } {\displaystyle N\in \mathbb {N} } il existe un entier k {\displaystyle k} k tel que le mot C k ( u  ) {\displaystyle C^{k}(u)} {\displaystyle C^{k}(u)} est de taille supérieure à N {\displaystyle N} N.

Ceci montre la troisième propriété de l'impossibilité énoncée ci-dessus. Les deux premières en découlent car, s'il y a compression stricte, c'est-à-dire s'il existe un mot u {\displaystyle u} u plus grand que sa version compressée C ( u  ) {\displaystyle C(u)} {\displaystyle C(u)}, alors :

soit u {\displaystyle u} u est dans un cycle de longueur k {\displaystyle k} k et il existe i ≤ k − 1 {\displaystyle i\leq k-1} {\displaystyle i\leq k-1} tel que le mot C i ( u  ) {\displaystyle C^{i}(u)} {\displaystyle C^{i}(u)} est strictement plus petit que sa version compressée C i + 1 ( u  ) {\displaystyle C^{i+1}(u)} {\displaystyle C^{i+1}(u)},
                                                                            soit la suite ( C n ( u  )  ) n {\displaystyle (C^{n}(u))_{n}} {\displaystyle (C^{n}(u))_{n}} ne contient jamais deux fois le même mot donc elle contient un mot strictement plus petit que sa version compressée (car on ne peut pas avoir une suite infinie décroissante, au sens large, de mots tous distincts).

On peut remarquer par ailleurs qu'il est impossible de compresser strictement tous les mots d'une taille N {\displaystyle N} N donnée : en effet il y a a N {\displaystyle a^{N}} a^N mots de taille N {\displaystyle N} N pour un alphabet à a {\displaystyle a} a lettres et seulement a N − 1 a − 1 {\displaystyle {\frac {a^{N}-1}{a-1}}} {\displaystyle {\frac {a^{N}-1}{a-1}}} mots avec strictement moins de N
                                                                            {\displaystyle N} N lettres. 
