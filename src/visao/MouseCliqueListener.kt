package visao

import modelo.Campo
import java.awt.event.MouseAdapter
import java.awt.event.MouseEvent

class MouseCliqueListener(
    private val campo: Campo,
    private val onLeftClick: (Campo) -> Unit,
    private val onRightClick: (Campo) -> Unit
) : MouseAdapter() {
    override fun mousePressed(e: MouseEvent) {
        when (e.button) {
            MouseEvent.BUTTON1 -> onLeftClick(campo)
            MouseEvent.BUTTON3 -> onRightClick(campo)
        }
    }
}
