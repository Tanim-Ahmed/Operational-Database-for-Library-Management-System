#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#include <stdlib.h>
#include <math.h>
#include <iostream>
#include "RGBpixmap.cpp"

using namespace std;
static int slices = 16;
static int stacks = 16;
RGBpixmap pix[6];

float xx=0;
float yy=-10;
float zz=0;
float M=0.0;
float x_co=0.0,y_co=-2.0,z_co=0.0;
float ex=0,ey=0,ez=10,cx=0,cy=0,cz=0,hx=0,hy=1,hz=0;
float winW,winH;


const GLfloat light_ambient[]  = { .1f, .1f, .1f, 1.0f };
const GLfloat light_diffuse[]  = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat light_specular[] = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat light_position[] = { 0.0f, 5.0f, -15.0f, 0.0f };
const GLfloat light_position2[] = { 0.0f, 5.0f, 15.0f, 0.0f };

const GLfloat light_ambient1[]  = { .1f, .1f, .1f, 1.0f };
const GLfloat light_diffuse1[]  = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat light_specular1[] = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat light_position_spot[] = { 0.0f, 10.0f, 5.0f, 1.0f };
const GLfloat spot_direction[]={0,-5.0,-5.0f};
const GLfloat no_light[] = {0.0f,0.0f,0.0f,1.0f};

const GLfloat light_ambient_3[]  = { .1f, .1f, .1f, 1.0f };
const GLfloat light_diffuse_3[]  = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat light_specular_3[] = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat light_position_3[] = { .0f, 5.0f, -5.0f, 0.0f };




static void resize(int width, int height)
{   winW=width;
    winH=height;
    //const float ar = ((float) width/2.0) / (float) height;
    const float ar = (float) width / (float) height;

    glViewport(0, 0, width, height);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glFrustum(-ar, ar, -1.0, 1.0, 2.0, 100.0);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity() ;
}

void halfCircle(float r);

void owns(GLfloat sx,GLfloat sy, GLfloat sz)
{
    GLfloat s[16]={sx,0,0,0,
                    0,sy,0,0,
                    0,0,sz,0,
                    0,0,0,1
                    };
    glMatrixMode(GL_MATRIX_MODE);
    glMultMatrixf(s);
}


void flooring()
{
    //glColor3f(0.9f, 0.9f, 0.9f);
	glBegin(GL_QUADS);
		glVertex3f(-100.0f, 0.0f, -100.0f);
		glVertex3f(-100.0f, 0.0f,  100.0f);
		glVertex3f( 100.0f, 0.0f,  100.0f);
		glVertex3f( 100.0f, 0.0f, -100.0f);

		glVertex3d(-60,0,-20);
		glVertex3d(100,0,-20);
		glVertex3d(100,300,-20);
		glVertex3d(-60,300,-20);

		glVertex3d(60,0,-100);
		glVertex3d(60,0,100);
		glVertex3d(60,300,100);
		glVertex3d(60,300,-100);
	glEnd();
}

void mainBody()
{
    glPushMatrix();

     GLfloat mat_ambient[]    = { 0.0f, .0f, .0f, 1.0f };
     GLfloat mat_diffuse[]    = { 1.0f, 1.0f, 0.0f, 1.0f };
     GLfloat mat_specular[]   = { 1.0f, 1.0f, 0.0f, 1.0f };
     GLfloat high_shininess[] = { 100.0f };

        glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
        glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
        glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
        glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);
    glPopMatrix();

    glBegin(GL_QUADS);
        //front

        //glColor3d(1,0,1);
        glVertex3f(2,6,5);
        glVertex3f(7,6,5);
        glVertex3f(7,11,5);
        glVertex3f(2,9,5);

        //glColor3d(1,0,1);
        glVertex3f(2,6,5);
        glVertex3f(2,6,0);
        glVertex3f(2,9,0);
        glVertex3f(2,9,5);

        //glColor3d(0,0,1);
        glVertex3f(7,6,5);
        glVertex3f(2,6,5);
        glVertex3f(2,9,5);
        glVertex3f(7,11,5);

        //back
        //glColor3d(1,0,1);
        glVertex3f(7,6,0);
        glVertex3f(2,6,0);
        glVertex3f(2,9,0);
        glVertex3f(7,11,0);
    glPushMatrix();

        mat_ambient[0]=0.0f,mat_ambient[1]=0.0f,mat_ambient[2]=0,mat_ambient[3]=1.0f;
        mat_diffuse[0]=.0f,mat_diffuse[1]=1.0f,mat_diffuse[2]=0,mat_diffuse[3]=1.0f;
        mat_specular[0]=.0f,mat_specular[1]=1.0f,mat_specular[2]=0,mat_specular[3]=1.0f;
        high_shininess[0] = { 100.0f };

        glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
        glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
        glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
        glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);
    glPopMatrix();
        //glColor3d(1,0,0);
        glVertex3f(2,6,0);
        glVertex3f(7,6,0);
        glVertex3f(7,11,0);
        glVertex3f(2,9,0);
        //top
    glPushMatrix();

        mat_ambient[0]=.0,mat_ambient[1]=.0,mat_ambient[2]=0,mat_ambient[3]=1.0f;
        mat_diffuse[0]=1.0,mat_diffuse[1]=1,mat_diffuse[2]=.0,mat_diffuse[3]=1.0f;
        mat_specular[0]=1.0,mat_specular[1]=1,mat_specular[2]=.0,mat_specular[3]=1.0f;
        high_shininess[0] = { 100.0f };

        glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
        glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
        glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
        glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);
    glPopMatrix();
        //glColor3d(0,1,0);
        glVertex3f(2,9,0);
        glVertex3f(2,9,5);
        glVertex3f(5,10.25,5);
        glVertex3f(5,10.25,0);
        //left
        //glColor3d(1,0,0);
        glVertex3f(2,6,0);
        glVertex3f(2,6,5);
        glVertex3f(2,9,5);
        glVertex3f(2,9,0);
        //bottom
        //glColor3d(1,1,0);
        glVertex3f(2,6,0);
        glVertex3f(7,6,0);
        glVertex3f(7,6,5);
        glVertex3f(2,6,5);

        //glColor3d(1,1,0);
        glVertex3f(2,6,0);
        glVertex3f(2,6,5);
        glVertex3f(7,6,5);
        glVertex3f(7,6,0);

    glEnd();

    // quad body starts here

    glBegin(GL_QUADS);
        //front
        //glColor3d(1,0,1);
        glVertex3f(7,6,5);
        glVertex3f(10,6,5);
        glVertex3f(10,11,5);
        glVertex3f(7,11,5);

        //glColor3d(1,0,0);
        glVertex3f(10,6,5);
        glVertex3f(7,6,5);
        glVertex3f(7,11,5);
        glVertex3f(10,11,5);
        //back
        //glColor3d(1,0,1);
        glVertex3f(10,6,0);
        glVertex3f(7,6,0);
        glVertex3f(7,11,0);
        glVertex3f(10,11,0);

    glPushMatrix();

        mat_ambient[0]=.0,mat_ambient[1]=0,mat_ambient[2]=0,mat_ambient[3]=1.0f;
        mat_diffuse[0]=1.0,mat_diffuse[1]=0.0,mat_diffuse[2]=0,mat_diffuse[3]=1.0f;
        mat_specular[0]=1.0,mat_specular[1]=0.0,mat_specular[2]=0,mat_specular[3]=1.0f;
        high_shininess[0] = { 100.0f };

        glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
        glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
        glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
        glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);
    glPopMatrix();
        //glColor3d(0,0,1);
        glVertex3f(7,6,0);
        glVertex3f(10,6,0);
        glVertex3f(10,11,0);
        glVertex3f(7,11,0);
        //right
        //glColor3d(1,0,0);
        glVertex3f(10,6,5);
        glVertex3f(10,6,0);
        glVertex3f(10,11,0);
        glVertex3f(10,11,5);

        //glColor3d(1,0,0);
        glVertex3f(10,6,0);
        glVertex3f(10,6,5);
        glVertex3f(10,11,5);
        glVertex3f(10,11,0);
        //top
    glPushMatrix();

        mat_ambient[0]=.0,mat_ambient[1]=0,mat_ambient[2]=0,mat_ambient[3]=1.0f;
        mat_diffuse[0]=1.0,mat_diffuse[1]=.0,mat_diffuse[2]=0,mat_diffuse[3]=1.0f;
        mat_specular[0]=1.0,mat_specular[1]=.0,mat_specular[2]=0,mat_specular[3]=1.0f;
        high_shininess[0] = { 100.0f };

        glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
        glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
        glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
        glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);
    glPopMatrix();
        //glColor3d(0,1,0);
        glVertex3f(7,11,0);
        glVertex3f(7,11,5);
        glVertex3f(10,11,5);
        glVertex3f(10,11,0);
        //bottom
        //glColor3d(10,10,0);
        glVertex3f(7,6,0);
        glVertex3f(10,6,0);
        glVertex3f(10,6,5);
        glVertex3f(7,6,5);

        //glColor3d(100,100,0);
        glVertex3f(7,6,0);
        glVertex3f(7,6,5);
        glVertex3f(10,6,5);
        glVertex3f(10,6,0);

    glEnd();

}

void mainTail(float r,float g,float b)
{
    glPushMatrix();

    //const GLfloat material_light[] = {0.0,0.0,0.0,1.0};
    const GLfloat mat_ambient[]    = { 0.1f, 0.0f, 0.0f, 1.0f };
    const GLfloat mat_diffuse[]    = { r, g, b, 1.0f };
    const GLfloat mat_specular[]   = { r, g, b, 1.0f };
    const GLfloat high_shininess[] = { 100.0f };

        glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
        glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
        glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
        glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);
    glPopMatrix();

    glBegin(GL_QUADS);
        //front
        //glColor3d(1,0,0);
        glVertex3f(10,8,3.5);
        glVertex3f(14,8,3.5);
        glVertex3f(14,10,3.5);
        glVertex3f(10,10,3.5);
        //back
        //glColor3d(1,0,0);
        glVertex3f(14,8,1.5);
        glVertex3f(10,8,1.5);
        glVertex3f(10,10,1.5);
        glVertex3f(14,10,1.5);
        //right
        //glColor3d(1,0,0);
        glVertex3f(14,8,3.5);
        glVertex3f(14,8,1.5);
        glVertex3f(14,10,1.5);
        glVertex3f(14,10,3.5);
        //top
        //glColor3d(1,0,0);
        glVertex3f(10,10,3.5);
        glVertex3f(14,10,3.5);
        glVertex3f(14,10,1.5);
        glVertex3f(10,10,1.5);
        //bottom
        //glColor3d(1,0,0);
        glVertex3f(10,8,1.5);
        glVertex3f(14,8,1.5);
        glVertex3f(14,8,3.5);
        glVertex3f(10,8,3.5);

        //left
        //glColor3d(1,0,0);
        glVertex3f(10,8,1.5);
        glVertex3f(10,8,3.5);
        glVertex3f(10,10,3.5);
        glVertex3f(10,10,1.5);

    glEnd();
}

void lastTail()
{
    glPushMatrix();

    //const GLfloat material_light[] = {0.0,0.0,0.0,1.0};
    const GLfloat mat_ambient[]    = { 0.1f, 0.0f, 0.0f, 1.0f };
    const GLfloat mat_diffuse[]    = { 1.0f, 0.0f, 0.0f, 1.0f };
    const GLfloat mat_specular[]   = { 1.0f, 0.0f, 0.0f, 1.0f };
    const GLfloat high_shininess[] = { 100.0f };

        glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
        glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
        glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
        glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);
    glPopMatrix();
    glBegin(GL_QUADS);
        //front
        //glColor3d(1,1,0);
        glVertex3f(14,8,3.5);
        glVertex3f(18,12,3.5);
        glVertex3f(18,13,3.5);
        glVertex3f(14,10,3.5);
        //back
        //glColor3d(1,0,0);
        glVertex3f(18,12,1.5);
        glVertex3f(14,8,1.5);
        glVertex3f(14,10,1.5);
        glVertex3f(18,13,1.5);
        //right
        //glColor3d(1,0,0);
        glVertex3f(18,12,3.5);
        glVertex3f(18,12,1.5);
        glVertex3f(18,13,1.5);
        glVertex3f(18,13,3.5);
        //top
       // glColor3d(1,0,0);
        glVertex3f(14,10,1.5);
        glVertex3f(14,10,3.5);
        glVertex3f(18,13,3.5);
        glVertex3f(18,13,1.5);
        //bottom
        //glColor3d(1,0,0);
        glVertex3f(14,8,3.5);
        glVertex3f(14,8,1.5);
        glVertex3f(18,12,1.5);
        glVertex3f(18,12,3.5);

    glEnd();
}

void legAll()
{
    glPushMatrix();

//        glPushMatrix();
//
//    const GLfloat mat_ambient[]    = { .0f, 1.0f, 1.0f, 1.0f };
//    const GLfloat mat_diffuse[]    = { 1.0f, 1.0f, 1.0f, 1.0f };
//    const GLfloat mat_specular[]   = { 1.0f, 1.0f, 1.0f, 1.0f };
//    const GLfloat high_shininess[] = { 100.0f };
//
//        glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
//        glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
//        glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
//        glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);
//    glPopMatrix();


        glTranslated(-2.5,3,-.75);
        glScaled(.75,.2,.5);
        mainTail(1,1,1);
        glTranslated(0,0,8);
        mainTail(1,1,1);
        //back foot
        glTranslated(6,-30,1.5);
        glScaled(.5,5,.4);
        mainTail(1,1,1);
        //front foot
        glTranslated(0,0,-20);
        mainTail(1,1,1);
    glPopMatrix();

}
void drawBackHalfCircle()
{
        glPushMatrix();
            glTranslated(13.4,-29,10.5);
            glScaled(1,3,1);
            glRotated(90,0,1,0);
            halfCircle(.9);
        glPopMatrix();
}
static int speed=180;
void upperFan()
{
    const double t = glutGet(GLUT_ELAPSED_TIME) / 1000.0;
    const double a = t*speed;
    //drawing upper fans

//    glPushMatrix();
//        for(float i=0.0;i<3.1416;i+=.01){
//            glRotated(a,0,0,1);
//            glTranslated(cos(i),cos(i),0);
//            backFan();
//        }
//    glPopMatrix();

    glPushMatrix();

        glTranslated(8,0,2.25);
        glRotated(a,0,1,0);
        glTranslated(-8,0,-2.25);
        glTranslated(-10,12,1);
        glScaled(1.5,.2,.5);
        mainTail(1,0,0);
        glTranslated(10.25,0,-10);
        glScaled(.15,1,5);
        mainTail(1,0,0);
    glPopMatrix();

    glPushMatrix();
    float r=.1;
    float h=1,x=8,z=2;
//    glBegin(GL_POLYGON);
//    for (float i = 0; i <= 2*3.1416; i += 0.001){
//        glVertex3f(x+(cos(i)*r), 14,z+(sin(i)*r));
//    }
//    glEnd();

//    glBegin(GL_POLYGON);
//    for (float i = 2*3.1416; i >= 0; i -= 0.001){
//        glVertex3f(x+(cos(i)*r), 14,z+(sin(i)*r));
//    }
//    glEnd();
//     glColor3d(1,0,0);

        ///stand
        glBegin(GL_POLYGON);
    for (float i = 0; i <= 2*3.1416; i += 0.001){
       glVertex3f(x+(cos(i)*r),11,z+(sin(i)*r));
       glVertex3f(x+(cos(i)*r),14,z+(sin(i)*r));
    }
        glEnd();
        glPopMatrix();

    //half circle
    glPushMatrix();
        glTranslated(8,0,2.25);
        glRotated(a,0,1,0);
        glTranslated(-8,0,-2.25);
        halfCircle(.45);

        glTranslated(16.13,0,4.35);
        glRotated(-180,0,1,0);
        halfCircle(.45);

        glTranslated(9.8,0,-6);
        glRotated(-90,0,1,0);
        halfCircle(.45);

        glTranslated(16.1,0,3.4);
        glRotated(180,0,1,0);
        halfCircle(.45);
    glPopMatrix();
    drawBackHalfCircle();
}
void backFan()
{
        const double t = glutGet(GLUT_ELAPSED_TIME) / 1000.0;
        const double a = t*speed;
    glPushMatrix();
        glTranslated(18,12.5,0);
        glRotated(a,0,0,1);
        glTranslated(-18,-12.5,0);
        glTranslated(12,13,-.5);
        glScaled(.5,.2,.5);
        glRotated(90,1,0,0);
        //glColor3d(1,1,0);
        mainTail(1,0,0);
        glTranslated(10.25,0,-10);
        glScaled(.15,1,5);
        mainTail(1,0,0);

    glPopMatrix();
}

void wall_table()
{

    glPushMatrix();
    //glutSolidCube(10);

     GLfloat mat_ambient[]    = { .0f, .1f, .0f, 1.0f };
     GLfloat mat_diffuse[]    = { .6f, 0.6f, 0.6f, 1.0f };
     GLfloat mat_specular[]   = { 1.0f, 1.0f, 1.0f, 1.0f };
     GLfloat high_shininess[] = { 50.0f };

        glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
        glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
        glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
        glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);

    //glutSolidCube(10);
    glPopMatrix();

    glBindTexture(GL_TEXTURE_2D, 2);
    glEnable(GL_TEXTURE_2D);
    glBegin(GL_QUADS);
    //back wall
//    mat_ambient[0]=.1,mat_ambient[1]=.0,mat_ambient[2]=.05,mat_ambient[3]=1.0f;
//    mat_diffuse[0]=.1,mat_diffuse[1]=0.0,mat_diffuse[2]=.5,mat_diffuse[3]=1.0f;
//    mat_specular[0]=.1,mat_specular[1]=0.0,mat_specular[2]=.5,mat_specular[3]=1.0f;
//    glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
//    glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
//    glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
//    glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);


    glVertex3d(-25,-6,-10);
    glVertex3d(35,-6,-10);
    glVertex3d(35,40,-10);
    glVertex3d(-25,40,-10);

    glVertex3d(35,-6,-10);
    glVertex3d(-25,-6,-10);
    glVertex3d(-25,40,-10);
    glVertex3d(35,40,-10);

    //left right wall
//    mat_ambient[0]=.1,mat_ambient[1]=.0,mat_ambient[2]=.1,mat_ambient[3]=1.0f;
//    mat_diffuse[0]=.6,mat_diffuse[1]=0.6,mat_diffuse[2]=.6,mat_diffuse[3]=1.0f;
//    mat_specular[0]=1,mat_specular[1]=1.0,mat_specular[2]=1,mat_specular[3]=1.0f;
//    glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
//    glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
//    glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
//    glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);

//    glVertex3d(-35,-6,10);
//    glVertex3d(-25,-6,-10);
//    glVertex3d(-25,40,-10);
//    glVertex3d(-35,40,10);

//    glVertex3d(-40,-6,10);
//    glVertex3d(-35,-6,10);
//    glVertex3d(-35,40,10);
//    glVertex3d(-40,40,10);
//
//    glVertex3d(-30,-6,-10);
//    glVertex3d(-35,-6,10);
//    glVertex3d(-35,40,10);
//    glVertex3d(-30,40,-10);
//
//    glVertex3d(-25,-6,-10);
//    glVertex3d(-30,-6,-10);
//    glVertex3d(-30,40,-10);
//    glVertex3d(-25,40,-10);
//

  //left wall
    //from below
    glVertex3d(-35,-6,10);
    glVertex3d(-25,-6,-10);
    glVertex3d(-25,10,-10);
    glVertex3d(-35,10,10);
    //from front
    glVertex3d(-35,-6,10);
    glVertex3d(-32,-6,5);
    glVertex3d(-32,40,5);
    glVertex3d(-35,40,10);
    //from top
    glVertex3d(-35,25,10);
    glVertex3d(-25,25,-10);
    glVertex3d(-25,40,-10);
    glVertex3d(-35,40,10);
    //from back
    glVertex3d(-30,-6,-10);
    glVertex3d(-25,-6,-10);
    glVertex3d(-25,40,-10);
    glVertex3d(-30,40,-10);

//    glVertex3d(-25,-6,-10);
//    glVertex3d(-35,-6,10);
//    glVertex3d(-35,40,10);
//    glVertex3d(-25,40,-10);

    glVertex3d(35,-6,-10);
    glVertex3d(45,-6,10);
    glVertex3d(45,40,10);
    glVertex3d(35,40,-10);

    glVertex3d(45,-6,10);
    glVertex3d(35,-6,-10);
    glVertex3d(35,40,-10);
    glVertex3d(45,40,10);

    glEnd();
    glDisable(GL_TEXTURE_2D);

    glPushMatrix();
    glTranslated(0,0,-26);
    glTranslated(0,-10,0);
    glRotated(-20,0,0,1);
    //back scene
    glBindTexture(GL_TEXTURE_2D, 5);
    glEnable(GL_TEXTURE_2D);
    glBegin(GL_QUADS);

    glVertex3d(-35,2,15);
    glVertex3d(-35,2,-45);
    glVertex3d(-75,2,-45);
    glVertex3d(-55,2,15);

    glEnd();
    glDisable(GL_TEXTURE_2D);
    glPopMatrix();

    glBindTexture(GL_TEXTURE_2D, 3);
    glEnable(GL_TEXTURE_2D);
    glBegin(GL_QUADS);
    //floor
//    mat_ambient[0]=.1,mat_ambient[1]=.0,mat_ambient[2]=.1,mat_ambient[3]=1.0f;
//    mat_diffuse[0]=1,mat_diffuse[1]=1.0,mat_diffuse[2]=1.0,mat_diffuse[3]=1.0f;
//    mat_specular[0]=1,mat_specular[1]=1.0,mat_specular[2]=1,mat_specular[3]=1.0f;
//    glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
//    glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
//    glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
//    glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);




    glVertex3d(-35,-6,10);
    glVertex3d(45,-6,10);
    glVertex3d(35,-6,-10);
    glVertex3d(-25,-6,-10);

    glVertex3d(45,-6,10);
    glVertex3d(-35,-6,10);
    glVertex3d(-25,-6,-10);
    glVertex3d(35,-6,-10);

    glEnd();
    glDisable(GL_TEXTURE_2D);
    //table
    glPushMatrix();

    glBindTexture(GL_TEXTURE_2D, 4);
    glEnable(GL_TEXTURE_2D);

    glPushMatrix();
        glTranslated(-72,3.5,-10);
        glScaled(6,.1,5);
        mainTail(1,1,1);
    glPopMatrix();

    glPushMatrix();
        glTranslated(-15,-46,-5);
        glScaled(.5,5,3);
        mainTail(1,1,1);
    glPopMatrix();
    glPushMatrix();
        glTranslated(3,-46,-5);
        glScaled(.5,5,3);
        mainTail(1,1,1);
    glPopMatrix();
    glDisable(GL_TEXTURE_2D);
    glPopMatrix();
    //now 3 heads

    glTranslated(-3,0,0);

        mat_ambient[0]=.1,mat_ambient[1]=.0,mat_ambient[2]=.0,mat_ambient[3]=1.0f;
        mat_diffuse[0]=1.0,mat_diffuse[1]=0.0,mat_diffuse[2]=0.0,mat_diffuse[3]=1.0f;
        mat_specular[0]=1.0,mat_specular[1]=0.0,mat_specular[2]=0,mat_specular[3]=1.0f;
        high_shininess[0] = { 100.0f };

        glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
        glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
        glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
        glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);
    glPushMatrix();
        glTranslated(-2,9,3);
        glRotated(-120,1,0,1);
        glScaled(.5,2,.5);
        glutSolidSphere(3, 32, 32);
    glPopMatrix();
    glPushMatrix();
        glTranslated(-2,9,2);
        glRotated(120,0,0,1);
        glScaled(.5,2,.5);
        glutSolidSphere(3, 32, 32);
    glPopMatrix();
    glPushMatrix();
        glTranslated(-2,9,2);
        glRotated(120,1,0,0);
        glScaled(.5,2,.5);
        glutSolidSphere(3, 32, 32);
    glPopMatrix();
    //now upper and lower 6 balls
    glPushMatrix();
        glTranslated(1.65,5.5,-.25);
        glutSolidSphere(1,32,32);
        glTranslated(-7,6.5,6.35);
        glutSolidSphere(1,32,32);
    glPopMatrix();

    glPushMatrix();
        glTranslated(-7,5.5,2);
        glutSolidSphere(1,32,32);
        glTranslated(10,6.5,0);
        glutSolidSphere(1,32,32);
    glPopMatrix();

    glPushMatrix();
        glTranslated(-2,6,7);
        glutSolidSphere(1,32,32);
        glTranslated(0,6,-10);
        glutSolidSphere(1,32,32);
    glPopMatrix();
}

void drawCube(){

    GLfloat mat_ambient[] = {0.7f, 0.7f, 0.7f, 1.0f};
	GLfloat mat_defused[] = {0.6f, 0.6f, 0.6f, 1.0f};
	GLfloat mat_specular[] = {1.0f, 1.0f, 1.0f, 1.0f};
	GLfloat mat_shininess[] = {50.0f};

	glMaterialfv(GL_FRONT, GL_AMBIENT, mat_ambient);
	glMaterialfv(GL_FRONT, GL_DIFFUSE, mat_defused);
	glMaterialfv(GL_FRONT, GL_SPECULAR, mat_specular);
	glMaterialfv(GL_FRONT, GL_SHININESS, mat_shininess);

    glPushMatrix();
    glTranslated(0,15,5);
    glScaled(2,2,2);
    glBindTexture(GL_TEXTURE_2D, 3);
    glEnable(GL_TEXTURE_2D);
    //glTexCoord2d(0,0);
    glutSolidCube(10);
    glDisable(GL_TEXTURE_2D);
    glPopMatrix();

}

void drawbox()
{
    GLfloat mat_ambient[] = {0.7f, 0.7f, 0.7f, 1.0f};
	GLfloat mat_defused[] = {0.6f, 0.6f, 0.6f, 1.0f};
	GLfloat mat_specular[] = {1.0f, 1.0f, 1.0f, 1.0f};
	GLfloat mat_shininess[] = {50.0f};

	glMaterialfv(GL_FRONT, GL_AMBIENT, mat_ambient);
	glMaterialfv(GL_FRONT, GL_DIFFUSE, mat_defused);
	glMaterialfv(GL_FRONT, GL_SPECULAR, mat_specular);
	glMaterialfv(GL_FRONT, GL_SHININESS, mat_shininess);

    glPushMatrix();
    glTranslated(0,20,5);
    glBindTexture(GL_TEXTURE_2D, 3);
    glEnable(GL_TEXTURE_2D);
    glBegin(GL_QUADS);
    glTexCoord2f(0,0); glVertex3d(-5,0,15);
    glTexCoord2f(1,0); glVertex3d(5,0, 15);
    glTexCoord2f(1,1); glVertex3d(5,5,15);
    glTexCoord2f(0,1); glVertex3d(-5,5,15);
    glEnd();
    glDisable(GL_TEXTURE_2D);
    glPopMatrix();
}

void drawAll()
{
    //flooring();
//    const GLfloat mat_diffuse[]    = { 1.0f, 1.0f, .0f, 1.0f };
//    glMaterialfv(GL_FRONT, GL_DIFFUSE, mat_diffuse);
    //drawCube();
    //drawbox();
    mainBody();
    mainTail(1,0,0);
    lastTail();
    legAll();
    upperFan();
    backFan();
    wall_table();
}

void halfCircle(float r)
{
    float h=1,x=8.05,z=4.55;

    glBegin(GL_POLYGON);
    for (float i = 0; i <= 3.1416; i += 0.001){
        glVertex3f(x+(cos(i)*r), 14,z+(sin(i)*r));
    }
    glEnd();
    glBegin(GL_POLYGON);
    for (float i = 3.1416; i >= 0; i -= 0.001){
        glVertex3f(x+(cos(i)*r), 14,z+(sin(i)*r));
    }
    glEnd();
     //glColor3d(1,0,0);
        glBegin(GL_POLYGON);

    for (float i = 0; i <= 3.1416; i += 0.001){
       glVertex3f(x+(cos(i)*r), 13.65,z+(sin(i)*r));
       glVertex3f(x+(cos(i)*r), 14,z+(sin(i)*r));
    }
    glEnd();
}

float lx=0.0,lz=0.0,pitch=0.0,yaw=0.0;
static void display(void)
{


    const double t = glutGet(GLUT_ELAPSED_TIME) / 1000.0;
    const double a = t*90.0;

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

   glPushMatrix();
    glViewport(0, 0, winW, winH);
    glPushMatrix();
        glTranslated(x_co+-1,y_co+0,z_co+-3);
        glRotated(xx,1,0,0);
        glRotated(yy,0,1,0);
        glRotated(zz,0,0,1);
        //glScalef(M+.15,M+.15,M+.15);
        owns(M+.15,M+.15,M+.15);
        drawAll();
        //drawRightHalfCircle();
        //drawLeftCircle();
        //glPushMatrix();

        //const GLfloat material_light[] = {0.0,0.0,0.0,1.0};
//        const GLfloat mat_ambient[]    = { 0.1f, 0.1f, 0.1f, 1.0f };
//        const GLfloat mat_diffuse[]    = { 1.0f, .0f, 1.0f, 1.0f };
//        const GLfloat mat_specular[]   = { 1.0f, 1.0f, 1.0f, 1.0f };
//        const GLfloat high_shininess[] = { 100.0f };
//
//        glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
//        glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
//        glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
//        glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);

//        glTranslated(0,-5,0);
//        glutSolidSphere(6, 32, 32);
        //glPopMatrix();
    glPopMatrix();
glPopMatrix();


//glPushMatrix();
//
//glPushMatrix();
//    glViewport(winW/2, 0, winW/2,winH);
//        glTranslated(x_co+-1,y_co+0,z_co+-6);
//        glTranslated(0,0,5);
//        glRotated(xx,1,0,0);
//        glRotated(yy,0,1,0);
//        glRotated(zz,0,0,1);
//        //glScalef(M+.15,M+.15,M+.15);
//        owns(M+.15,M+.15,M+.15);
//        drawAll();
//        glPushMatrix();
//        //const GLfloat mat_ambient[]    = { 0.0f, 0.0f, 0.0f, 1.0f };
//        //const GLfloat mat_diffuse[]    = { 1.0f, 1.0f, 0.0f, 1.0f };
//        //const GLfloat mat_specular[]   = { 1.0f, 1.0f, 1.0f, 1.0f };
//        //const GLfloat high_shininess[] = { 100.0f };
//
//        glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
//        glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
//        glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
//        glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);
//
//
//        glTranslated(0,-5,0);
//        glutSolidSphere(6, 16, 16);
//        glPopMatrix();
//        //drawRightHalfCircle();
//        //drawLeftCircle();
//    glPopMatrix();
//glPopMatrix();


    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    //glTranslated(0,0,-5);
    gluLookAt(ex,ey,ez,cx,cy,cz,hx,hy,hz);
    //gluLookAt(0,0,2,0,1+sin(pitch*3.1416/180)+2+cos(pitch*3.1416/180),0,0,1,0);

   // gluLookAt(0,0,2,10*sin(yaw*3.1416/180)-10*cos(yaw*3.1416/180),0,0,0,1,0);
    //glTranslated(0,0,2);

    glutSwapBuffers();
}

float angle=0.0,dif=abs(cy-0),tmp1,tmp2,tmp3;
int ck=0,light_dis=0,light_dis_2=0;
static void key(unsigned char key, int x, int y)
{
    switch (key)
    {
        case 27 :
        case 'q':
            exit(0);
            break;

        case 'x': //anti-clock wise
            xx+=2.5;
            break;
        case 'y':
            yy+=2.5;
            break;
        case 'z':
            zz+=2.5;
            break;
        case 'X': //clock wise rotate
            xx-=2.5;
            break;
        case 'Y':
            yy-=2.5;
            break;
        case 'Z':
            zz-=2.5;
            break;
        case 'M': //boro korte
            M+=0.005;
            break;
        case 'm': //suto korte
            M-=0.005;
            break;
        case '1': //1 2 3 dile x y z axis a jabe
            x_co+=0.1;
            break;
        case '2':
            y_co+=0.1;
            break;
        case '3':
            z_co+=0.1;
            break;
        case '4': //4 5 6 dile -x -y -z axis a jabe
            x_co-=0.1;
            break;
        case '5':
            y_co-=0.1;
            break;
        case '6':
            z_co-=0.1;
            break;

        case 'a':
            ex-=.1;
            break;
        case 'A':
            ex+=.1;
            break;

        case 's':
            ey-=.1;
            break;
        case 'S':
            ey+=.1;
            break;

        case 'd':
            ez-=.1;
            break;
        case 'D':
            ez+=.1;
            break;

        case 'f':
            cx-=.1;
            break;
        case 'F':
            cx+=.1;
            break;

        case 'g':
            cy-=.1;
            break;
        case 'G':
            cy+=.1;
            break;

        case 'h':
            cz-=1;
            break;
        case 'H':
            cz+=1;
            break;

        case 'j':
            hx-=.1;
            break;
        case 'J':
            hx+=.1;
            break;

        case 'k':
            hy-=.1;
            break;
        case 'K':
            hy+=.1;
            break;

        case 'l':
            hz-=.1;
            break;

        case 'L':
            hz+=.1;
            break;
        case 'p': //rotate all around
            angle-=.1f;
            ex=10*sin(angle);
            ez=10*cos(angle);
            break;
        case 'P': //rotate all around
            angle+=.1f;
            ex=10*sin(angle);
            ez=10*cos(angle);
            break;
        case 'o': //roll
            angle-=.1f;
            //hx=sin(angle);
            //hy=cos(angle);
            hx=0*cos(angle)-1*sin(angle);
            hz=0*sin(angle)+1*cos(angle);
            break;
        case 'O': //roll
            angle+=.1f;
            //hx=sin(angle);
            //hy=cos(angle);
            hx=0*cos(angle)-1*sin(angle);
            hz=0*sin(angle)+1*cos(angle);
            break;
        case 'i': //pitch
            angle-=.1f;
            //cy=sin(angle);
            //cy=sin(angle)+cos(angle);
            cy=0*cos(angle)-1*sin(angle);
            cz=0*sin(angle)+1*cos(angle);
           // cz=
//            angle-=.1;
//            cx=sin(angle);
//            cz=cos(angle);
            break;

        case 'I': //pitch
            angle+=.1;
            //cy=sin(angle);
            //cy=sin(angle)+cos(angle);
            cy=0*cos(angle)-1*sin(angle);
            cz=0*sin(angle)+1*cos(angle);
            break;
        case 'u': //yaw
            angle-=.1;
            //cx=sin(angle);
            //cz=cos(angle);
            cx=cos(angle)+sin(angle);
            cz=-sin(angle)+cos(angle);
            break;
        case 'U': //yaw
            angle+=.1;
            //cx=sin(angle);
            //cz=cos(angle);
            cx=cos(angle)+sin(angle);
            cz=-sin(angle)+cos(angle);
            break;
        case 't'://zoom in out
            tmp1=cx-ex;
            tmp2=cy-ey;
            tmp3=cz-ez;
            ex+=tmp1/15;
            ey+=tmp2/15;
            ez+=tmp3/15;
            break;
        case 'T':
            tmp1=cx-ex;
            tmp2=cy-ey;
            tmp3=cz-ez;
            ex-=tmp1/15;
            ey-=tmp2/15;
            ez-=tmp3/15;
            break;
        case 'r':
            speed+=10;
            break;
        case '0'://for directional light
            if(light_dis==0){
                glDisable(GL_LIGHT0);
                glDisable(GL_LIGHT2);
                light_dis=1;
            }
            else if(light_dis==1){
                glEnable(GL_LIGHT0);
                glEnable(GL_LIGHT2);
                light_dis=0;
            }
//            if(light_dis==1 && light_dis_2==1){
//                glEnable(GL_LIGHT3);
//            }
            break;
        case '9'://for spot light
            if(light_dis_2==0){
                glDisable(GL_LIGHT1);
                light_dis_2=1;
            }
            else if(light_dis_2==1){
                glEnable(GL_LIGHT1);
                light_dis_2=0;
            }
            break;
//            if(light_dis==1 && light_dis_2==1){
//                glEnable(GL_LIGHT3);
//            }
//        case '+':
//            slices++;
//            stacks++;
//            break;
//
//        case '-':
//            if (slices>3 && stacks>3)
//            {
//                slices--;
//                stacks--;
//            }
//            break;
    }

    glutPostRedisplay();
}

static void idle(void)
{
    glutPostRedisplay();
}


void enable_texture(){

    pix[1].readBMPFile("C:\\Users\\Tanim Ahmed\\Desktop\\L3\\tt.bmp");
	pix[1].setTexture(2,1);
    pix[2].readBMPFile("C:\\Users\\Tanim Ahmed\\Desktop\\L3\\tt.bmp");
	pix[2].setTexture(3,1);
    pix[3].readBMPFile("C:\\Users\\Tanim Ahmed\\Desktop\\L3\\tt.bmp");
	pix[3].setTexture(4,1);
    pix[4].readBMPFile("C:\\Users\\Tanim Ahmed\\Desktop\\L3\\tt.bmp");
	pix[4].setTexture(5,1);
}

int main(int argc, char *argv[])
{
    glutInit(&argc, argv);
    glutInitWindowSize(940,680);
    glutInitWindowPosition(10,10);
    glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH);

    glutCreateWindow("Manik's Home");

    glutReshapeFunc(resize);
    glutDisplayFunc(display);
    glutKeyboardFunc(key);
    glutIdleFunc(idle);

    glClearColor(1,1,1,1);
    glEnable(GL_CULL_FACE);
    glCullFace(GL_BACK);

    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LESS);

    enable_texture();

    glEnable(GL_LIGHT0);
    glEnable(GL_NORMALIZE);
    glEnable(GL_LIGHTING);

    glLightfv(GL_LIGHT0,GL_AMBIENT,light_ambient);
    glLightfv(GL_LIGHT0,GL_DIFFUSE,light_diffuse);
    glLightfv(GL_LIGHT0,GL_SPECULAR,light_specular);
    glLightfv(GL_LIGHT0,GL_POSITION,light_position);

    //spot light starts here
    //glEnable(GL_LIGHT1);

    glLightfv(GL_LIGHT1,GL_AMBIENT,light_ambient1);
    glLightfv(GL_LIGHT1,GL_DIFFUSE,light_diffuse1);
    glLightfv(GL_LIGHT1,GL_SPECULAR,light_specular1);
    glLightfv(GL_LIGHT1,GL_POSITION,light_position_spot);
    glLightf(GL_LIGHT1,GL_SPOT_CUTOFF,90.0);
    glLightfv(GL_LIGHT1,GL_SPOT_DIRECTION,spot_direction);
    glLightf(GL_LIGHT1,GL_SPOT_EXPONENT,2);


    glEnable(GL_LIGHT2);

    glLightfv(GL_LIGHT2,GL_AMBIENT,light_ambient);
    glLightfv(GL_LIGHT2,GL_DIFFUSE,light_diffuse);
    glLightfv(GL_LIGHT2,GL_SPECULAR,light_specular);
    glLightfv(GL_LIGHT2,GL_POSITION,light_position2);

    //glEnable(GL_LIGHT3);
//    glLightfv(GL_LIGHT3,GL_AMBIENT,no_light);
//    glLightfv(GL_LIGHT3,GL_DIFFUSE,no_light);
//    glLightfv(GL_LIGHT3,GL_SPECULAR,no_light);
//    glLightfv(GL_LIGHT3,GL_POSITION,light_position);

    glutMainLoop();

    return EXIT_SUCCESS;
}
