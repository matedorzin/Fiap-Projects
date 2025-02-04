package visao

import modelo.Tabuleiro
import modelo.TabuleiroEvento
import java.awt.BorderLayout
import java.awt.Font
import java.awt.Color
import java.awt.Dimension
import java.awt.Image
import java.util.*
import java.util.Timer
import javax.swing.*

fun main(args: Array<String>) {
    TelaPrincipal()
}

class TelaPrincipal : JFrame() {
    private var tabuleiro: Tabuleiro? = null
    private var painelTabuleiro: PainelTabuleiro? = null
    private lateinit var labelTimer: JLabel
    private var tempoRestante = 120
    private var timer: Timer? = null

    init {
        setupMenu()
        setIconImage()
    }

    private fun setupMenu() {
        val menuPanel = JPanel()
        menuPanel.layout = BoxLayout(menuPanel, BoxLayout.Y_AXIS)
        menuPanel.border = BorderFactory.createEmptyBorder(50, 50, 50, 50)
        menuPanel.background = Color(60, 63, 65)

        val titleLabel = JLabel("Campo Minado")
        titleLabel.font = Font("Arial", Font.BOLD, 28)
        titleLabel.foreground = Color.WHITE
        titleLabel.alignmentX = CENTER_ALIGNMENT

        val buttonStart = JButton("Iniciar Jogo")
        buttonStart.font = Font("Arial", Font.PLAIN, 18)
        buttonStart.alignmentX = CENTER_ALIGNMENT
        buttonStart.addActionListener { startGame(menuPanel) }

        menuPanel.add(titleLabel)
        menuPanel.add(Box.createVerticalStrut(30))
        menuPanel.add(buttonStart)

        add(menuPanel)
        setSize(400, 300)
        setLocationRelativeTo(null)
        defaultCloseOperation = EXIT_ON_CLOSE
        title = "Campo Minado"
        isVisible = true
    }

    private fun startGame(menuPanel: JPanel) {
        contentPane.remove(menuPanel)
        tabuleiro?.let {
            remove(painelTabuleiro)
        }
        timer?.cancel()

        tabuleiro = Tabuleiro(16, 30, 40)
        painelTabuleiro = PainelTabuleiro(tabuleiro!!)
        labelTimer = JLabel("Tempo restante: 120s", SwingConstants.CENTER)
        labelTimer.font = Font("Arial", Font.BOLD, 24)
        labelTimer.foreground = Color.WHITE
        labelTimer.background = Color(60, 63, 65)
        labelTimer.isOpaque = true

        tabuleiro?.onEvento(this::mostrarResultado)
        setupUI()
        iniciarTimer()

        revalidate()
        repaint()
    }

    private fun setupUI() {
        layout = BorderLayout()
        labelTimer.font = Font("Arial", Font.BOLD, 20)
        add(labelTimer, BorderLayout.NORTH)
        add(painelTabuleiro, BorderLayout.CENTER)

        setSize(1000, 700)
        setLocationRelativeTo(null)
        defaultCloseOperation = EXIT_ON_CLOSE
        title = "Campo Minado"
        isVisible = true
    }

    private fun iniciarTimer() {
        pararTimer()
        timer = Timer()
        timer?.scheduleAtFixedRate(object : TimerTask() {
            override fun run() {
                SwingUtilities.invokeLater {
                    tempoRestante--
                    labelTimer.text = "Tempo restante: ${tempoRestante}s"
                    if (tempoRestante <= 0) {
                        timer?.cancel()
                        mostrarResultado(TabuleiroEvento.DERROTA)
                    }
                }
            }
        }, 1000, 1000)
    }

    private fun pararTimer() {
        timer?.cancel()
        timer = null
    }

    private fun resetTimer() {
        pararTimer()
        tempoRestante = 120
        labelTimer.text = "Tempo restante: ${tempoRestante}s"
        iniciarTimer()
    }

    private fun mostrarResultado(evento: TabuleiroEvento) {
        SwingUtilities.invokeLater {
            val msg: String
            val iconPath: String
            val title: String

            when (evento) {
                TabuleiroEvento.VITORIA -> {
                    msg = "<html><h2 style='color:green;'>Muito bem, salvamos o oceano!</h2></html>"
                    iconPath = "src/img/golfinho.png" // Atualize o caminho da imagem conforme necessário
                    title = "Vitória"
                }
                TabuleiroEvento.DERROTA -> {
                    msg = "<html><h2 style='color:red;'>Oh não, o mar foi contaminado!</h2></html>"
                    iconPath = "src/img/tartaruga.png" // Atualize o caminho da imagem conforme necessário
                    title = "Derrota"
                }
                TabuleiroEvento.TEMPO_ESGOTADO -> {
                    msg = "<html><h2 style='color:orange;'>O tempo acabou!</h2></html>"
                    iconPath = "src/img/tempoesgotado.png"
                    title = "Tempo Esgotado"
                }
            }

            val icon = ImageIcon(iconPath)
            val scaledIcon = ImageIcon(icon.image.getScaledInstance(300, 300, Image.SCALE_SMOOTH))
            val iconLabel = JLabel(scaledIcon)

            val panel = JPanel(BorderLayout(10, 10))
            val messageLabel = JLabel(msg)
            messageLabel.font = Font("Arial", Font.BOLD, 20)
            messageLabel.horizontalAlignment = SwingConstants.CENTER

            val buttonOk = JButton("OK")
            buttonOk.font = Font("Arial", Font.BOLD, 16)
            buttonOk.background = Color(0, 100, 255)
            buttonOk.foreground = Color.WHITE
            buttonOk.isOpaque = true
            buttonOk.border = BorderFactory.createEmptyBorder(10, 20, 10, 20)
            buttonOk.addActionListener {
                (panel.topLevelAncestor as JDialog).dispose()
            }

            val buttonPanel = JPanel()
            buttonPanel.add(buttonOk)

            panel.add(messageLabel, BorderLayout.NORTH)
            panel.add(iconLabel, BorderLayout.CENTER)
            panel.add(buttonPanel, BorderLayout.SOUTH)

            val dialog = JOptionPane(panel, JOptionPane.PLAIN_MESSAGE, JOptionPane.DEFAULT_OPTION)
            dialog.setOptions(arrayOf<Any>())
            val window = dialog.createDialog(this, title)
            window.isVisible = true

            tabuleiro?.reiniciar()
            painelTabuleiro?.repaint()
            painelTabuleiro?.validate()
            resetTimer()
        }
    }

    private fun setIconImage() {
        try {
            val img = ImageIcon("src/img/minado.png").image
            iconImage = img
        } catch (ex: Exception) {
            ex.printStackTrace()
        }
    }
}
