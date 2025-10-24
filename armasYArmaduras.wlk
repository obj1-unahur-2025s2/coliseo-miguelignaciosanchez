// Armas 
class ArmaFilo {
    const property filo // entre 0 y 1
    const property longitud // en cm   
    method poderAtaque() = filo * longitud
}
class ArmaContundente {
    const property peso
    method poderAtaque() = peso
}
// Armaduras 
class Casco {
    method puntosArmadura(gladiador) = 10
}
class Escudo {
    method puntosArmadura(gladiador) = 5 + gladiador.destreza() * 0.1
}