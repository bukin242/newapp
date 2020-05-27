# Решение

* "Masha pila sok" => 5, 4, 3 => ( 3 ^ 4 ) ^ 5 => 3486784401

`"Masha pila sok".split(" ").reverse.map(&:size).inject{ |m, n| m**n }`
