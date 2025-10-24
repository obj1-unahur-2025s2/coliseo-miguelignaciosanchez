import armasYArmaduras.*
import gladiadoresYGrupos.*

object coliseo {
    method organizarCombate(participante1, participante2) {
        participante1.combatirContraGrupo(participante2)
    }
    method curar(gladiador) {
        gladiador.vida(100)
    }
    method curarGrupo(grupo) {
        grupo.gladiadores().forEach({ gladiador => gladiador.vida(100) })
    }
}