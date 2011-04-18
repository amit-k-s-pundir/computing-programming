public class MyClass<T implements Serializable) {
   Class<T> ct; 
   public MyClass(Class<T> ct){this.ct = ct;}

   void function() {
       ... //you know what the class is here
   }
}
