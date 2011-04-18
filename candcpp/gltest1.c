#include <GL/gl.h>
#include <GL/glu.h>
#include "aux.h"

void display (void)
{
    glClear(GL_COLOR_BUFFER_BIT);
    glColor3f (1.0, 1.0, 1.0);
    glLoadIdentity ();             /* clear the matrix */
    glTranslatef (0.0, 0.0, -5.0); /* viewing transformation */
    glScalef (1.0, 2.0, 1.0);      /* modeling transformation */
    auxWireCube(1.0);    /*  draw the cube */
    glFlush();
}

void myinit (void) 
{
    glShadeModel (GL_FLAT);
}

void myReshape(GLsizei w, GLsizei h)
{
    glMatrixMode (GL_PROJECTION);    /* prepare for and then */ 
    glLoadIdentity ();               /* define the projection */
    glFrustum (-1.0, 1.0, -1.0, 1.0, /* transformation */
                   1.5, 20.0); 
    glMatrixMode (GL_MODELVIEW);  /* back to modelview matrix */
    glViewport (0, 0, w, h);      /* define the viewport */
}


int main(int argc, char** argv)
{
    auxInitDisplayMode (AUX_SINGLE | AUX_RGBA);
    auxInitPosition (0, 0, 500, 500);
    auxInitWindow (argv[0]);
    myinit ();
    auxReshapeFunc (myReshape);
    auxMainLoop(display);
}
