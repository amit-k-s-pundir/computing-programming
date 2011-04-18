    class Seq<T> { 
       T head; 
       Seq<T> tail; 
       Seq() { this(null, null); } 
       boolean isEmpty() { return tail == null; }

	   Seq(T head, Seq<T> tail) { this.head = head; this.tail = tail; }

	   class Zipper<S> { 
                    Seq<Pair<T,S>> zip(Seq<S> that) { 
                            if (this.isEmpty() || that.isEmpty())
                                    return new Seq<Pair<T,S>>(); 
                            else 
                                    return new Seq<Pair<T,S>>( 
                                            new Pair<T,S>(this.head, that.head), 
                                            this.tail.zip(that.tail));
                    }
       }
    }

    class Pair<T, S> {
            T fst; S Snd;

			Pair(T f, S s) {fst = f; snd = s;}
    }
    
    class Client {
            {
                    Seq<String> strs = 
                    new Seq<String>("a", new Seq<String>("b", 
                                            new Seq<String>()));
                    Seq<Number> nums = 
                            new Seq<Number>(new Integer(1), 
                                             new Seq<Number>(new Double(1.5), 
                                                                                                            new Seq<Number>()));
                    Seq<String>.Zipper<Number> zipper = 
                                            strs.new Zipper<Number>();
                    Seq<Pair<String,Number>> combined = zipper.zip(nums);
            }
    }
