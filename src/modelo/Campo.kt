package modelo

import java.util.*

enum class CampoEvento { ABERTURA, MARCACAO, DESMARCACAO, EXPLOSAO, REINICIALIZACAO, TIMER, GAME_OVER }

data class Campo(val linha: Int, val coluna: Int) {

    private val vizinhos = ArrayList<Campo>()
    private val callbacks = ArrayList<(Campo, CampoEvento) -> Unit>()

    var marcado: Boolean = false
    var aberto: Boolean = false
    var minado: Boolean = false

    // Somente leitura
    val desmarcado: Boolean get() = !marcado
    val fechado: Boolean get() = !aberto
    val seguro: Boolean get() = !minado
    val objetivoAlcancado: Boolean get() = seguro && aberto || minado && marcado
    val qtdeVizinhosMinados: Int get() = vizinhos.filter { it.minado }.size
    val vizinhancaSegura: Boolean
        get() = vizinhos.all { it.seguro }

    private var timer: Timer? = null
    private var jogoEmAndamento = true

    fun addVizinho(vizinho: Campo) {
        vizinhos.add(vizinho)
    }

    fun onEvento(callback: (Campo, CampoEvento) -> Unit) {
        callbacks.add(callback)
    }

    fun abrir() {
        if (fechado && jogoEmAndamento) {
            aberto = true
            if (minado) {
                callbacks.forEach { it(this, CampoEvento.EXPLOSAO) }
                jogoEmAndamento = false
                pararTimer()
            } else {
                if (verificarVitoria()) {
                    callbacks.forEach { it(this, CampoEvento.TIMER) }
                    jogoEmAndamento = false
                    pararTimer()
                }
                callbacks.forEach { it(this, CampoEvento.ABERTURA) }
                if (qtdeVizinhosMinados == 0) {
                    vizinhos.filter { it.fechado && it.seguro }.forEach { it.abrir() }
                }
            }
        }
    }

    fun alterarMarcacao() {
        if (fechado) {
            marcado = !marcado
            val evento = if (marcado) CampoEvento.MARCACAO else CampoEvento.DESMARCACAO
            callbacks.forEach { it(this, evento) }
        }
    }

    fun minar() {
        minado = true
    }

    fun reiniciar() {
        aberto = false
        minado = false
        marcado = false
        jogoEmAndamento = true
        callbacks.forEach { it(this, CampoEvento.REINICIALIZACAO) }
        pararTimer()
    }

    fun iniciarTimer() {
        pararTimer()
        timer = Timer()
        timer?.schedule(object : TimerTask() {
            override fun run() {
                if (jogoEmAndamento) {
                    callbacks.forEach { it(this@Campo, CampoEvento.GAME_OVER) }
                    jogoEmAndamento = false
                    pararTimer()
                }
            }
        }, 5 * 120 * 1000)
    }

    fun pararTimer() {
        timer?.cancel()
        timer = null
    }

    private fun verificarVitoria(): Boolean {
        return vizinhos.all { it.objetivoAlcancado }
    }
}
