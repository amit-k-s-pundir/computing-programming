package utils;

public interface F<A,B>{
	public B f(A a);
}

public interface F2<A,B,C>{
	public C f(A a, B b);
}
