(defun gen-basic-java-applet (class-name)
  (format "%s" 
          '
import java.awt.FlowLayout;
import java.lang.reflect.InvocationTargetException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JApplet;
import javax.swing.JButton;
import javax.swing.SwingUtilities;
import javax.swing.UIManager;


/**
 * A very simple applet.
 */
@SuppressWarnings("serial")
public class SwingApplet extends JApplet {

    JButton button;

    private void initUI() {
        // Trying to set Nimbus look and feel
        try {
            UIManager.setLookAndFeel("javax.swing.plaf.nimbus.NimbusLookAndFeel");
        } catch (Exception ex) {
            Logger.getLogger(SwingApplet.class.getName()).
                    log(Level.SEVERE, "Failed to apply Nimbus look and feel", ex);
        }
        getContentPane().setLayout(new FlowLayout());
        button = new JButton("Hello, I\\'m a Swing Button!");
        getContentPane().add(button);
        getContentPane().doLayout();
    }

    @Override
    public void init() {
        try {
            SwingUtilities.invokeAndWait(new Runnable() {

                @Override
                public void run() {
                    initUI();
                }
            });
        } catch (InterruptedException ex) {
            Logger.getLogger(SwingApplet.class.getName()).
                    log(Level.SEVERE, null, ex);
        } catch (InvocationTargetException ex) {
            Logger.getLogger(SwingApplet.class.getName()).
                    log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void stop() {
        if (button != null) {
            getContentPane().remove(button);
            button = null;
        }
    }
}
'  ))
