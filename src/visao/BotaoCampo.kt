package visao

import modelo.Campo
import modelo.CampoEvento
import java.awt.Color
import java.awt.Font
import javax.swing.BorderFactory
import javax.swing.JButton
import javax.swing.SwingUtilities
import java.awt.Dimension
import java.awt.FontMetrics

// Definimos as cores utilizadas
private val COR_BG_NORMAL = Color(110, 183, 245)
private val COR_BG_ACERTO = Color(0, 100, 255)
private val COR_BG_FUNDO = Color(110, 183, 245)
private val COR_BG_MARCACAO = Color(131, 245, 100)
private val COR_BG_EXPLOSAO = Color(255, 0, 0)
private val COR_TXT_ROXO = Color(0, 209, 255)

class BotaoCampo(private val campo: Campo) : JButton() {

    init {
        background = COR_BG_NORMAL
        isOpaque = true
        border = BorderFactory.createBevelBorder(0)
        addMouseListener(MouseCliqueListener(campo, { it.abrir() }, { it.alterarMarcacao() }))

        campo.onEvento(this::aplicarEstilo)
    }

    override fun setBounds(x: Int, y: Int, width: Int, height: Int) {
        super.setBounds(x, y, width, height)
        ajustarTamanhoFonte(width, height)
    }

    private fun ajustarTamanhoFonte(width: Int, height: Int) {
        val tamanhoFonte = (height * 0.6).toFloat()
        font = font.deriveFont(Font.BOLD, tamanhoFonte)
    }

    private fun aplicarEstilo(campo: Campo, evento: CampoEvento) {
        when (evento) {
            CampoEvento.EXPLOSAO -> aplicarEstiloExplodido()
            CampoEvento.ABERTURA -> aplicarEstiloAberto()
            CampoEvento.MARCACAO -> aplicarEstiloMarcado()
            else -> aplicarEstiloPadrao()
        }

        SwingUtilities.invokeLater {
            repaint()
            validate()
        }
    }

    private fun aplicarEstiloExplodido() {
        background = COR_BG_EXPLOSAO
        text = "️💀"
    }

    private fun aplicarEstiloAberto() {
        background = COR_BG_ACERTO
        border = BorderFactory.createLineBorder(Color.blue)

        if (campo.qtdeVizinhosMinados > 0) {
            foreground = when (campo.qtdeVizinhosMinados) {
                1 -> COR_TXT_ROXO
                2 -> Color.RED
                3 -> Color.YELLOW
                4, 5, 6 -> Color.BLACK
                else -> Color.WHITE
            }
            text = campo.qtdeVizinhosMinados.toString()
        } else {
            text = ""
        }
    }

    private fun aplicarEstiloMarcado() {
        background = COR_BG_MARCACAO
        foreground = Color.BLACK
        text = "🐢"
    }

    private fun aplicarEstiloPadrao() {
        background = COR_BG_FUNDO
        border = BorderFactory.createBevelBorder(0)
        text = ""
    }
}
