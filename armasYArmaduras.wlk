// ARMAS
class ArmaFilo {
    const property filo // número entre 0 y 1
    const property longitud // en centímetros
    method poder() = filo * longitud
}
class ArmaContundente {
    const property peso
    method poder() = peso
}
// ARMADURAS
class Casco {
    method puntos(gladiador) = 10
}
class Escudo {
    method puntos(gladiador) = 5 + (gladiador.destreza() * 0.1)
}