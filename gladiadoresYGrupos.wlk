import armasYArmaduras.*
// Clase base
class Gladiador {
    var property vida = 100
    var property destreza = 0
    method estaVivo() = vida > 0
    method recibirDaño(daño) { vida = (vida - daño).max(0) }
    method curar() { vida = 100 }
    method puedeCombatir() = self.estaVivo()
    method destreza() = destreza
    method poderAtaque()
    method defensa()
    method atacar(enemigo)
    method crearGrupoCon(otroGladiador, nombre) =
        new Grupo(
            nombre = nombre,
            gladiadores = #{ self, otroGladiador }
        )
    method pelearCon(enemigo) {
        self.atacar(enemigo)
        if (enemigo.estaVivo()) {
            enemigo.atacar(self)
        }
    }
}

// Mirmillón
class Mirmillon inherits Gladiador {
    const property fuerza
    var property arma = null
    var property armadura = null
    override method destreza() = 15
    method cambiarArma(nuevaArma) { arma = nuevaArma }
    method cambiarArmadura(nuevaArmadura) { armadura = nuevaArmadura }
    override method poderAtaque() {
        const poderArma = if (arma != null) arma.poder() else 0
        return poderArma + fuerza
    }
    override method defensa() {
        const puntosArmadura = if (armadura != null) armadura.puntos(self) else 0
        return puntosArmadura + self.destreza()
    }
    override method atacar(enemigo) {
        const daño = (self.poderAtaque() - enemigo.defensa()).max(0)
        enemigo.recibirDaño(daño)
    }
    override method crearGrupoCon(otroGladiador, nombre) =
        new Grupo(
            nombre = "mirmillolandia",
            gladiadores = #{ self, otroGladiador }
        )
}

// Dimachaerus
class Dimachaerus inherits Gladiador {
    var property armas = #{}
    method fuerza() = 10
    method agregarArma(arma) { armas.add(arma) }
    method quitarArma(arma) { armas.remove(arma) }
    override method poderAtaque() = 10 + armas.sum({ a => a.poder() })
    override method defensa() = self.destreza() / 2
    override method atacar(enemigo) {
        const daño = (self.poderAtaque() - enemigo.defensa()).max(0)
        enemigo.recibirDaño(daño)
        destreza += 1
    }
    override method crearGrupoCon(otroGladiador, nombre) {
        const sumaPoder = self.poderAtaque() + otroGladiador.poderAtaque()
        return new Grupo(
            nombre = "D-" + sumaPoder.toString(),
            gladiadores = #{ self, otroGladiador }
        )
    }
}

// Grupo
class Grupo {
    const property nombre
    const property gladiadores = #{}
    var property peleasParticipadas = 0
    method agregarGladiador(gladiador) { gladiadores.add(gladiador) }
    method quitarGladiador(gladiador) { gladiadores.remove(gladiador) }
    method gladiadoresVivos() = gladiadores.filter({ g => g.estaVivo() })
    method tieneGladiadoresVivos() = !self.gladiadoresVivos().isEmpty()
    method campeon() {
        const vivos = self.gladiadoresVivos()
        if (vivos.isEmpty()) {
            throw new DomainException(message = "No hay gladiadores vivos en el grupo")
        }
        return vivos.max({ g => g.poderAtaque() })
    }
    method combatirContra(otroGrupo) {
        peleasParticipadas += 1
        otroGrupo.incrementarPeleas()
        3.times({ _ => self.round(otroGrupo) })
    }
    method round(otroGrupo) {
        if (self.tieneGladiadoresVivos() && otroGrupo.tieneGladiadoresVivos()) {
            const miCampeon = self.campeon()
            const suCampeon = otroGrupo.campeon()
            miCampeon.pelearCon(suCampeon)
        }
    }
    method incrementarPeleas() { peleasParticipadas += 1 }
    method curarGladiadores() {
        gladiadores.forEach({ g => g.curar() })
    }
}

