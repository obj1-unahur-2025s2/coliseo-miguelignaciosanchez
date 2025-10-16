import gladiadoresYGrupos.*

object coliseo {
    method entidadParaCombate(participante) {
        if (participante.combatirContra() != null) {
            return participante
        }
        if (participante.pelearCon() != null) {
            return new GladiadorSolitario(gladiador = participante)
        }
        throw new DomainException(message = "Participante inválido para combate")
    }
    method organizarCombate(participante1, participante2) {
        const p1 = self.entidadParaCombate(participante1)
        const p2 = self.entidadParaCombate(participante2)
        p1.combatirContra(p2)
    }
    method curar(participante) {
        if (participante.curarGladiadores() != null) {
            participante.curarGladiadores()
            return
        }
        if (participante.curar() != null) {
            participante.curar()
            return
        }
        throw new DomainException(message = "Participante inválido para curación")
    }
}

class GladiadorSolitario {
    const property gladiador
    var property peleasParticipadas = 0
    method campeon() = gladiador
    method combatirContra(oponente) {
        peleasParticipadas += 1
        if (oponente.incrementarPeleas() != null) {
            oponente.incrementarPeleas()
        }
        3.times({ _ => self.round(oponente) })
    }
    method round(oponente) {
        if (gladiador.estaVivo() && oponente.tieneGladiadoresVivos()) {
            const suCampeon = oponente.campeon()
            gladiador.pelearCon(suCampeon)
        }
    }
    method tieneGladiadoresVivos() = gladiador.estaVivo()
    method incrementarPeleas() { peleasParticipadas += 1 }
    method curarGladiadores() { gladiador.curar() }
}
