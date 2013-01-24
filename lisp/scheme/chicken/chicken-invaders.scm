 ;;;; gtkhello.scm

 (require-extension easyffi)

 ;; Include this code directly into generated .c file:

 (foreign-declare "#include <gtk/gtk.h>")

 ;; Parse declarations and generate Scheme bindings:

 (foreign-parse "
 const int GTK_WINDOW_TOPLEVEL;

 void gtk_main_quit();
 void gtk_init(int *, char ***);
 GtkWidget *gtk_window_new(int);
 int g_signal_connect(void *, char *, void *, void *);
 int g_signal_connect_swapped(void *, char *, void *, void *);
 void gtk_container_set_border_width(GtkContainer *, int);
 GtkWidget *gtk_button_new_with_label(char *);
 void gtk_widget_destroy(GtkWidget *);
 void gtk_container_add(GtkContainer *, GtkWidget *);
 void gtk_widget_show(GtkWidget *);

 /* the ___safe marker is needed, because gtk_main() may
   (and will) call Scheme callbacks. */
 ___safe void gtk_main();
 ")


 ;; Define a few callback function:

 (define-external (hello ((pointer "GtkWidget") widget) 
			 (c-pointer data)) 
   void
   (print "Hello, world") )

 (define-external (delete_event ((pointer "GtkWidget") widget)
				((pointer "GdkEvent") event)
				(c-pointer data) )
   bool
   (print "Delete event occured")
   #t)

 (define-external (destroy ((pointer "GtkWidget") widget)
			   (c-pointer data) )
   void
   (gtk_main_quit) )

 ;; This is a bit ugly, but there is no elegant way to get
 ;; at argc/argv at the Scheme level and pass pointers to it
 ;; to foreign code:

 (foreign-code "gtk_init(&C_main_argc, &C_main_argv);")

 (define window (gtk_window_new GTK_WINDOW_TOPLEVEL))

 ;; #$... with a callback-name returns the function pointer:

 (g_signal_connect window "delete_event" #$delete_event #f)
 (g_signal_connect window "destroy" #$destroy #f)

 (gtk_container_set_border_width window 10)

 (define button (gtk_button_new_with_label "Hello World"))

 (g_signal_connect button "clicked" #$hello #f)

 ;; Here we use foreign-value to get the function pointer.
 ;; #$gtk_widget_destroy wouldn't work: the function is not
 ;; a callback:

 (g_signal_connect_swapped button "clicked" 
   (foreign-value gtk_widget_destroy c-pointer) window)

 (gtk_container_add window button)
 (gtk_widget_show button)
 (gtk_widget_show window)
 (gtk_main)

;;To compile it, we have to ensure the proper C compiler and linker flags are passed:

;;$ csc -vk gtkhello.scm -C "`pkg-config --cflags gtk+-2.0`" -L "`pkg-config --libs gtk+-2.0`" -X easyffi
