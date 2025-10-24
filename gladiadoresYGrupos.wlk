import armasYArmaduras.*
// Mirmillon 
class Mirmillon {
    var property vida = 100
    const property fuerza
    const property destreza = 15
    var property arma
    var property armadura
    method poderAtaque() = arma.poderAtaque() + fuerza
    method defensa() = armadura.puntosArmadura(self) + destreza
    method atacar(enemigo) {
        const daño = 0.max(self.poderAtaque() - enemigo.defensa())
        enemigo.recibirDaño(daño)
    }
    method recibirDaño(daño) {
        vida = 0.max(vida - daño)
    }
    method estaMuerto() = vida <= 0
    method puedeCombatir() = not self.estaMuerto()
    method pelearCon(enemigo) {
        self.atacar(enemigo)
        if (not enemigo.estaMuerto()) {
            enemigo.atacar(self)
        }
    }
    method crearGrupoCon(otroGladiador) {
        return new Grupo(
            nombre = "mirmillolandia",
            gladiadores = [self, otroGladiador]
        )
    }
    method combatirContraGrupo(grupo) {
         grupo.combatirContraGladiador(self)
    }
}

// Dimachaerus 

class Dimachaerus {
    var property vida = 100
    const property fuerza = 10
    var property destreza
    const property armas = []
    method poderAtaque() = fuerza + armas.sum({ arma => arma.poderAtaque() })
    method defensa() = destreza / 2
    method atacar(enemigo) {
        const daño = 0.max(self.poderAtaque() - enemigo.defensa())
        enemigo.recibirDaño(daño)
        destreza += 1
    }
    method recibirDaño(daño) {
        vida = 0.max(vida - daño)
    }
    method estaMuerto() = vida <= 0
    method puedeCombatir() = not self.estaMuerto()
    method pelearCon(enemigo) {
        self.atacar(enemigo)
        if (not enemigo.estaMuerto()) {
            enemigo.atacar(self)
        }
    }
    method agregarArma(arma) {
        armas.add(arma)
    }
    method crearGrupoCon(otroGladiador) {
        const sumaPoder = self.poderAtaque() + otroGladiador.poderAtaque()
        return new Grupo(
            nombre = "D-" + sumaPoder,
            gladiadores = [self, otroGladiador]
        )
    }
    method combatirContraGrupo(grupo) {
         grupo.combatirContraGladiador(self)
    }
}

// Grupo 
class Grupo {
    const property nombre
    const property gladiadores = []
    var property peleasParticipadas = 0
    method agregarGladiador(gladiador) {
        gladiadores.add(gladiador)
    }
    method quitarGladiador(gladiador) {
        gladiadores.remove(gladiador)
    }
    method campeon() {
        return gladiadores
            .filter({ g => g.puedeCombatir() })
            .max({ g => g.poderAtaque() })
    }
    method combatirContraGrupo(otroGrupo) {
        3.times({ _ => self.pelearRound(otroGrupo) })
        peleasParticipadas += 1
        otroGrupo.incrementarPeleas()
    }
    method pelearRound(otroGrupo) {
        const miCampeon = self.campeon()
        const suCampeon = otroGrupo.campeon()
        miCampeon.pelearCon(suCampeon)
    }
    method incrementarPeleas() {
        peleasParticipadas += 1
    }
    method combatirContraGladiador(gladiador) {
        3.times({ _ => self.pelearRoundContra(gladiador) })
        peleasParticipadas += 1
    }
    method pelearRoundContra(gladiador) {
        const miCampeon = self.campeon()
        miCampeon.pelearCon(gladiador)
    }
}
