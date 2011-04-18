public class Main{

	public Main(){};
	 abstract class Shape{
		 abstract void draw();
		}
	
	 class Rectangle extends Shape{
		/*public Rectangle(){
		  }*/
		 public Rectangle(){};
		 void draw(){
			System.out.println("Drawing Rectangle");
		}
	}

	 class Circle extends Shape{
		/*		public Circle(){
				}*/
		 public Circle(){};
		 void draw(){
			System.out.println("Drawing Circle");
		}
	}
	  class Draw<T extends Shape> {
		/*	public Draw(){
			}*/
		  T t;
		  public Draw(T t){this.t = t;};
		 void draw(){
			 t.draw();
		}
	 }

	public static void main(String[] args){
		//		(new Draw<Rectangle>()).draw((new Main.Rectangle()));
		//		(new Draw<Circle>()).draw((new Main()).new Circle());
		Main x = new Main();
		x.new Draw<Rectangle>(x.new Rectangle()).draw();
	}
}
