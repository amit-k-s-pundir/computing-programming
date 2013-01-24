public class Main{

	interface Shape{
		void draw();
	}
	class Rectangle implements Shape{
		public Rectangle(){
		}
		public void draw(){
			System.out.println("Drawing Rectangle");
		}
	}

	class Circle implements Shape{
		public Circle(){
		}
		public void draw(){
			System.out.println("Drawing Circle");
		}
	}
	class Draw<T extends Shape>{
		public Draw(){
		}
		public void draw(T t){
			t.draw();
		}
	}

	public static void main(String[] args){
		(new Draw<Rectangle>()).draw();
		(new Draw<Circle>()).draw();
	}
}
